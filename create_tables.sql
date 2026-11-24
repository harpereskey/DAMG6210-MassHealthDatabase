-- DAMG 6210 - Massachusetts Health Network - Group 4

/* 
   -- Massachusetts Health Network Database
   DAMG 6210: Data Management and Database Design, Group 4
   Team: Eda Imer, Khushi Trivedi, Harper Eskey

*/
IF DB_ID('MassHealthNetwork') IS NULL
BEGIN
    CREATE DATABASE MassHealthNetwork;
END;
GO

USE MassHealthNetwork;
GO


DROP TABLE IF EXISTS PATIENT_PAYMENT, INSURANCE_PAYMENT, PAYMENT, BILL,
                     LAB_TEST, PRESCRIPTION, VISIT_DIAGNOSIS, VITAL_SIGN,
                     VISIT_STAFF, VISIT, APPOINTMENT, PATIENT_ALLERGY,
                     PATIENT_VACCINATION, PATIENT_INSURANCE, MEDICATION,
                     DIAGNOSIS, VITAL_SIGN_TYPE, ALLERGY, VACCINE,
                     NURSE, DOCTOR, RECEPTIONIST, LAB_TECHNICIAN, STAFF,
                     PATIENT, INSURANCE_COMPANY;
GO


/* --------------------------------------------------------------------------
   1. Independent (parent) entities
   -------------------------------------------------------------------------- */
CREATE TABLE INSURANCE_COMPANY (
    InsuranceCompanyID  INT IDENTITY(1,1)             NOT NULL,
    CompanyName         VARCHAR(100)    NOT NULL,
    Phone               VARCHAR(15)     NULL,
    Street              VARCHAR(100)    NULL,
    City                VARCHAR(50)     NULL,
    State               CHAR(2)         NULL,
    ZipCode             VARCHAR(10)     NULL,
    CONSTRAINT PK_INSURANCE_COMPANY PRIMARY KEY (InsuranceCompanyID),
    CONSTRAINT UQ_INSURANCE_COMPANY_Name UNIQUE (CompanyName)
);

CREATE TABLE PATIENT (
    PatientID           INT IDENTITY(1,1)             NOT NULL,
    FirstName           VARCHAR(50)     NOT NULL,
    LastName            VARCHAR(50)     NOT NULL,
    DateOfBirth         DATE            NOT NULL,
    Gender              VARCHAR(20)     NULL,
    Phone               VARCHAR(15)     NULL,
    Email               VARCHAR(100)    NULL,
    Street              VARCHAR(100)    NULL,
    City                VARCHAR(50)     NULL,
    State               CHAR(2)         NULL,
    ZipCode             VARCHAR(10)     NULL,
    CONSTRAINT PK_PATIENT PRIMARY KEY (PatientID),
    CONSTRAINT CK_PATIENT_DOB CHECK (DateOfBirth <= CAST(GETDATE() AS DATE))
);

CREATE TABLE STAFF (
    StaffID             INT IDENTITY(1,1)             NOT NULL,
    FirstName           VARCHAR(50)     NOT NULL,
    LastName            VARCHAR(50)     NOT NULL,
    StaffType           VARCHAR(20)     NOT NULL,
    Phone               VARCHAR(15)     NULL,
    Email               VARCHAR(100)    NULL,
    HireDate            DATE            NOT NULL,
    CONSTRAINT PK_STAFF PRIMARY KEY (StaffID),
    -- discriminator for the disjoint STAFF subtypes
    CONSTRAINT CK_STAFF_StaffType CHECK (StaffType IN ('DOCTOR', 'NURSE', 'RECEPTIONIST', 'LAB_TECHNICIAN'))
);
GO


/* --------------------------------------------------------------------------
   2. STAFF subtypes (PK is also FK to STAFF)
   -------------------------------------------------------------------------- */
CREATE TABLE NURSE (
    StaffID             INT             NOT NULL,
    LicenseNumber       VARCHAR(30)     NOT NULL,
    Shift               VARCHAR(20)     NULL,
    CONSTRAINT PK_NURSE PRIMARY KEY (StaffID),
    CONSTRAINT FK_NURSE_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID) ON DELETE CASCADE,
    CONSTRAINT UQ_NURSE_License UNIQUE (LicenseNumber)
);

