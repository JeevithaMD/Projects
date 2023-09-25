ALTER TABLE insurancecompany
ADD FOREIGN KEY (addressID) REFERENCES address(addressID);

ALTER TABLE person
ADD FOREIGN KEY (addressID) REFERENCES address(addressID);

ALTER TABLE pharmacy
ADD FOREIGN KEY (addressID) REFERENCES address(addressID);

