-- DAMG 6210 - Massachusetts Health Network
-- Group 4
-- Team: Eda Imer, Khushi Trivedi, Harper Eskey
-- P5: Database Objects and Features

USE MassHealthNetwork;
GO


/* 
   1. STORED PROCEDURES
    */

-- Stored Procedure 1: Register a new patient

DROP PROCEDURE IF EXISTS RegisterPatient;
GO

CREATE PROCEDURE RegisterPatient
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DateOfBirth DATE,
    @Gender VARCHAR(20),
    @Phone VARCHAR(15),
    @Message VARCHAR(500) OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO PATIENT
            (FirstName, LastName, DateOfBirth, Gender, Phone)
        VALUES
            (@FirstName, @LastName, @DateOfBirth, @Gender, @Phone);

        COMMIT TRANSACTION;

        SET @Message = 'Patient registered successfully';
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Message = 'Error occurred during registration: '
                       + ERROR_MESSAGE();
    END CATCH
END;
GO


-- Stored Procedure 2: Schedule a patient appointment

DROP PROCEDURE IF EXISTS ScheduleAppointment;
GO

CREATE PROCEDURE ScheduleAppointment
    @PatientID INT,
    @StaffID INT,
    @AppointmentDateTime DATETIME2,
    @Reason VARCHAR(200),
    @Message VARCHAR(500) OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO APPOINTMENT
            (PatientID, StaffID, AppointmentDateTime, Reason, Status)
        VALUES
            (@PatientID, @StaffID, @AppointmentDateTime,
             @Reason, 'Scheduled');

        COMMIT TRANSACTION;

        SET @Message = 'Appointment scheduled successfully';
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Message = 'Error occurred during scheduling: '
                       + ERROR_MESSAGE();
    END CATCH
END;
GO


-- Stored Procedure 3: Record a patient payment

DROP PROCEDURE IF EXISTS RecordPayment;
GO

CREATE PROCEDURE RecordPayment
    @BillID INT,
    @Amount DECIMAL(10,2),
    @PaymentMethod VARCHAR(20),
    @ReceiptNumber VARCHAR(30),
    @Message VARCHAR(500) OUTPUT
AS
BEGIN
    DECLARE @PaymentID INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO PAYMENT
            (BillID, Amount, PaymentType)
        VALUES
            (@BillID, @Amount, 'PATIENT');

        SET @PaymentID = SCOPE_IDENTITY();

        INSERT INTO PATIENT_PAYMENT
            (PaymentID, PaymentMethod, ReceiptNumber)
        VALUES
            (@PaymentID, @PaymentMethod, @ReceiptNumber);

        COMMIT TRANSACTION;

        SET @Message = 'Payment recorded successfully';
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SET @Message = 'Error occurred during payment: '
                       + ERROR_MESSAGE();
    END CATCH
END;
GO


/* 
   2. VIEWS
    */

-- View 1: Patient appointment report

DROP VIEW IF EXISTS PatientAppointmentReport;
GO

CREATE VIEW PatientAppointmentReport
AS
SELECT
    A.AppointmentID,
    P.PatientID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    S.FirstName + ' ' + S.LastName AS StaffName,
    A.AppointmentDateTime,
    A.Reason,
    A.Status
FROM APPOINTMENT A
JOIN PATIENT P
    ON A.PatientID = P.PatientID
JOIN STAFF S
    ON A.StaffID = S.StaffID;
GO


-- View 2: Patient diagnosis report

DROP VIEW IF EXISTS PatientDiagnosisReport;
GO

CREATE VIEW PatientDiagnosisReport
AS
SELECT
    P.PatientID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    V.VisitID,
    D.DiagnosisCode,
    D.DiagnosisName,
    VD.DiagnosisDate,
    VD.IsPrimary
FROM PATIENT P
JOIN APPOINTMENT A
    ON P.PatientID = A.PatientID
JOIN VISIT V
    ON A.AppointmentID = V.AppointmentID
