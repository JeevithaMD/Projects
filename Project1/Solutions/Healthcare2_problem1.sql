SELECT city, 
	COUNT(DISTINCT ph.pharmacyID) AS number_of_pharmacies,
	COUNT(DISTINCT p.prescriptionID) AS number_of_prescriptions,
    ROUND(COUNT(DISTINCT ph.pharmacyID)/COUNT(DISTINCT p.prescriptionID),2) AS pharmacy_to_prescription_ratio
FROM address a
JOIN pharmacy ph USING (addressID)
JOIN prescription p USING (pharmacyID)
GROUP BY city
HAVING COUNT(DISTINCT p.prescriptionID) > 100
ORDER BY pharmacy_to_prescription_ratio