project_name: "ccai"

constant: project_id {
  value: "adamminton-sandbox"
  export: override_required
}

constant: dataform_schema {
  value: "dataform_ccai"
  export: override_required
}

constant: environment_short {
  value: "dev"
  export: override_required
}

constant: environment_label {
  value: "Development"
  export: override_required
}

constant: html_json_rendering {
  value: "<div style=\"background-color: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 4px; padding: 8px;\"><pre style=\"margin: 0; white-space: pre-wrap; font-family: 'Roboto Mono', monospace; font-size: 11px; line-height: 1.3; color: #333; max-height: 300px; overflow-y: auto;\">{{ value }}</pre></div>"
}
