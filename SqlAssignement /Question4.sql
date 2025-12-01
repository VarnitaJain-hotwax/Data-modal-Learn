--Business Problem:
--When syncing products between multiple platforms like Shopify, HotWax, and ERP/NetSuite, the OMS must know each product’s corresponding ID in each system. This query fetches all mapped identifiers for every product.

--Fields to Retrieve:
--PRODUCT_ID (OMS internal)
--SHOPIFY_ID
--HOTWAX_ID
--ERP_ID / NETSUITE_ID





-- Retrieve system-wise IDs (Shopify, HotWax, ERP/NetSuite) for each product
SELECT
    p.product_id,                        -- Internal OMS product ID
    gi.id_value AS netsuite_id,          -- ERP/NetSuite identifier
    sp.shopify_product_id AS shopify_id, -- Shopify product ID
    p.external_id AS hotwax_id           -- HotWax product reference (if stored here)
FROM product p
-- Join for ERP / NetSuite mapping
LEFT JOIN good_identification gi 
    ON gi.product_id = p.product_id
    AND gi.good_identification_type_id = 'ERP_ID'
-- Join for Shopify mapping
LEFT JOIN shopify_product sp 
    ON sp.product_id = p.product_id
-- Only include products that already have an ERP ID assigned
WHERE gi.id_value IS NOT NULL;
