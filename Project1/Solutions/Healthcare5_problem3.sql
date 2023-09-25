SELECT * 
FROM (
SELECT d.diseaseID, 
		a.city, 
        COUNT(*) AS count,
        DENSE_RANK() OVER(PARTITION BY d.diseaseID ORDER BY d.diseaseID, COUNT(*) DESC) AS top_rank
FROM treatment t
JOIN disease d USING (diseaseID)
JOIN patient p USING (patientID)
JOIN person pr ON p.patientID = pr.personID
JOIN address a USING (addressID)
GROUP BY d.diseaseID, a.city
ORDER BY d.diseaseID, count DESC) AS subq
WHERE top_rank <=3;