view: order_info {
  sql_table_name: public.order_info ;;

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
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
      week_of_year,
      month,
      month_name,
      quarter,
      quarter_of_year,
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

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: profit {
    type: number
    sql: ${TABLE}.profit ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: row_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.row_id ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension_group: ship {
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
    sql: ${TABLE}.ship_date ;;
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.ship_mode ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.sub_category ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name, product_name]
  }

  measure: Total_Sales {
    type: sum
    drill_fields: [customer_name, product_name, postal_code]
    value_format_name: "usd_0"
    sql: ${TABLE}.sales ;;
  }

  measure: Total_Profit {
    type: sum
    drill_fields: [customer_name, product_name, postal_code]
    value_format_name: "usd_0"
    sql: ${TABLE}.profit ;;
  }

  measure: Profit_Ratio {
    type: number
    drill_fields: [customer_name, product_name, postal_code]
    value_format_name: "percent_1"
    sql: ${Total_Profit} / ${Total_Sales} ;;
  }

  measure: distinct_orders {
    type: number
    drill_fields: [customer_name]
    sql:  count(distinct ${TABLE}.order_id);;
  }

  measure: distinct_customers {
    type: count_distinct
    drill_fields: [customer_name]
    sql: ${customer_name};;
  }

  measure: first_order {
    type: date
    sql: min(${order_date}) ;;
  }

  dimension: months_btw_purchase {
    type: number
    sql: date_part('month', age(${order_date},${customer_facts.first_order_date})) ;;
  }

  measure: avg_months_btw_purchase {
    type: average
    drill_fields: [customer_name]
    sql: ${months_btw_purchase} ;;
  }

  dimension: ty {
    hidden: yes
    type: yesno
    sql: ${order_year} = EXTRACT(YEAR FROM now() ) ;;
  }

  dimension: ly {
    hidden: yes
    type: yesno
    sql: ${order_year} = EXTRACT(YEAR FROM now() ) - 1 ;;
  }

  measure: this_yr_sales {
    label: "This Year Sales"
    type: sum
    value_format_name: usd_0
    filters: {
      field: ty
      value: "yes"
    }
    sql: ${sales}  ;;

  }

  measure: last_yr_sales {
    label: "Last Year Sales"
    type: sum
    value_format_name: usd_0
    filters: {
      field: ly
      value: "yes"
    }
    sql: ${sales}  ;;

  }

  measure: ty_v_ly {
    label: "This Year vs Last"
    type: number
    value_format_name: usd_0
    drill_fields: [product_name]
    sql: ${this_yr_sales} - ${last_yr_sales} ;;
  }

}
