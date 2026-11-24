-- DAMG 6210 | Massachusetts Health Network | Group 4

USE MassHealthNetwork;
GO
-- INSURANCE_COMPANY
INSERT INTO INSURANCE_COMPANY (CompanyName) VALUES
('Insurer 1'),
('Insurer 2'),
('Insurer 3'),
('Insurer 4'),
('Insurer 5'),
('Insurer 6'),
('Insurer 7'),
('Insurer 8'),
('Insurer 9'),
('Insurer 10');
-- PATIENT
INSERT INTO PATIENT (FirstName, LastName, DateOfBirth) VALUES
('Patient', 'Number 1', '1995-01-01'),
('Patient', 'Number 2', '1995-01-01'),
('Patient', 'Number 3', '1995-01-01'),
('Patient', 'Number 4', '1995-01-01'),
('Patient', 'Number 5', '1995-01-01'),
('Patient', 'Number 6', '1995-01-01'),
('Patient', 'Number 7', '1995-01-01'),
('Patient', 'Number 8', '1995-01-01'),
('Patient', 'Number 9', '1995-01-01'),
('Patient', 'Number 10', '1995-01-01');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '1', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (1, 'General', 'LIC1');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '2', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (2, 'General', 'LIC2');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '3', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (3, 'General', 'LIC3');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '4', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (4, 'General', 'LIC4');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '5', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (5, 'General', 'LIC5');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '6', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (6, 'General', 'LIC6');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '7', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (7, 'General', 'LIC7');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '8', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (8, 'General', 'LIC8');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '9', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (9, 'General', 'LIC9');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '10', 'DOCTOR', '2022-01-01');
INSERT INTO DOCTOR (StaffID, Specialty, LicenseNumber) VALUES (10, 'General', 'LIC10');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '11', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (11, 'LIC11');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '12', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (12, 'LIC12');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '13', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (13, 'LIC13');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '14', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (14, 'LIC14');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '15', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (15, 'LIC15');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '16', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (16, 'LIC16');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '17', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (17, 'LIC17');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '18', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (18, 'LIC18');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '19', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (19, 'LIC19');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '20', 'NURSE', '2022-01-01');
INSERT INTO NURSE (StaffID, LicenseNumber) VALUES (20, 'LIC20');
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '21', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (21);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '22', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (22);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '23', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (23);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '24', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (24);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '25', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (25);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '26', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (26);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '27', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (27);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '28', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (28);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '29', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (29);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '30', 'RECEPTIONIST', '2022-01-01');
INSERT INTO RECEPTIONIST (StaffID) VALUES (30);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '31', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (31);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '32', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (32);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '33', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (33);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '34', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (34);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '35', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (35);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '36', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (36);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '37', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (37);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '38', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (38);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '39', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (39);
INSERT INTO STAFF (FirstName, LastName, StaffType, HireDate) VALUES ('Staff', '40', 'LAB_TECHNICIAN', '2022-01-01');
INSERT INTO LAB_TECHNICIAN (StaffID) VALUES (40);
-- VACCINE
INSERT INTO VACCINE (VaccineName) VALUES
('Vaccine 1'),
('Vaccine 2'),
('Vaccine 3'),
('Vaccine 4'),
('Vaccine 5'),
('Vaccine 6'),
('Vaccine 7'),
('Vaccine 8'),
('Vaccine 9'),
('Vaccine 10');
-- ALLERGY
INSERT INTO ALLERGY (AllergyName) VALUES
('Allergy 1'),
('Allergy 2'),
('Allergy 3'),
('Allergy 4'),
('Allergy 5'),
('Allergy 6'),
('Allergy 7'),
('Allergy 8'),
('Allergy 9'),
('Allergy 10');
-- VITAL_SIGN_TYPE
INSERT INTO VITAL_SIGN_TYPE (TypeName, Unit) VALUES
('Measurement 1', 'units'),
('Measurement 2', 'units'),
('Measurement 3', 'units'),
('Measurement 4', 'units'),
('Measurement 5', 'units'),
('Measurement 6', 'units'),
('Measurement 7', 'units'),
('Measurement 8', 'units'),
('Measurement 9', 'units'),
('Measurement 10', 'units');
-- DIAGNOSIS
INSERT INTO DIAGNOSIS (DiagnosisCode, DiagnosisName) VALUES
('D1', 'Diagnosis 1'),
('D2', 'Diagnosis 2'),
('D3', 'Diagnosis 3'),
('D4', 'Diagnosis 4'),
('D5', 'Diagnosis 5'),
('D6', 'Diagnosis 6'),
('D7', 'Diagnosis 7'),
('D8', 'Diagnosis 8'),
('D9', 'Diagnosis 9'),
('D10', 'Diagnosis 10');
-- MEDICATION
INSERT INTO MEDICATION (MedicationName) VALUES
('Medication 1'),
('Medication 2'),
('Medication 3'),
('Medication 4'),
('Medication 5'),
('Medication 6'),
('Medication 7'),
('Medication 8'),
('Medication 9'),
('Medication 10');
-- PATIENT_INSURANCE
INSERT INTO PATIENT_INSURANCE (PatientID, InsuranceCompanyID, PolicyNumber, CoverageStartDate) VALUES
(1, 1, 'POL1', '2024-01-01'),
(2, 2, 'POL2', '2024-01-01'),
(3, 3, 'POL3', '2024-01-01'),
(4, 4, 'POL4', '2024-01-01'),
(5, 5, 'POL5', '2024-01-01'),
(6, 6, 'POL6', '2024-01-01'),
(7, 7, 'POL7', '2024-01-01'),
(8, 8, 'POL8', '2024-01-01'),
(9, 9, 'POL9', '2024-01-01'),
(10, 10, 'POL10', '2024-01-01');
-- PATIENT_VACCINATION
INSERT INTO PATIENT_VACCINATION (PatientID, VaccineID, DoseNumber, DateGiven) VALUES
(1, 1, 1, '2025-01-01'),
(2, 2, 1, '2025-01-01'),
(3, 3, 1, '2025-01-01'),
(4, 4, 1, '2025-01-01'),
(5, 5, 1, '2025-01-01'),
(6, 6, 1, '2025-01-01'),
(7, 7, 1, '2025-01-01'),
(8, 8, 1, '2025-01-01'),
(9, 9, 1, '2025-01-01'),
(10, 10, 1, '2025-01-01');
-- PATIENT_ALLERGY
INSERT INTO PATIENT_ALLERGY (PatientID, AllergyID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
-- APPOINTMENT
INSERT INTO APPOINTMENT (PatientID, StaffID, AppointmentDateTime, Status) VALUES
(1, 1, '2025-06-01T09:00:00', 'Completed'),
(2, 2, '2025-06-02T09:00:00', 'Completed'),
(3, 3, '2025-06-03T09:00:00', 'Completed'),
(4, 4, '2025-06-04T09:00:00', 'Completed'),
(5, 5, '2025-06-05T09:00:00', 'Completed'),
(6, 6, '2025-06-06T09:00:00', 'Completed'),
(7, 7, '2025-06-07T09:00:00', 'Completed'),
(8, 8, '2025-06-08T09:00:00', 'Completed'),
(9, 9, '2025-06-09T09:00:00', 'Completed'),
(10, 10, '2025-06-10T09:00:00', 'Completed');
-- VISIT
INSERT INTO VISIT (AppointmentID, CheckInTime, CheckOutTime) VALUES
(1, '2025-06-01T09:00:00', '2025-06-01T10:00:00'),
(2, '2025-06-02T09:00:00', '2025-06-02T10:00:00'),
(3, '2025-06-03T09:00:00', '2025-06-03T10:00:00'),
(4, '2025-06-04T09:00:00', '2025-06-04T10:00:00'),
(5, '2025-06-05T09:00:00', '2025-06-05T10:00:00'),
(6, '2025-06-06T09:00:00', '2025-06-06T10:00:00'),
(7, '2025-06-07T09:00:00', '2025-06-07T10:00:00'),
(8, '2025-06-08T09:00:00', '2025-06-08T10:00:00'),
(9, '2025-06-09T09:00:00', '2025-06-09T10:00:00'),
(10, '2025-06-10T09:00:00', '2025-06-10T10:00:00');
-- VISIT_STAFF
INSERT INTO VISIT_STAFF (VisitID, StaffID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
-- VITAL_SIGN
INSERT INTO VITAL_SIGN (VisitID, VitalSignTypeID, Reading) VALUES
(1, 1, 71),
(2, 2, 72),
(3, 3, 73),
(4, 4, 74),
(5, 5, 75),
(6, 6, 76),
(7, 7, 77),
(8, 8, 78),
(9, 9, 79),
(10, 10, 80);
-- VISIT_DIAGNOSIS
INSERT INTO VISIT_DIAGNOSIS (VisitID, DiagnosisID, DiagnosisDate, IsPrimary) VALUES
(1, 1, '2025-06-01', 'Y'),
(2, 2, '2025-06-02', 'Y'),
(3, 3, '2025-06-03', 'Y'),
(4, 4, '2025-06-04', 'Y'),
(5, 5, '2025-06-05', 'Y'),
(6, 6, '2025-06-06', 'Y'),
(7, 7, '2025-06-07', 'Y'),
(8, 8, '2025-06-08', 'Y'),
(9, 9, '2025-06-09', 'Y'),
(10, 10, '2025-06-10', 'Y');
-- PRESCRIPTION
INSERT INTO PRESCRIPTION (VisitID, MedicationID, PrescriptionDate, Dosage) VALUES
(1, 1, '2025-06-01', 'One tablet'),
(2, 2, '2025-06-02', 'One tablet'),
(3, 3, '2025-06-03', 'One tablet'),
(4, 4, '2025-06-04', 'One tablet'),
(5, 5, '2025-06-05', 'One tablet'),
(6, 6, '2025-06-06', 'One tablet'),
(7, 7, '2025-06-07', 'One tablet'),
(8, 8, '2025-06-08', 'One tablet'),
(9, 9, '2025-06-09', 'One tablet'),
(10, 10, '2025-06-10', 'One tablet');
-- LAB_TEST
INSERT INTO LAB_TEST (VisitID, StaffID, TestName) VALUES
(1, 31, 'Test 1'),
(2, 32, 'Test 2'),
(3, 33, 'Test 3'),
(4, 34, 'Test 4'),
(5, 35, 'Test 5'),
(6, 36, 'Test 6'),
(7, 37, 'Test 7'),
(8, 38, 'Test 8'),
(9, 39, 'Test 9'),
(10, 40, 'Test 10');
-- BILL
INSERT INTO BILL (VisitID, TotalAmount, Status) VALUES
(1, 200, 'Paid'),
(2, 200, 'Paid'),
(3, 200, 'Paid'),
(4, 200, 'Paid'),
(5, 200, 'Paid'),
(6, 200, 'Paid'),
(7, 200, 'Paid'),
(8, 200, 'Paid'),
(9, 200, 'Paid'),
(10, 200, 'Paid');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (1, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (1, 1, 'CLAIM1', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (1, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (2, 'Credit Card', 'RECEIPT1');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (2, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (3, 2, 'CLAIM2', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (2, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (4, 'Credit Card', 'RECEIPT2');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (3, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (5, 3, 'CLAIM3', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (3, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (6, 'Credit Card', 'RECEIPT3');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (4, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (7, 4, 'CLAIM4', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (4, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (8, 'Credit Card', 'RECEIPT4');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (5, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (9, 5, 'CLAIM5', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (5, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (10, 'Credit Card', 'RECEIPT5');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (6, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (11, 6, 'CLAIM6', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (6, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (12, 'Credit Card', 'RECEIPT6');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (7, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (13, 7, 'CLAIM7', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (7, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (14, 'Credit Card', 'RECEIPT7');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (8, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (15, 8, 'CLAIM8', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (8, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (16, 'Credit Card', 'RECEIPT8');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (9, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (17, 9, 'CLAIM9', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (9, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (18, 'Credit Card', 'RECEIPT9');
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (10, 150, 'INSURANCE');
INSERT INTO INSURANCE_PAYMENT (PaymentID, PatientInsuranceID, ClaimNumber, AmountApproved) VALUES (19, 10, 'CLAIM10', 150);
INSERT INTO PAYMENT (BillID, Amount, PaymentType) VALUES (10, 50, 'PATIENT');
INSERT INTO PATIENT_PAYMENT (PaymentID, PaymentMethod, ReceiptNumber) VALUES (20, 'Credit Card', 'RECEIPT10');
GO
