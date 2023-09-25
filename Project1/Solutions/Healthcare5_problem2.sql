SELECT d.diseaseName,
		SUM(CASE WHEN p.gender = 'male' THEN 1 END) AS male_count,
        SUM(CASE WHEN p.gender = 'female' THEN 1 END) AS female_count,
        SUM(CASE WHEN p.gender = 'male' THEN 1 END)/SUM(CASE WHEN p.gender = 'female' THEN 1 END) AS male_to_female_ratio
FROM treatment t
JOIN person p ON t.patientID = p.personID
JOIN disease d USING (diseaseID)
WHERE t.date BETWEEN '2021-01-01' AND '2021-12-01'
GROUP BY diseaseID
ORDER BY diseaseID;

