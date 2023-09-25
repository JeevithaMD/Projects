SELECT pharmacyID, pharmacyName, SUM(quantity) as total_quantity2022,
	SUM(CASE WHEN hospitalExclusive='S' THEN quantity END) AS exclusive_quantity2022,
    ROUND((SUM(CASE WHEN hospitalExclusive='S' THEN quantity END)/SUM(quantity))*100,2) as percentage_of_exclusive
FROM treatment t
JOIN prescription USING (treatmentID)
JOIN pharmacy USING (pharmacyID)
JOIN contain USING (prescriptionID)
JOIN medicine USING (medicineID)
WHERE date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY pharmacyID, pharmacyName
ORDER BY percentage_of_exclusive DESC