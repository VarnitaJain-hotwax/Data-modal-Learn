-- 
--Completed Orders in August 2023

--Business Problem:
--You now need a detailed list of all orders that were completed in August 2023 to analyse product movement, facilities used, and store performance.

--Fields to Retrieve:
--PRODUCT_ID
--PRODUCT_TYPE_ID
--PRODUCT_STORE_ID
--TOTAL_QUANTITY
--INTERNAL_NAME
--FACILITY_ID
--EXTERNAL_ID
--FACILITY_TYPE_ID
--ORDER_HISTORY_ID
--ORDER_ID
--ORDER_ITEM_SEQ_ID
--SHIP_GROUP_SEQ_ID 




-- Fetch all completed order items for August 2023
SELECT 
    oi.product_id,                  -- Product ID
    p.product_type_id,              -- Product type
    oi.product_store_id,            -- Store from which order was placed
    oi.quantity AS total_quantity,  -- Ordered quantity
    p.internal_name,                -- Product internal name
    sg.facility_id,                 -- Facility fulfilling the order
    oh.external_id,                 -- External reference for the order
    f.facility_type_id,             -- Type of facility (e.g., warehouse, store)
    hist.order_history_id,          -- Order history record ID
    oi.order_id,                    -- Order ID
    oi.order_item_seq_id,           -- Order item sequence
    sg.ship_group_seq_id            -- Shipment group sequence
FROM order_item oi
JOIN product p 
    ON oi.product_id = p.product_id
JOIN ship_group sg 
    ON oi.order_id = sg.order_id 
   AND oi.ship_group_seq_id = sg.ship_group_seq_id
JOIN facility f 
    ON sg.facility_id = f.facility_id
JOIN order_header oh 
    ON oi.order_id = oh.order_id
LEFT JOIN order_history hist 
    ON hist.order_id = oi.order_id
-- Only consider orders completed in August 2023
WHERE oh.status_id = 'ORDER_COMPLETED'
  AND oh.order_date >= '2023-08-01'
  AND oh.order_date <  '2023-09-01';
