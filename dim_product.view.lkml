view: dim_product {
  sql_table_name: public.dim_product ;;

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.sub_category ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }
}
