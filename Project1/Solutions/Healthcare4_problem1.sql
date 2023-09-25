SELECT medicineID, companyName, productName, description, substanceName,
    CASE
        WHEN productType = 1 THEN 'Generic'
        WHEN productType = 2 THEN 'Patent'
        WHEN productType = 3 THEN 'Reference'
        WHEN productType = 4 THEN 'Similar'
        WHEN productType = 5 THEN 'New'
        WHEN productType = 6 THEN 'Specific'
        WHEN productType = 7 THEN 'Biological'
        WHEN productType = 8 THEN 'Dinamized'
        ELSE 'Unknown'
    END AS productTypeInWords,
    taxCriteria,
    hospitalExclusive,
    governmentDiscount,
    taxImunity,
    maxPrice
FROM Medicine
WHERE
    (taxCriteria = 'I' AND productType IN (1, 2, 3))
    OR
    (taxCriteria = 'II' AND productType IN (4, 5, 6));

