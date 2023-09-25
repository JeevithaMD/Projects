SELECT state, high_treated_disease,high_treated_disease_count, least_treated_disease,least_treated_disease_count  FROM (
SELECT
        a.state,
        FIRST_VALUE(diseaseName) OVER (PARTITION BY a.state ORDER BY COUNT(*) DESC) AS high_treated_disease,
        FIRST_VALUE(count(*)) OVER(PARTITION BY a.state ORDER BY COUNT(*) DESC) AS high_treated_disease_count,
		LAST_VALUE(diseaseName) OVER (PARTITION BY a.state ORDER BY COUNT(*) DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS least_treated_disease,
        LAST_VALUE(count(*)) OVER (PARTITION BY a.state ORDER BY COUNT(*) DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS least_treated_disease_count
    FROM treatment t
    LEFT JOIN disease d USING (diseaseID)
    LEFT JOIN person p ON t.patientID = p.personID
    LEFT JOIN address a USING (addressID)
    WHERE t.date BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY a.state, d.diseaseName
) AS subq
GROUP BY state, high_treated_disease,high_treated_disease_count, least_treated_disease,least_treated_disease_count