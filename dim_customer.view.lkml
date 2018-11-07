view: dim_customer {
  sql_table_name: public.dim_customer ;;

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  measure: count {
    type: count
    drill_fields: [first_name, last_name]
  }
}
