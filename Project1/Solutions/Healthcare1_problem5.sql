WITH medicine_count AS (
SELECT ph.pharmacyID, p.prescriptionID, COUNT(*) AS no_of_medicines
FROM pharmacy ph
JOIN prescription p USING (pharmacyID)
JOIN contain c USING (prescriptionID)
GROUP BY ph.pharmacyID, p.prescriptionID
ORDER BY)

SELECT pharmacyID, MAX(no_of_medicines) AS max_count, MIN(no_of_medicines) AS min_count, AVG(no_of_medicines) AS avg_count FROM medicine_count
GROUP BY pharmacyID;