JOIN VISIT_DIAGNOSIS VD
    ON V.VisitID = VD.VisitID
JOIN DIAGNOSIS D
    ON VD.DiagnosisID = D.DiagnosisID;
GO


-- View 3: Billing and payment report

DROP VIEW IF EXISTS BillingPaymentReport;
GO

CREATE VIEW BillingPaymentReport
AS
SELECT
    B.BillID,
    P.PatientID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    B.BillDate,
    B.TotalAmount,
    ISNULL(SUM(PY.Amount), 0) AS TotalPaid,
    B.TotalAmount - ISNULL(SUM(PY.Amount), 0)
        AS OutstandingBalance,
    B.Status
FROM BILL B
JOIN VISIT V
    ON B.VisitID = V.VisitID
JOIN APPOINTMENT A
    ON V.AppointmentID = A.AppointmentID
JOIN PATIENT P
    ON A.PatientID = P.PatientID
LEFT JOIN PAYMENT PY
    ON B.BillID = PY.BillID
GROUP BY
    B.BillID,
    P.PatientID,
    P.FirstName,
    P.LastName,
    B.BillDate,
    B.TotalAmount,
    B.Status;
GO


/* 
   3. USER-DEFINED FUNCTIONS
    */

-- UDF 1: Calculate patient age

DROP FUNCTION IF EXISTS CalculatePatientAge;
GO

CREATE FUNCTION CalculatePatientAge
(
    @PatientID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    DECLARE @DateOfBirth DATE;

    SELECT @DateOfBirth = DateOfBirth
    FROM PATIENT
    WHERE PatientID = @PatientID;

    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());

    -- Adjust age if the patient's birthday has not occurred
    -- yet this year
    IF DATEADD(YEAR, @Age, @DateOfBirth) > GETDATE()
        SET @Age = @Age - 1;

    RETURN @Age;
END;
GO


-- UDF 2: Calculate outstanding bill balance

DROP FUNCTION IF EXISTS CalculateBillBalance;
GO

CREATE FUNCTION CalculateBillBalance
(
    @BillID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10,2);
    DECLARE @TotalPaid DECIMAL(10,2);
    DECLARE @Balance DECIMAL(10,2);

    SELECT @TotalAmount = TotalAmount
    FROM BILL
    WHERE BillID = @BillID;

    SELECT @TotalPaid = ISNULL(SUM(Amount), 0)
    FROM PAYMENT
    WHERE BillID = @BillID;

    SET @Balance = @TotalAmount - @TotalPaid;

    RETURN @Balance;
END;
GO


-- UDF 3: Count appointments for a patient

DROP FUNCTION IF EXISTS CountPatientAppointments;
GO

CREATE FUNCTION CountPatientAppointments
(
    @PatientID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @AppointmentCount INT;

    SELECT @AppointmentCount = COUNT(*)
    FROM APPOINTMENT
    WHERE PatientID = @PatientID;

    RETURN @AppointmentCount;
END;
GO


/* 
   4. DML TRIGGER
    */

-- Trigger: Automatically update bill status when
-- a payment is inserted, updated or deleted

DROP TRIGGER IF EXISTS UpdateBillStatus;
GO

CREATE TRIGGER UpdateBillStatus
ON PAYMENT
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE BILL
    SET Status =
        CASE
            WHEN ISNULL(
                (SELECT SUM(Amount)
                 FROM PAYMENT
                 WHERE PAYMENT.BillID = BILL.BillID), 0
            ) >= TotalAmount
                THEN 'Paid'

            WHEN ISNULL(
                (SELECT SUM(Amount)
                 FROM PAYMENT
                 WHERE PAYMENT.BillID = BILL.BillID), 0
            ) > 0
                THEN 'Partially Paid'

            ELSE 'Unpaid'
        END
    WHERE BillID IN
    (
        SELECT BillID FROM inserted
        UNION
        SELECT BillID FROM deleted
    );
END;
GO