--Orders Completed Hourly

--Business Problem:
--Operations teams need to understand at what hours of the day orders are being completed so they can plan staffing and load distribution accordingly.


-- Count how many orders were completed in each hour of the day
SELECT 
    HOUR(oh.order_date) AS order_hour,   -- Hour during which order was completed
    COUNT(oh.order_id) AS total_orders   -- Number of completed orders
FROM order_header oh
-- Only consider orders that reached completed status
WHERE oh.status_id = 'ORDER_COMPLETED'
-- Aggregate by hour of completion
GROUP BY order_hour
-- Display results sequentially by hour
ORDER BY order_hour;
