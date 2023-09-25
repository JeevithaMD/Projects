select medicineID, quantity, discount from pharmacy join keep using (pharmacyID) 
where 
pharmacyName = "Spot Rx" AND
(
(quantity > 7500 AND discount = 0)
OR
(quantity < 1000 AND discount >= 30)
);