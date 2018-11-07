connection: "rg_supply_max"

# include all the views
include: "*.view"

datagroup: rg_supply_max_analysis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rg_supply_max_analysis_default_datagroup

explore: order_info {
  join: customer_facts {
    type: left_outer
    sql_on: ${order_info.customer_name} = ${customer_facts.customer_name};;
    relationship: many_to_one

  }
  join: customer_ranks {
    type: left_outer
    sql_on: ${order_info.customer_name} = ${customer_ranks.customer_name} and
            ${order_info.order_year} = ${customer_ranks.order_year};;
    relationship: many_to_one
  }
}
