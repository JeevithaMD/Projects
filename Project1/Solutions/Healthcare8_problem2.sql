SELECT city, 
	IFNULL(COUNT(personID),0) AS registered_people, 
    IFNULL(COUNT(CompanyID),0) AS insurance_companies, 
    IFNULL(COUNT(pharmacyID),0) AS phharmacies
FROM address 
LEFT JOIN person USING (addressID)
LEFT JOIN insurancecompany USING (addressID)
LEFT JOIN Pharmacy USING (addressID)
GROUP BY city
ORDER BY registered_people DESC, insurance_companies DESC, phharmacies DESC;

