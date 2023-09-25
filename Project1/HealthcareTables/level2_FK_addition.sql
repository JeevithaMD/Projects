ALTER TABLE insuranceplan
ADD FOREIGN KEY (companyID) REFERENCES insurancecompany(companyID);

ALTER TABLE patient
ADD FOREIGN KEY (patientID) REFERENCES person(personID);

ALTER TABLE claim
ADD FOREIGN KEY (uin) REFERENCES insuranceplan(uin);