CREATE TABLE DOCTOR (
    StaffID             INT             NOT NULL,
    Specialty           VARCHAR(50)     NOT NULL,
    LicenseNumber       VARCHAR(30)     NOT NULL,
    CONSTRAINT PK_DOCTOR PRIMARY KEY (StaffID),
    CONSTRAINT FK_DOCTOR_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID) ON DELETE CASCADE,
    CONSTRAINT UQ_DOCTOR_License UNIQUE (LicenseNumber)
);

CREATE TABLE RECEPTIONIST (
    StaffID             INT             NOT NULL,
    Shift               VARCHAR(20)     NULL,
    CONSTRAINT PK_RECEPTIONIST PRIMARY KEY (StaffID),
    CONSTRAINT FK_RECEPTIONIST_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID) ON DELETE CASCADE
);

CREATE TABLE LAB_TECHNICIAN (
    StaffID             INT             NOT NULL,
    Certification       VARCHAR(50)     NULL,
    CONSTRAINT PK_LAB_TECHNICIAN PRIMARY KEY (StaffID),
    CONSTRAINT FK_LAB_TECHNICIAN_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID) ON DELETE CASCADE
);
GO


/* --------------------------------------------------------------------------
   3. Reference entities
   -------------------------------------------------------------------------- */
CREATE TABLE VACCINE (
    VaccineID           INT IDENTITY(1,1)             NOT NULL,
    VaccineName         VARCHAR(100)    NOT NULL,
    Manufacturer        VARCHAR(100)    NULL,
    CONSTRAINT PK_VACCINE PRIMARY KEY (VaccineID),
    CONSTRAINT UQ_VACCINE_NameMfr UNIQUE (VaccineName, Manufacturer)
);

CREATE TABLE ALLERGY (
    AllergyID           INT IDENTITY(1,1)             NOT NULL,
    AllergyName         VARCHAR(100)    NOT NULL,
    AllergyType         VARCHAR(30)     NULL,
    CONSTRAINT PK_ALLERGY PRIMARY KEY (AllergyID),
    CONSTRAINT UQ_ALLERGY_Name UNIQUE (AllergyName)
);

CREATE TABLE VITAL_SIGN_TYPE (
    VitalSignTypeID     INT IDENTITY(1,1)             NOT NULL,
    TypeName            VARCHAR(50)     NOT NULL,
    Unit                VARCHAR(20)     NULL,
    CONSTRAINT PK_VITAL_SIGN_TYPE PRIMARY KEY (VitalSignTypeID),
    CONSTRAINT UQ_VITAL_SIGN_TYPE_Name UNIQUE (TypeName)
);

CREATE TABLE DIAGNOSIS (
    DiagnosisID         INT IDENTITY(1,1)             NOT NULL,
    DiagnosisCode       VARCHAR(10)     NOT NULL,
    DiagnosisName       VARCHAR(100)    NOT NULL,
    Description         VARCHAR(500)    NULL,
    CONSTRAINT PK_DIAGNOSIS PRIMARY KEY (DiagnosisID),
    CONSTRAINT UQ_DIAGNOSIS_Code UNIQUE (DiagnosisCode)
);

CREATE TABLE MEDICATION (
    MedicationID        INT IDENTITY(1,1)             NOT NULL,
    MedicationName      VARCHAR(100)    NOT NULL,
    Form                VARCHAR(30)     NULL,
    Strength            VARCHAR(30)     NULL,
    CONSTRAINT PK_MEDICATION PRIMARY KEY (MedicationID),
    CONSTRAINT UQ_MEDICATION UNIQUE (MedicationName, Form, Strength)
);
GO


/* --------------------------------------------------------------------------
   4. Patient level associative entities
   -------------------------------------------------------------------------- */
