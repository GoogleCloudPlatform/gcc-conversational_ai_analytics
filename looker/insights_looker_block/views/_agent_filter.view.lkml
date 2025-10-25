#    Copyright 2024 Google LLC

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

view: agent_filter {
  parameter: agent_id_selector {
    type: string
    suggest_dimension: insights_data__agent_id_filter.agent_id
    suggest_explore: insights_data__agent_id_filter
  }

  dimension: agent_id_selected {
    type: string
    sql:
    CASE
      WHEN ${insights_data__agents.agent_id} = {% parameter agent_id_selector %} THEN ${insights_data__agents.agent_id}
      ELSE ' All Other Agents'
    END
  ;;
  }

}
