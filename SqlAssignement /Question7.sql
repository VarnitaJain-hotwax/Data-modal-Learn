--Business Problem:
--Finance teams need to track orders where payment is already captured but shipment has not occurred. These orders may require manual review to ensure proper revenue accounting.

--Fields to Retrieve:
--ORDER_ID
--ORDER_STATUS
--PAYMENT_STATUS
--SHIPMENT_STATUS


-- Identify orders where payment is settled but shipment is pending or missing
SELECT 
    oh.order_id,                          -- OMS order ID
    oh.status_id AS order_status,         -- Order status (e.g., CREATED, COMPLETED)
    opp.status_id AS payment_status,      -- Payment status (e.g., PAYMENT_SETTLED)
    s.status_id AS shipment_status        -- Shipment status if available
FROM order_header oh
-- Link to payment preferences for payment status
JOIN order_payment_preference opp 
    ON opp.order_id = oh.order_id
-- Link shipments if they exist
LEFT JOIN order_shipment os 
    ON os.order_id = oh.order_id
LEFT JOIN shipment s 
    ON s.shipment_id = os.shipment_id
-- Only include orders where payment is captured but shipment not yet completed
WHERE opp.status_id = 'PAYMENT_SETTLED'
  AND (s.status_id IS NULL OR s.status_id != 'SHIPMENT_SHIPPED');
