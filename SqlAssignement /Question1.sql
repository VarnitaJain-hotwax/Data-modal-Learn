-- Fetch customers created during June 2023 along with their basic details
SELECT 
    p.party_id,                     -- Customer ID
    p.first_name,                   -- First Name
    p.last_name,                    -- Last Name
    cm.info_string AS email,        -- Email Address
    tn.contact_number AS phone,     -- Phone Number
    pa.created_date AS entry_date   -- Account Creation Date
FROM person p
-- Join with PARTY to get creation/entry details
JOIN party pa 
    ON pa.party_id = p.party_id
-- Filter only CUSTOMER role
JOIN party_role pr 
    ON pr.party_id = p.party_id
-- Get contact mechanism associated to the party
JOIN party_contact_mech pcm 
    ON pcm.party_id = p.party_id
-- Fetch email/contact information
JOIN contact_mech cm 
    ON cm.contact_mech_id = pcm.contact_mech_id
-- Fetch phone number (if available)
LEFT JOIN telecom_number tn 
    ON tn.contact_mech_id = cm.contact_mech_id
-- Apply June 2023 date range filter
WHERE pa.created_date >= '2023-06-01'
  AND pa.created_date <  '2023-07-01'
  AND pr.role_type_id = 'CUSTOMER';
