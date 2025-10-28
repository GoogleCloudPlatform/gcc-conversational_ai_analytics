
import base64
import json
import os
import random
import time
import logging
import uuid
import functions_framework
import google.cloud.logging
import vertexai

from google.cloud import dialogflowcx_v3beta1 as cx
from vertexai.generative_models import GenerativeModel, GenerationConfig, HarmCategory, HarmBlockThreshold

# --- Configuration (Load from Environment Variables) ---
PROJECT_ID = os.environ.get("PROJECT_ID")
DFCX_LOCATION = os.environ.get("DFCX_LOCATION", "global")
DFCX_AGENT_ID = os.environ.get("DFCX_AGENT_ID")
GEMINI_MODEL_NAME = os.environ.get("GEMINI_MODEL_NAME", "gemini-1.5-flash-001")
MAX_TURNS = int(os.environ.get("MAX_TURNS", 10))
NUM_CONVERSATIONS = int(os.environ.get("NUM_CONVERSATIONS", 1))

# --- Setup Logging ---
client = google.cloud.logging.Client()
client.setup_logging(log_level=logging.INFO)

# --- Initialize Google Cloud Clients ---
try:
    vertexai.init(project=PROJECT_ID, location=DFCX_LOCATION)
    # Initialize DFCX Sessions Client
    if DFCX_LOCATION == "global":
        api_endpoint = "dialogflow.googleapis.com"
    else:
        api_endpoint = f"{DFCX_LOCATION}-dialogflow.googleapis.com"
    client_options = {"api_endpoint": api_endpoint}
    dfcx_client = cx.SessionsClient(client_options=client_options)

except Exception as e:
    logging.error(f"Failed to initialize Google Cloud clients: {e}")

# --- Simulation Scenarios ---
CUSTOMER_CONTEXTS = [
    "Platinum airline member, has an existing booking for 2 people to Hawaii tomorrow.",
    "New customer, no booking history, trying to book a flight for a large family (5 people).",
    "Business traveler, flies weekly, needs to change a flight for this afternoon.",
    "College student, booking a cheap flight for spring break, has a flexible schedule."
]
USER_PERSONALITIES = [
    "Calm and polite, very patient.",
    "Slightly confused and unsure what to ask.",
    "In a hurry, very direct and a bit impatient.",
    "Angry and frustrated, claims a previous agent gave them wrong information."
]
ISSUES = [
    "Needs to book a new one-way flight.",
    "Needs to change the date of an existing flight.",
    "Wants to add a bag to their booking.",
    "Wants to cancel a flight and get a full refund.",
    "Is asking about pet travel policies."
]


@functions_framework.cloud_event
def main(cloud_event):
    """
    Cloud Function trigger for Pub/Sub messages.
    """
    try:
        message_data = base64.b64decode(cloud_event.data["message"]["data"]).decode("utf-8")
        message_json = json.loads(message_data)
        num_conversations_to_run = int(message_json.get("num_conversations", NUM_CONVERSATIONS))
    except (TypeError, KeyError, json.JSONDecodeError):
        num_conversations_to_run = NUM_CONVERSATIONS

    logging.info(f"Triggered to run {num_conversations_to_run} conversation simulations.")

    for i in range(num_conversations_to_run):
        context = random.choice(CUSTOMER_CONTEXTS)
        personality = random.choice(USER_PERSONALITIES)
        issue = random.choice(ISSUES)
        simulation_id = f"sim-{int(time.time())}-{i}"

        logging.info(f"[{simulation_id}] Starting simulation {i + 1}/{num_conversations_to_run} with: "
                     f"Context: '{context}', Personality: '{personality}', Issue: '{issue}'")

        run_conversation_simulation(
            simulation_id=simulation_id,
            customer_context=context,
            user_personality=personality,
            issue=issue
        )
        time.sleep(2)


