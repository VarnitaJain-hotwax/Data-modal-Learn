--Business Problem:
--The merchandising team needs a clear list of all currently active physical products for planning warehousing, inventory, and shipping operations.

--Fields to Retrieve:
--PRODUCT_ID
--PRODUCT_TYPE_ID
--INTERNAL_NAME


-- Retrieve all products that are physical and currently active
SELECT 
    p.product_id,           -- Unique product identifier
    p.product_type_id,      -- Type of product
    p.internal_name         -- Internal display name
FROM product p
-- Check product type to confirm it's a physical item
JOIN product_type pt 
    ON pt.product_type_id = p.product_type_id
-- Only select products that are physical (Y) and not discontinued
WHERE pt.is_physical = 'Y'
  AND p.sales_discontinuation_date IS NULL;
