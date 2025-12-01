--Products Missing NetSuite ID

--Business Problem:
--For a product to sync with NetSuite, it must have a valid NetSuite/ERP ID. The OMS team needs to identify all products that still do not have this ID assigned.

--Fields to Retrieve:
--PRODUCT_ID
--INTERNAL_NAME
--PRODUCT_TYPE_ID
--NETSUITE_ID / ERP_ID


-- Fetch products that do not have a NetSuite/ERP identifier assigned
SELECT
    p.product_id,                    -- Product code
    p.internal_name,                 -- Display name
    p.product_type_id,               -- Type/category of product
    gi.id_value AS netsuite_id       -- ERP/NetSuite ID (missing for these records)
FROM product p
-- Join to good_identification to check ERP/NetSuite mapping
LEFT JOIN good_identification gi
    ON gi.product_id = p.product_id
    AND gi.good_identification_type_id = 'ERP_ID'   -- Only consider ERP ID type
-- Identify products where the ERP ID is empty or not present
WHERE (gi.id_value IS NULL OR gi.id_value = '');
