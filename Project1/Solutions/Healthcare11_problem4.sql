DELIMITER //
CREATE FUNCTION infected_count(city VARCHAR(20),disease VARCHAR(20), year INT) RETURNS INT DETERMINISTIC
BEGIN 
	DECLARE infected_count INT;

	SELECT COUNT(DISTINCT patientID) INTO infected_count
	FROM disease d 
    JOIN treatment t USING (diseaseID)
    JOIN patient p USING (patientID)
    join person pr ON p.patientID = pr.personID
    JOIN address a USING (addressID)  
	WHERE a.city = city AND d.diseaseName = disease AND YEAR(t.`date`) = year;
    
    RETURN infected_count;
end //
DELIMITER ;

select infected_count('Edmond','Cancer',2021)