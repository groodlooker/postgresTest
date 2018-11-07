# If necessary, uncomment the line below to include explore_source.
# include: "store_sales.model.lkml"
#
# view: product_rank {
#   derived_table: {
#     explore_source: order_fact {
#       column: category { field: dim_product.category }
#       column: product_name { field: dim_product.product_name }
#       column: total_sales {}
#       derived_column: rank_total_sales {
#         sql: RANK() OVER(PARTITION BY category ORDER BY total_sales DESC) ;;
#       }
#     }
#   }
#   dimension: category {}
#   dimension: product_name {}
#   dimension: total_sales {
#     value_format: "$#,##0"
#     type: number
#   }
#   dimension: rank_total_sales {
#     type: number
#   }
#   dimension: product_rank_group {
#     type: tier
#     tiers: [1,2]
#     style: integer
#     sql: ${rank_total_sales} ;;
#   }
# }

# explore: product_rank {}
