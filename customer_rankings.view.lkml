# If necessary, uncomment the line below to include explore_source.
# include: "rg_supply_max_analysis.model.lkml"

view: customer_ranks {
  derived_table: {
    explore_source: order_info {
      column: order_year {}
      column: customer_name {}
      column: Total_Sales {}
      derived_column: cust_yr_rank {
        sql: RANK() OVER(PARTITION BY order_year ORDER BY Total_Sales desc ) ;;
      }
      derived_column: row_num {
        sql: ROW_NUMBER() OVER() ;;
      }
    }
#     persist_for: "24 hours"
  }
  dimension: row_num {
    primary_key: yes
    hidden: yes
  }
  dimension: order_year {
    type: number
    hidden: yes
  }
  dimension: customer_name {
    hidden: yes
  }
  dimension: Total_Sales {
    value_format: "$#,##0"
    type: number
    hidden: yes
  }
  dimension: cust_yr_rank {
    label: "Customer Rank Per Year"
    type: number
  }
}
