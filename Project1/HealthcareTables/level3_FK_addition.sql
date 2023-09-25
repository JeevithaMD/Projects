ALTER TABLE treatment
ADD FOREIGN KEY (patientID) REFERENCES patient(patientID),
ADD FOREIGN KEY (diseaseID) REFERENCES disease(diseaseID),
ADD FOREIGN KEY (claimID) REFERENCES claim(claimID);

ALTER TABLE prescription
ADD FOREIGN KEY (pharmacyID) REFERENCES pharmacy(pharmacyID),
ADD FOREIGN KEY (treatmentID) REFERENCES treatment(treatmentID);

ALTER TABLE contain
ADD FOREIGN KEY (prescriptionID) REFERENCES prescription(prescriptionID),
ADD FOREIGN KEY (medicineID) REFERENCES medicine(medicineID);