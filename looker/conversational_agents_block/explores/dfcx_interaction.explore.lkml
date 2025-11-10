include: "/views/dfcx_interaction.view.lkml"

explore: dfcx_interaction {
  hidden: yes

  persist_with: hourly

  join: dfcx_interaction__actions {
    view_label: "DFCX Interaction: Actions"
    sql: LEFT JOIN UNNEST(${dfcx_interaction.actions}) as dfcx_interaction__actions ;;
    relationship: one_to_many
  }

}
