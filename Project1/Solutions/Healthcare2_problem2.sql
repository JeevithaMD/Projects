SELECT city, diseaseName, patient_count FROM (
SELECT  a.city, 
		d.diseaseName, 
        COUNT(DISTINCT p.patientID) patient_count ,
        ROW_NUMBER() OVER(PARTITION BY a.city ORDER BY COUNT(DISTINCT p.patientID) DESC) as rank_
FROM disease d
JOIN treatment t USING (diseaseID)
JOIN patient p USING (patientID)
JOIN person pr ON p.patientID = pr.personID
JOIN address a USING (addressID)
WHERE a.state = 'AL'
GROUP BY a.city, d.diseaseID
ORDER BY city,patient_count DESC) as subq
WHERE rank_ = 1