DELIMITER //
CREATE PROCEDURE genderwisereport(IN disease_id INT)
BEGIN
	DECLARE disease_name VARCHAR(255);
    DECLARE num_of_male_treated INT;
    DECLARE num_of_female_treated INT;
	DECLARE more_gender_treated VARCHAR(10);
	
	SELECT diseasename INTO disease_name
	FROM disease
	WHERE diseaseid = disease_id;
	
	SELECT COUNT( DISTINCT patientID) INTO num_of_male_treated 
    FROM disease d 
	JOIN treatment t USING (diseaseid)
	JOIN patient p USING (patientid)
	JOIN person	pr ON p.patientID = pr.personID
	WHERE d.diseaseid = disease_id and pr.gender = "male"; 
	
	SELECT COUNT( DISTINCT patientID) INTO num_of_female_treated 
    FROM disease d 
	JOIN treatment t USING (diseaseid)
	JOIN patient p USING (patientid)
	JOIN person	pr ON p.patientID = pr.personID
	WHERE d.diseaseid = disease_id and pr.gender = "female"; 
	
	IF num_of_male_treated > num_of_female_treated THEN
		SET more_gender_treated = "male";
	ELSEIF num_of_male_treated < num_of_female_treated THEN 
		SET more_gender_treated = "female";
	ELSE 
		SET more_gender_treated = "same";
	END IF;
		
	SELECT disease_name, num_of_male_treated, num_of_female_treated, more_gender_treated;
END //
delimiter ;

CALL genderwisereport(1);