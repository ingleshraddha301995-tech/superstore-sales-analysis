-- REVENUE & PROFITABILITY
-- Q1: Monthly revenue trend
-- Shows how total sales move month by month across all years
-- group all orders by month and add up sales and profit
SELECT
    DATE_TRUNC('month', order_date) AS month,   -- rounds date down to 1st of each month
    ROUND(SUM(sales)::numeric, 2)   AS total_sales,
    ROUND(SUM(profit)::numeric, 2)  AS total_profit
FROM superstore_sales
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- Q2: Top 10 most profitable products
-- Simple SUM of profit per product, sorted highest first
SELECT
    product_name,
    category,
    ROUND(SUM(sales)::numeric, 2)   AS total_sales,
    ROUND(SUM(profit)::numeric, 2)  AS total_profit
FROM superstore_sales
GROUP BY product_name, category
ORDER BY total_profit DESC
LIMIT 10;



-- Q3: Sub-categories losing money
-- HAVING filters AFTER grouping — here only keep groups where profit is negative
SELECT
    category,
    sub_category,
    ROUND(AVG(discount)::numeric, 2) AS avg_discount,  -- high discount = likely cause
    ROUND(SUM(profit)::numeric, 2)   AS total_profit
FROM superstore_sales
GROUP BY category, sub_category
HAVING SUM(profit) < 0               -- only show loss-making sub-categories
ORDER BY total_profit ASC;           -- worst losses first
 

 -- CUSTOMER ANALYSIS
 -- Q4: Sales by customer segment
 -- Shows which segment (Consumer / Corporate / Home Office) drives the most revenue
SELECT
    segment,
    COUNT(DISTINCT customer_id)     AS total_customers,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(sales)::numeric, 2)   AS total_sales,
    ROUND(SUM(profit)::numeric, 2)  AS total_profit
FROM superstore_sales
GROUP BY segment
ORDER BY total_sales DESC;



 -- Q5: Top 20 customers by total spending (lifetime value)
SELECT
    customer_name,
    segment,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(sales)::numeric, 2)   AS lifetime_value
FROM superstore_sales
GROUP BY customer_name, segment
ORDER BY lifetime_value DESC
LIMIT 20;
 


 -- Q6: Repeat buyers vs one-time buyers
 -- use a subquery to count orders per customer, then classify them
SELECT
    buyer_type,
    COUNT(*)                        AS customer_count,
    ROUND(AVG(total_spent)::numeric, 2) AS avg_spend
FROM (
    -- inner query: one row per customer with their order count
    SELECT
        customer_id,
        SUM(sales)                  AS total_spent,
        CASE
            WHEN COUNT(DISTINCT order_id) = 1 THEN 'One-time buyer'
            ELSE 'Repeat buyer'
        END                         AS buyer_type
    FROM superstore_sales
    GROUP BY customer_id
) AS customer_summary
GROUP BY buyer_type;


-- REGIONAL PERFORMANCE
--Q7: Sales and profit by region
SELECT
    region,
    state,
    ROUND(SUM(sales)::numeric, 2)   AS total_sales,
    ROUND(SUM(profit)::numeric, 2)  AS total_profit
FROM superstore_sales
GROUP BY region, state
ORDER BY region, total_profit DESC;



-- Q8: States that are losing money
SELECT
    state,
    region,
    ROUND(SUM(sales)::numeric, 2)   AS total_sales,
    ROUND(SUM(profit)::numeric, 2)  AS total_profit,
    ROUND(AVG(discount)::numeric, 2) AS avg_discount
FROM superstore_sales
GROUP BY state, region
HAVING SUM(profit) < 0              -- only loss-making states
ORDER BY total_profit ASC;



-- Q9: Month-over-month revenue growth using LAG()
-- LAG() fetches the value from the PREVIOUS row
-- So we can compare this month's sales to last month's
SELECT
    month,
    total_sales,
    prev_month_sales,
    ROUND(
        (total_sales - prev_month_sales)
        / NULLIF(prev_month_sales, 0)   -- NULLIF avoids divide-by-zero error
        * 100
    , 1) AS growth_pct
FROM (
    SELECT
        DATE_TRUNC('month', order_date)    AS month,
        ROUND(SUM(sales)::numeric, 2)      AS total_sales,
        ROUND(LAG(SUM(sales)) OVER (
            ORDER BY DATE_TRUNC('month', order_date)
        )::numeric, 2)                     AS prev_month_sales
    FROM superstore_sales
    GROUP BY DATE_TRUNC('month', order_date)
) AS monthly
ORDER BY month;
 


 -- Q10: Running total of sales over time using SUM() OVER()
-- A running total adds each day's sales to everything before it
-- Great for seeing cumulative growth on a chart
SELECT
    order_date,
    ROUND(SUM(sales)::numeric, 2)   AS daily_sales,
    ROUND(SUM(SUM(sales)) OVER (
        ORDER BY order_date         -- adds up all sales up to this date
    )::numeric, 2)                  AS running_total
FROM superstore_sales
GROUP BY order_date
ORDER BY order_date;



 -- Q11: Rank customers within each segment using RANK() OVER()
-- PARTITION BY segment means ranking restarts for each segment
-- So #1 in Consumer and #1 in Corporate are two different people
SELECT
    segment,
    customer_name,
    ROUND(SUM(sales)::numeric, 2)   AS total_sales,
    RANK() OVER (
        PARTITION BY segment        -- restart ranking for each segment
        ORDER BY SUM(sales) DESC    -- rank by highest sales first
    ) AS rank_in_segment
FROM superstore_sales
GROUP BY segment, customer_name
ORDER BY segment, rank_in_segment
LIMIT 30;




 -- Q12: Year-over-Year sales growth per category using LAG()
-- Same idea as Q9 but here partition by category
-- so LAG() looks back to the previous year within the same category
SELECT
    category,
    yr,
    total_sales,
    LAG(total_sales) OVER (
        PARTITION BY category       -- stay within same category
        ORDER BY yr                 -- look at previous year
    )                               AS prev_year_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (PARTITION BY category ORDER BY yr))
        / NULLIF(LAG(total_sales) OVER (PARTITION BY category ORDER BY yr), 0)
        * 100
    , 1)                            AS yoy_growth_pct
FROM (
    SELECT
        category,
        EXTRACT(YEAR FROM order_date)::int  AS yr,
        ROUND(SUM(sales)::numeric, 2)       AS total_sales
    FROM superstore_sales
    GROUP BY category, EXTRACT(YEAR FROM order_date)
) AS yearly
ORDER BY category, yr;
 