DELIMITER //
CREATE PROCEDURE claim_status(IN diseaseid INT)
BEGIN
	DECLARE avgclaims DECIMAL(10,2); 
    DECLARE diseaseclaims INT; 
    DECLARE claimstatus VARCHAR(255);
	
	SELECT AVG(number_of_claims) INTO avgclaims FROM (
	SELECT COUNT(t.claimID) AS number_of_claims
	FROM disease d
	JOIN treatment t USING (diseaseID)
	GROUP BY d.diseaseID
	) AS subq;

	SELECT COUNT(*) INTO diseaseclaims
	FROM  disease d 
	JOIN treatment t USING(diseaseid)
	WHERE d.diseaseid = diseaseid;
	
	IF diseaseclaims > avgclaims THEN
		SET claimstatus = "claimed higher than average";
	ELSE
		SET claimstatus = "claimed lower than average";
	END IF;

	SELECT claimstatus;
END //
delimiter ;

CALL claim_status(1);


