-- DAMG 6210 - Massachusetts Health Network
-- Group 4
-- Team: Eda Imer, Khushi Trivedi, Harper Eskey
-- P5: Non-Clustered Indexes

USE MassHealthNetwork;
GO

-- Index 1: Improve patient searches by last name

DROP INDEX IF EXISTS IX_Patient_LastName ON PATIENT;
GO

CREATE NONCLUSTERED INDEX IX_Patient_LastName
ON PATIENT (LastName);
GO


-- Index 2: Improve appointment searches by patient ID

DROP INDEX IF EXISTS IX_Appointment_PatientID ON APPOINTMENT;
GO

CREATE NONCLUSTERED INDEX IX_Appointment_PatientID
ON APPOINTMENT (PatientID);
GO


-- Index 3: Improve payment searches by bill ID

DROP INDEX IF EXISTS IX_Payment_BillID ON PAYMENT;
GO

CREATE NONCLUSTERED INDEX IX_Payment_BillID
ON PAYMENT (BillID);
GO

-- Verify all three non-clustered indexes
USE MassHealthNetwork;
GO

SELECT
    OBJECT_NAME(object_id) AS TableName,
    name AS IndexName,
    type_desc AS IndexType
FROM sys.indexes
WHERE name IN
(
    'IX_Patient_LastName',
    'IX_Appointment_PatientID',
    'IX_Payment_BillID'
);