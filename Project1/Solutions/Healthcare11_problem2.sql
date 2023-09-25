DELIMITER //

CREATE FUNCTION avg_cost_of_prescription(pharmacy_id INT, year INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE avg_price VARCHAR(20);

    SELECT round(avg(m.maxPrice),2) 
    INTO avg_price
    FROM pharmacy ph
    JOIN prescription pr USING (pharmacyID)
    JOIN contain c USING (prescriptionID)
    JOIN medicine m USING (medicineID)
    JOIN treatment t USING (treatmentID)
    WHERE ph.pharmacyID = pharmacy_id AND YEAR(t.date) = year;

    RETURN avg_price;
END //
DELIMITER ;

SET @average_price = avg_cost_of_prescription(1008, 2022);
SELECT @average_price AS avg_cost_of_prescription;