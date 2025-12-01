--Newly Created Sales Orders and Payment Methods

--Business Problem:
--The finance team needs visibility into newly created orders along with their respective payment methods to support reconciliation and fraud monitoring.

--Fields to Retrieve:
--ORDER_ID
--TOTAL_AMOUNT
--PAYMENT_METHOD
--SHOPIFY ORDER ID (if available)


-- Retrieve newly created sales orders along with payment method information
SELECT
    oh.order_id,                           -- Order identifier
    oh.grand_total AS total_amount,        -- Total order value
    opp.payment_method_type_id AS payment_method,  -- Payment method used
    oh.external_id AS shopify_order_id     -- Shopify reference (if synced)
FROM order_header oh
-- Join to map payment preferences for the order
JOIN order_payment_preference opp
    ON opp.order_id = oh.order_id
-- Filter to include only newly created orders
WHERE oh.status_id = 'ORDER_CREATED';