CREATE TABLE PATIENT_INSURANCE (
    PatientInsuranceID  INT IDENTITY(1,1)             NOT NULL,
    PatientID           INT             NOT NULL,
    InsuranceCompanyID  INT             NOT NULL,
    PolicyNumber        VARCHAR(30)     NOT NULL,
    CoverageType        VARCHAR(30)     NULL,
    CoverageStartDate   DATE            NOT NULL,
    CoverageEndDate     DATE            NULL,
    CONSTRAINT PK_PATIENT_INSURANCE PRIMARY KEY (PatientInsuranceID),
    CONSTRAINT FK_PATIENT_INSURANCE_PATIENT FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID),
    CONSTRAINT FK_PATIENT_INSURANCE_COMPANY FOREIGN KEY (InsuranceCompanyID) REFERENCES INSURANCE_COMPANY (InsuranceCompanyID),
    CONSTRAINT UQ_PATIENT_INSURANCE_Policy UNIQUE (InsuranceCompanyID, PolicyNumber, PatientID),
    CONSTRAINT CK_PATIENT_INSURANCE_Dates CHECK (CoverageEndDate IS NULL OR CoverageEndDate >= CoverageStartDate)
);

CREATE TABLE PATIENT_VACCINATION (
    PatientVaccinationID INT IDENTITY(1,1)            NOT NULL,
    PatientID           INT             NOT NULL,
    VaccineID           INT             NOT NULL,
    DoseNumber          TINYINT         NOT NULL,
    DateGiven           DATE            NOT NULL,
    CONSTRAINT PK_PATIENT_VACCINATION PRIMARY KEY (PatientVaccinationID),
    CONSTRAINT FK_PATIENT_VACCINATION_PATIENT FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID),
    CONSTRAINT FK_PATIENT_VACCINATION_VACCINE FOREIGN KEY (VaccineID) REFERENCES VACCINE (VaccineID),
    CONSTRAINT UQ_PATIENT_VACCINATION_Dose UNIQUE (PatientID, VaccineID, DoseNumber),
    CONSTRAINT CK_PATIENT_VACCINATION_Dose CHECK (DoseNumber > 0)
);

CREATE TABLE PATIENT_ALLERGY (
    PatientAllergyID    INT IDENTITY(1,1)             NOT NULL,
    PatientID           INT             NOT NULL,
    AllergyID           INT             NOT NULL,
    Reaction            VARCHAR(200)    NULL,
    Severity            VARCHAR(10)     NULL,
    DateRecorded        DATE            NOT NULL CONSTRAINT DF_PATIENT_ALLERGY_Date DEFAULT (CAST(GETDATE() AS DATE)),
    CONSTRAINT PK_PATIENT_ALLERGY PRIMARY KEY (PatientAllergyID),
    CONSTRAINT FK_PATIENT_ALLERGY_PATIENT FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID),
    CONSTRAINT FK_PATIENT_ALLERGY_ALLERGY FOREIGN KEY (AllergyID) REFERENCES ALLERGY (AllergyID),
    CONSTRAINT UQ_PATIENT_ALLERGY UNIQUE (PatientID, AllergyID),
    CONSTRAINT CK_PATIENT_ALLERGY_Severity CHECK (Severity IN ('Mild', 'Moderate', 'Severe'))
);
GO


/* --------------------------------------------------------------------------
   5. Appointments and visits
   -------------------------------------------------------------------------- */
CREATE TABLE APPOINTMENT (
    AppointmentID       INT IDENTITY(1,1)             NOT NULL,
    PatientID           INT             NOT NULL,
    StaffID             INT             NOT NULL,
    AppointmentDateTime DATETIME2       NOT NULL,
    Reason              VARCHAR(200)    NULL,
    Status              VARCHAR(20)     NOT NULL CONSTRAINT DF_APPOINTMENT_Status DEFAULT ('Scheduled'),
    CONSTRAINT PK_APPOINTMENT PRIMARY KEY (AppointmentID),
    CONSTRAINT FK_APPOINTMENT_PATIENT FOREIGN KEY (PatientID) REFERENCES PATIENT (PatientID),
    -- "Scheduled with" on the ERD connects to STAFF
    CONSTRAINT FK_APPOINTMENT_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID),
    CONSTRAINT CK_APPOINTMENT_Status CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled', 'No Show'))
);

CREATE TABLE VISIT (
    VisitID             INT IDENTITY(1,1)             NOT NULL,
    AppointmentID       INT             NOT NULL,
    CheckInTime         DATETIME2       NOT NULL,
    CheckOutTime        DATETIME2       NULL,
    Symptoms            VARCHAR(500)    NULL,
    DoctorNotes         VARCHAR(2000)   NULL,
    CONSTRAINT PK_VISIT PRIMARY KEY (VisitID),
    CONSTRAINT FK_VISIT_APPOINTMENT FOREIGN KEY (AppointmentID) REFERENCES APPOINTMENT (AppointmentID),
    -- one visit per appointment
    CONSTRAINT UQ_VISIT_Appointment UNIQUE (AppointmentID),
    CONSTRAINT CK_VISIT_Times CHECK (CheckOutTime IS NULL OR CheckOutTime >= CheckInTime)
);

