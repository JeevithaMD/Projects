WITH prescriptons_2022 AS (
SELECT t.date AS prescription_date, t.patientID, 
	CASE
		WHEN TIMESTAMPDIFF(YEAR, p.dob, t.date) >= 65 THEN "Senior"
        WHEN TIMESTAMPDIFF(YEAR, p.dob, t.date) >= 25 THEN "Adult"
        WHEN TIMESTAMPDIFF(YEAR, p.dob, t.date) >= 15 THEN "Youth"
        WHEN TIMESTAMPDIFF(YEAR, p.dob, t.date) >= 0 THEN "Children"
        ELSE null
	END AS age_category
FROM treatment t
JOIN patient p ON t.patientID = p.patientID
WHERE date BETWEEN '2022-01-01' AND '2022-12-31')

SELECT age_category, COUNT(*) AS no_of_prescriptions FROM prescriptons_2022 GROUP BY age_category;
