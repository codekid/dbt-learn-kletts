/*
- STEP 1: LOOK AT THE DATA -> what's funny about it? what are the gotchas? what are my asusmptions about this data?

- STEP 2 (right-to-left approach / Diego's approach):
  - create an orders.sql file
  - use CTEs to break up any transofrmations
  - then refactor into separate files

- STEP 2 (left to right approach / Benjamin):
  - create the staging model first (following existing patterns)
  - create an orders model next
*/

WITH payments AS ( 
  SELECT
    orderid,
    SUM(amount) / 100 AS dollar_amount
  FROM  {{ ref('stg_payments') }}
  WHERE status = 'success'
  GROUP BY orderid
),

order_customer AS (
  SELECT DISTINCT
    customer_id, order_id
  FROM {{ ref('stg_orders')}}
),

final AS (
  select *
  from payments py
  LEFT JOIN order_customer cu
  on py.orderid = cu.order_id
)

SELECT *
FROM final