CREATE TABLE VISIT_STAFF (
    VisitStaffID        INT IDENTITY(1,1)             NOT NULL,
    VisitID             INT             NOT NULL,
    StaffID             INT             NOT NULL,
    StaffRole           VARCHAR(30)     NULL,
    CONSTRAINT PK_VISIT_STAFF PRIMARY KEY (VisitStaffID),
    CONSTRAINT FK_VISIT_STAFF_VISIT FOREIGN KEY (VisitID) REFERENCES VISIT (VisitID),
    CONSTRAINT FK_VISIT_STAFF_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID),
    CONSTRAINT UQ_VISIT_STAFF UNIQUE (VisitID, StaffID)
);

CREATE TABLE VITAL_SIGN (
    VitalSignID         INT IDENTITY(1,1)             NOT NULL,
    VisitID             INT             NOT NULL,
    VitalSignTypeID     INT             NOT NULL,
    Reading             DECIMAL(6,2)    NOT NULL,
    TimeTaken           DATETIME2       NOT NULL CONSTRAINT DF_VITAL_SIGN_Time DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_VITAL_SIGN PRIMARY KEY (VitalSignID),
    CONSTRAINT FK_VITAL_SIGN_VISIT FOREIGN KEY (VisitID) REFERENCES VISIT (VisitID),
    CONSTRAINT FK_VITAL_SIGN_TYPE FOREIGN KEY (VitalSignTypeID) REFERENCES VITAL_SIGN_TYPE (VitalSignTypeID)
);

CREATE TABLE VISIT_DIAGNOSIS (
    VisitDiagnosisID    INT IDENTITY(1,1)             NOT NULL,
    VisitID             INT             NOT NULL,
    DiagnosisID         INT             NOT NULL,
    DiagnosisDate       DATE            NOT NULL,
    IsPrimary           CHAR(1)         NOT NULL CONSTRAINT DF_VISIT_DIAGNOSIS_Primary DEFAULT ('N'),
    CONSTRAINT PK_VISIT_DIAGNOSIS PRIMARY KEY (VisitDiagnosisID),
    CONSTRAINT FK_VISIT_DIAGNOSIS_VISIT FOREIGN KEY (VisitID) REFERENCES VISIT (VisitID),
    CONSTRAINT FK_VISIT_DIAGNOSIS_DIAGNOSIS FOREIGN KEY (DiagnosisID) REFERENCES DIAGNOSIS (DiagnosisID),
    CONSTRAINT UQ_VISIT_DIAGNOSIS UNIQUE (VisitID, DiagnosisID),
    CONSTRAINT CK_VISIT_DIAGNOSIS_Primary CHECK (IsPrimary IN ('Y', 'N'))
);

CREATE TABLE PRESCRIPTION (
    PrescriptionID      INT IDENTITY(1,1)             NOT NULL,
    VisitID             INT             NOT NULL,
    MedicationID        INT             NOT NULL,
    PrescriptionDate    DATE            NOT NULL,
    Dosage              VARCHAR(50)     NOT NULL,
    Frequency           VARCHAR(50)     NULL,
    Duration            VARCHAR(30)     NULL,
    CONSTRAINT PK_PRESCRIPTION PRIMARY KEY (PrescriptionID),
    CONSTRAINT FK_PRESCRIPTION_VISIT FOREIGN KEY (VisitID) REFERENCES VISIT (VisitID),
    CONSTRAINT FK_PRESCRIPTION_MEDICATION FOREIGN KEY (MedicationID) REFERENCES MEDICATION (MedicationID)
);

CREATE TABLE LAB_TEST (
    LabTestID           INT IDENTITY(1,1)             NOT NULL,
    VisitID             INT             NOT NULL,
    StaffID             INT             NULL,       
    TestName            VARCHAR(100)    NOT NULL,
    Result              VARCHAR(200)    NULL,
    NormalRange         VARCHAR(50)     NULL,       
    ResultDate          DATE            NULL,
    CONSTRAINT PK_LAB_TEST PRIMARY KEY (LabTestID),
    CONSTRAINT FK_LAB_TEST_VISIT FOREIGN KEY (VisitID) REFERENCES VISIT (VisitID),
    CONSTRAINT FK_LAB_TEST_STAFF FOREIGN KEY (StaffID) REFERENCES STAFF (StaffID)
);
GO


