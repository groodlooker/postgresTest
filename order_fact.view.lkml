view: order_fact {
  sql_table_name: public.order_fact ;;

  dimension: customer_id {
    type: string
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}.discount ;;
  }

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: profit {
    type: number
    sql: ${TABLE}.profit ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: row_id {
    type: string
    sql: ${TABLE}.row_id ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_sales {
    type: sum
    value_format_name: usd_0
    sql: ${sales} ;;
  }

  measure: total_profit {
    type: sum
    value_format_name: usd_0
    sql: ${profit} ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
  }

  measure: avg_discount {
    type: average
    value_format_name: percent_1
    sql: ${discount} ;;
  }

  measure: profit_ratio {
    type: number
    value_format_name: percent_1
    sql: sum(${profit}) / sum(${sales}) ;;
  }


}
