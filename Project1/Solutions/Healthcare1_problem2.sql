USE healthcare;

SELECT d.diseaseName,
SUM(CASE WHEN pr.gender = 'male' THEN 1 END)/SUM(CASE WHEN pr.gender = 'female' THEN 1 END) AS male_to_female_ratio
FROM disease d
JOIN treatment t USING (diseaseID)
JOIN patient p USING (patientID)
JOIN person pr ON p.patientID = pr.personID
GROUP BY d.diseaseName
ORDER BY male_to_female_ratio DESC;