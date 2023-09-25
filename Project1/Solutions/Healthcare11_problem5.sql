DELIMITER //
CREATE FUNCTION getAverageBalance(company VARCHAR(220)) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
		DECLARE avg_balance DECIMAL(10,2);
	
		SELECT ROUND(AVG(c.balance),2) INTO avg_balance
		FROM insurancecompany ic 
        JOIN insuranceplan ip USING (companyID)
		JOIN claim c USING (uin) 
        JOIN treatment t USING (claimID)
		WHERE date BETWEEN '2022-01-01' AND '2022-12-31' AND ic.companyName = company;
		
		RETURN avg_balance;
END //
DELIMITER ;

SELECT getAverageBalance('HDFC ERGO General Insurance Company Ltd.')
