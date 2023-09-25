SELECT
    prescriptionID,
    total_quantity,
    (CASE
        WHEN total_quantity < 20 THEN 'Low Quantity'
        WHEN total_quantity < 50 THEN 'Medium Quantity'
        ELSE 'High Quantity'
    END) AS Tag
FROM (
    SELECT
        prescriptionID,
        SUM(quantity) AS total_quantity
    FROM contain JOIN prescription P USING (prescriptionID)
	JOIN pharmacy ph USING (pharmacyID)
	WHERE ph.pharmacyName = 'Ally Scripts'
	GROUP BY prescriptionID
) AS prescription_details;