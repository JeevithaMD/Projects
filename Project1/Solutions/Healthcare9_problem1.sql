SELECT a.state, p.gender, count(*) as count
FROM disease d
LEFT JOIN treatment t USING (diseaseID)
LEFT JOIN person p ON t.patientID = p.personID
LEFT JOIN address a USING (addressID)
WHERE d.diseaseName = 'Autism'
GROUP BY a.state, p.gender WITH ROLLUP
