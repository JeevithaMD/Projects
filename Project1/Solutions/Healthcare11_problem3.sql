DELIMITER //
CREATE FUNCTION most_spread_disease(state VARCHAR(10), year_ INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN 
	DECLARE top_disease VARCHAR(50);

		SELECT d.diseaseName INTO top_disease
		FROM address a 
			JOIN person pr USING (addressID) 
			JOIN patient p ON pr.personID = p.patientID
			JOIN treatment t USING (patientID)
			JOIN disease d USING (diseaseID)
		WHERE state = state AND year(t.`date`) = year
		group by a.state, d.diseaseID
		ORDER BY COUNT(d.diseaseID) DESC
		LIMIT 1;

	RETURN top_disease;
END //
DELIMITER ;

SELECT most_spread_disease('AK',2022);