/* --------------------------------------------------------------------------
   6. Billing and payments
   -------------------------------------------------------------------------- */
CREATE TABLE BILL (
    BillID              INT IDENTITY(1,1)             NOT NULL,
    VisitID             INT             NOT NULL,
    BillDate            DATE            NOT NULL CONSTRAINT DF_BILL_Date DEFAULT (CAST(GETDATE() AS DATE)),
    TotalAmount         DECIMAL(10,2)   NOT NULL,
    Status              VARCHAR(20)     NOT NULL CONSTRAINT DF_BILL_Status DEFAULT ('Unpaid'),  -- intentional denormalization
    CONSTRAINT PK_BILL PRIMARY KEY (BillID),
    CONSTRAINT FK_BILL_VISIT FOREIGN KEY (VisitID) REFERENCES VISIT (VisitID),
    -- a visit generates zero or one bill
    CONSTRAINT UQ_BILL_Visit UNIQUE (VisitID),
    CONSTRAINT CK_BILL_Amount CHECK (TotalAmount >= 0),
    CONSTRAINT CK_BILL_Status CHECK (Status IN ('Unpaid', 'Partially Paid', 'Paid'))
);

CREATE TABLE PAYMENT (
    PaymentID           INT IDENTITY(1,1)             NOT NULL,
    BillID              INT             NOT NULL,
    Amount              DECIMAL(10,2)   NOT NULL,
    PaymentDate         DATE            NOT NULL CONSTRAINT DF_PAYMENT_Date DEFAULT (CAST(GETDATE() AS DATE)),
    PaymentType         VARCHAR(20)     NOT NULL,
    CONSTRAINT PK_PAYMENT PRIMARY KEY (PaymentID),
    CONSTRAINT FK_PAYMENT_BILL FOREIGN KEY (BillID) REFERENCES BILL (BillID),
    CONSTRAINT CK_PAYMENT_Amount CHECK (Amount > 0),
    -- discriminator for the disjoint PAYMENT subtypes
    CONSTRAINT CK_PAYMENT_Type CHECK (PaymentType IN ('INSURANCE', 'PATIENT'))
);

CREATE TABLE INSURANCE_PAYMENT (
    PaymentID           INT             NOT NULL,
    PatientInsuranceID  INT             NOT NULL,
    ClaimNumber         VARCHAR(30)     NOT NULL,
    AmountApproved      DECIMAL(10,2)   NULL,
    CONSTRAINT PK_INSURANCE_PAYMENT PRIMARY KEY (PaymentID),
    CONSTRAINT FK_INSURANCE_PAYMENT_PAYMENT FOREIGN KEY (PaymentID) REFERENCES PAYMENT (PaymentID) ON DELETE CASCADE,
    CONSTRAINT FK_INSURANCE_PAYMENT_POLICY FOREIGN KEY (PatientInsuranceID) REFERENCES PATIENT_INSURANCE (PatientInsuranceID),
    CONSTRAINT UQ_INSURANCE_PAYMENT_Claim UNIQUE (ClaimNumber),
    CONSTRAINT CK_INSURANCE_PAYMENT_Amount CHECK (AmountApproved IS NULL OR AmountApproved >= 0)
);

CREATE TABLE PATIENT_PAYMENT (
    PaymentID           INT             NOT NULL,
    PaymentMethod       VARCHAR(20)     NOT NULL,
    ReceiptNumber       VARCHAR(30)     NULL,
    CONSTRAINT PK_PATIENT_PAYMENT PRIMARY KEY (PaymentID),
    CONSTRAINT FK_PATIENT_PAYMENT_PAYMENT FOREIGN KEY (PaymentID) REFERENCES PAYMENT (PaymentID) ON DELETE CASCADE,
    CONSTRAINT CK_PATIENT_PAYMENT_Method CHECK (PaymentMethod IN ('Cash', 'Credit Card', 'Debit Card', 'Check', 'Online'))
);
GO
