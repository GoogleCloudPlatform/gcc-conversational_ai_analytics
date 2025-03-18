from dfcx_scrapi.tools.nlu_evals import NluEvals
import pandas as pd
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)-8s %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)

INPUT_SCHEMA_COLUMNS = [
    "flow_display_name",
    "page_display_name",
    "utterance",
    "expected_intent",
    "expected_parameters",
    "expected_match_type",
    "description",
]

OUTPUT_SCHEMA_COLUMNS = [
    "flow_display_name",
    "page_display_name",
    "utterance",
    "expected_intent",
    "expected_parameters",
    "expected_match_type",
    "target_page",
    "match_type",
    "confidence",
    "parameters_set",
    "detected_intent",
    "agent_name",
    "description",
    "input_source"
]


'''
We are overriding some NluEvals methods in order to include columns (OUTPUT_SCHEMA_COLUMNS, INPUT_SCHEMA_COLUMNS) not used by the
standard library
'''
class CustomNluEvals(NluEvals):
    def _clean_dataframe(self, df):
        """Various Dataframe cleaning functions."""
        df.columns = df.columns.str.lower()
        df = df.replace("Start Page", "START_PAGE")
        df.rename(
                columns={
                    "source": "description",
                },
                inplace=True,
            )

        # Validate input schema
        try:
            df = df[INPUT_SCHEMA_COLUMNS]
        except KeyError as err:
            raise UserWarning("Ensure your input data contains the following "\
                              f"columns: {INPUT_SCHEMA_COLUMNS}") from err

        df["agent_name"] = self._a.get_agent(self.agent_id).display_name

        return df

    def run_evals(self, df: pd.DataFrame, chunk_size: int = 300,
                  rate_limit: float = 10.0,
                  eval_run_display_name: str = "Evals"):
        """Run the full Eval dataset."""
        logsx = "-" * 10

        logging.info(f"{logsx} STARTING {eval_run_display_name} {logsx}")
        results = self._dc.run_intent_detection(
            test_set=df, chunk_size=chunk_size, rate_limit=rate_limit
        )

        # Reorder Columns
        results = results.reindex(columns=OUTPUT_SCHEMA_COLUMNS)

        # When a NO_MATCH occurs, the detected_intent field will be blank
        # this replaces with NO_MATCH string, which will allow for easier stats
        # calculation downstream
        results['detected_intent'] = results['detected_intent'].replace(
            {"": "NO_MATCH"})

        logging.info(f"{logsx} {eval_run_display_name} COMPLETE {logsx}")

        return results