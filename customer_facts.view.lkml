view: customer_facts {
  derived_table: {
    explore_source: order_info {
      column: customer_name {}
      column: distinct_orders {}
      column: first_order {}
    }
  }
  dimension: customer_name {
    primary_key: yes
  }
  dimension: order_bins {
    type: number
    sql: ${TABLE}.distinct_orders ;;
  }
  dimension: first_order_date {
    type: date
    sql:  ${TABLE}.first_order ;;
  }
}

explore: customer_facts {}
