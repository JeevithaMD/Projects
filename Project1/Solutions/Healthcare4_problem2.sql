SELECT p.prescriptionID, SUM(c.quantity) AS totalQuantity, 
	CASE
		WHEN SUM(c.quantity) < 20 THEN "Low Quantity"
        WHEN SUM(c.quantity) BETWEEN 20 AND 49 THEN "Medium Quantity"
        WHEN SUM(c.quantity) > 50 THEN "High Quantity"
        ELSE "Unknown"
	END AS Tag
FROM prescription p
JOIN contain c USING (prescriptionID)
GROUP BY p.prescriptionID;
