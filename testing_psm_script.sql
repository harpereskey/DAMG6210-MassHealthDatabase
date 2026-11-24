USE MassHealthNetwork;
GO

DECLARE @Message VARCHAR(500);

EXEC RegisterPatient
    @FirstName = 'Emma',
    @LastName = 'Wilson',
    @DateOfBirth = '2000-05-15',
    @Gender = 'Female',
    @Phone = '6175550101',
    @Message = @Message OUTPUT;

SELECT @Message AS Result;

SELECT * FROM PATIENT;

GO

-- Test Stored Procedure 2: ScheduleAppointment

DECLARE @Message VARCHAR(500);

EXEC ScheduleAppointment
    @PatientID = 1002,
    @StaffID = 1,
    @AppointmentDateTime = '2026-12-01T10:00:00',
    @Reason = 'Annual checkup',
    @Message = @Message OUTPUT;

SELECT @Message AS Result;

SELECT * FROM APPOINTMENT;

GO

-- Test Stored Procedure 3 and DML Trigger

BEGIN TRANSACTION;

DECLARE @AppointmentID INT;
DECLARE @VisitID INT;
DECLARE @BillID INT;
DECLARE @Message VARCHAR(500);

-- Create a test appointment
INSERT INTO APPOINTMENT
    (PatientID, StaffID, AppointmentDateTime, Status)
VALUES
    (1002, 1, '2026-11-24T09:00:00', 'Completed');

SET @AppointmentID = SCOPE_IDENTITY();

-- Create a test visit
INSERT INTO VISIT
    (AppointmentID, CheckInTime, CheckOutTime)
VALUES
    (@AppointmentID, '2026-11-24T09:00:00',
     '2026-11-24T10:00:00');

SET @VisitID = SCOPE_IDENTITY();

-- Create an unpaid bill
INSERT INTO BILL
    (VisitID, TotalAmount, Status)
VALUES
    (@VisitID, 200, 'Unpaid');

SET @BillID = SCOPE_IDENTITY();

-- Display the original bill
SELECT * FROM BILL
WHERE BillID = @BillID;

-- Record a partial payment
EXEC RecordPayment
    @BillID = @BillID,
    @Amount = 50,
    @PaymentMethod = 'Credit Card',
    @ReceiptNumber = 'TEST001',
    @Message = @Message OUTPUT;

SELECT @Message AS Result;

SELECT * FROM BILL
WHERE BillID = @BillID;

-- Record the remaining payment
EXEC RecordPayment
    @BillID = @BillID,
    @Amount = 150,
    @PaymentMethod = 'Credit Card',
    @ReceiptNumber = 'TEST002',
    @Message = @Message OUTPUT;

SELECT @Message AS Result;

SELECT * FROM BILL
WHERE BillID = @BillID;

-- Remove temporary test records
IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;

GO

-- Test View 1: Patient Appointment Report

SELECT * FROM PatientAppointmentReport;


-- Test View 2: Patient Diagnosis Report

SELECT * FROM PatientDiagnosisReport;


-- Test View 3: Billing and Payment Report

SELECT * FROM BillingPaymentReport;

GO

-- Test UDF 1: Calculate Patient Age

SELECT dbo.CalculatePatientAge(1) AS PatientAge;


-- Test UDF 2: Calculate Outstanding Bill Balance

SELECT dbo.CalculateBillBalance(1) AS OutstandingBalance;


-- Test UDF 3: Count Patient Appointments

SELECT dbo.CountPatientAppointments(1) AS AppointmentCount;

GO

-- Test Error Handling

DECLARE @Message VARCHAR(500);

EXEC ScheduleAppointment
    @PatientID = 99999,
    @StaffID = 1,
    @AppointmentDateTime = '2026-12-01T10:00:00',
    @Reason = 'Test appointment',
    @Message = @Message OUTPUT;

SELECT @Message AS Result;

SELECT * FROM APPOINTMENT
WHERE PatientID = 99999;