def run_conversation_simulation(simulation_id, customer_context, user_personality, issue):
    """
    Orchestrates the multi-turn conversation between Gemini and Dialogflow CX.
    """
    agent_path = f"projects/{PROJECT_ID}/locations/{DFCX_LOCATION}/agents/{DFCX_AGENT_ID}"
    session_id = str(uuid.uuid4())
    conversation_history = []

    try:
        system_prompt = f"""
        You are a simulated customer interacting with a virtual agent.
        Your persona: {user_personality}
        Your context: {customer_context}
        Your goal: {issue}
        Keep your responses short and natural.
        """
        gemini_model = GenerativeModel(GEMINI_MODEL_NAME, system_instruction=[system_prompt])
        chat = gemini_model.start_chat()

        # Get the initial welcome message from the agent
        agent_response_text, current_page = detect_dfcx_intent(
            agent_path=agent_path,
            session_id=session_id,
            text="hi"
        )
        conversation_history.append(f"AGENT: {agent_response_text}")
        logging.info(f"[{simulation_id}] Turn 1 (AGENT): {agent_response_text} (Page: {current_page})")

        # Generate the first user utterance based on the agent's welcome message
        logging.info(f"[{simulation_id}] Turn 1: Generating initial user utterance...")
        response = chat.send_message(
            f"The agent just said: \"{agent_response_text}\". What is your first response?",
            generation_config=GenerationConfig(temperature=0.8, max_output_tokens=512),
            safety_settings={
                HarmCategory.HARM_CATEGORY_HARASSMENT: HarmBlockThreshold.BLOCK_NONE,
                HarmCategory.HARM_CATEGORY_HATE_SPEECH: HarmBlockThreshold.BLOCK_NONE,
                HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: HarmBlockThreshold.BLOCK_NONE,
                HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: HarmBlockThreshold.BLOCK_NONE,
            }
        )
        if not response.candidates or not response.candidates[0].content.parts:
            logging.warning(f"[{simulation_id}] Gemini returned an empty first utterance. Ending simulation.")
            return
        user_utterance = response.text
        conversation_history.append(f"USER: {user_utterance}")
        logging.info(f"[{simulation_id}] Turn 2 (USER): {user_utterance}")

        for turn in range(2, MAX_TURNS + 1):
            agent_response_text, current_page = detect_dfcx_intent(
                agent_path=agent_path,
                session_id=session_id,
                text=user_utterance
            )
            conversation_history.append(f"AGENT: {agent_response_text}")
            logging.info(f"[{simulation_id}] Turn {turn} (AGENT): {agent_response_text} (Page: {current_page})")

            if "End" in current_page:
                logging.info(f"[{simulation_id}] Conversation ended at page: {current_page}.")
                break

            time.sleep(1)
            response = chat.send_message(
                f"AGENT just said: \"{agent_response_text}\". What is your next response?",
                generation_config=GenerationConfig(temperature=0.7, max_output_tokens=512),
                safety_settings={
                    HarmCategory.HARM_CATEGORY_HARASSMENT: HarmBlockThreshold.BLOCK_NONE,
                    HarmCategory.HARM_CATEGORY_HATE_SPEECH: HarmBlockThreshold.BLOCK_NONE,
                    HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: HarmBlockThreshold.BLOCK_NONE,
                    HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: HarmBlockThreshold.BLOCK_NONE,
                }
            )
            if not response.candidates or not response.candidates[0].content.parts:
                logging.warning(f"[{simulation_id}] Gemini returned an empty response. Ending simulation.")
                break
            user_utterance = response.text
            conversation_history.append(f"USER: {user_utterance}")
            logging.info(f"[{simulation_id}] Turn {turn + 1} (USER): {user_utterance}")

        logging.info(f"[{simulation_id}] Simulation complete. Full transcript:\n" + "\n".join(conversation_history))

    except Exception as e:
        logging.error(f"[{simulation_id}] Error during conversation loop: {e}", exc_info=True)
        logging.info(f"[{simulation_id}] Final transcript before error:\n{''.join(conversation_history)}")


def detect_dfcx_intent(agent_path, session_id, text, language_code="en"):
    """
    Sends a text input to Dialogflow CX and returns the agent's response.
    """
    try:
        session_path = f"{agent_path}/sessions/{session_id}"
        text_input = cx.TextInput(text=text)
        query_input = cx.QueryInput(text=text_input, language_code=language_code)
        request = cx.DetectIntentRequest(
            session=session_path,
            query_input=query_input,
        )
        response = dfcx_client.detect_intent(request=request)

        response_messages = [
            " ".join(msg.text.text) for msg in response.query_result.response_messages
        ]
        agent_response_text = " ".join(response_messages)
        current_page = response.query_result.current_page.display_name
        return agent_response_text, current_page

    except Exception as e:
        logging.error(f"Failed to detect intent for session {session_id}: {e}", exc_info=True)
        return "ERROR: Could not get agent response.", "ErrorPage"
