DELIMITER //
CREATE PROCEDURE get_pharmacy_list(IN medicineID INT)
BEGIN
    SELECT ph.pharmacyID, ph.pharmacyName, ph.phone, m.productName, k.quantity
    FROM pharmacy ph
    JOIN keep k USING (pharmacyID)
    JOIN medicine m USING (medicineID)
    WHERE m.medicineID = medicineID;
END //
DELIMITER ;

CALL get_pharmacy_list(2)