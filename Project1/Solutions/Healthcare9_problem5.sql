SELECT d.diseaseName, p.gender, count(*) as count
FROM disease d
LEFT JOIN treatment t USING (diseaseID)
LEFT JOIN person p ON t.patientID = p.personID
WHERE t.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY d.diseaseName, p.gender WITH ROLLUP;