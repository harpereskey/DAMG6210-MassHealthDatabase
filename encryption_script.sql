-- DAMG 6210 - Massachusetts Health Network
-- Group 4
-- Team: Eda Imer, Khushi Trivedi, Harper Eskey
-- P5: Column Data Encryption

USE MassHealthNetwork;
GO

-- Create a database master key

IF NOT EXISTS
(
    SELECT * FROM sys.symmetric_keys
    WHERE name = '##MS_DatabaseMasterKey##'
)
BEGIN
    CREATE MASTER KEY
    ENCRYPTION BY PASSWORD = 'MHN_Demo_Key_2026!Secure';
END;
GO

-- Create a certificate for encryption

IF NOT EXISTS
(
    SELECT * FROM sys.certificates
    WHERE name = 'PatientCertificate'
)
BEGIN
    CREATE CERTIFICATE PatientCertificate
    WITH SUBJECT = 'Patient Data Encryption';
END;
GO

-- Create an AES-256 symmetric key

IF NOT EXISTS
(
    SELECT * FROM sys.symmetric_keys
    WHERE name = 'PatientSymmetricKey'
)
BEGIN
    CREATE SYMMETRIC KEY PatientSymmetricKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE PatientCertificate;
END;
GO

-- Add a column to store encrypted email addresses

IF COL_LENGTH('PATIENT', 'EncryptedEmail') IS NULL
BEGIN
    ALTER TABLE PATIENT
    ADD EncryptedEmail VARBINARY(256);
END;
GO

-- Open the symmetric key

OPEN SYMMETRIC KEY PatientSymmetricKey
DECRYPTION BY CERTIFICATE PatientCertificate;

-- Encrypt existing patient email addresses

UPDATE PATIENT
SET EncryptedEmail = EncryptByKey
(
    Key_GUID('PatientSymmetricKey'),
    Email
)
WHERE Email IS NOT NULL;

-- Close the symmetric key

CLOSE SYMMETRIC KEY PatientSymmetricKey;
GO

-- Add fictional patient email addresses for demonstration

UPDATE PATIENT
SET Email = 'patient1@example.com'
WHERE PatientID = 1 AND EncryptedEmail IS NULL;

UPDATE PATIENT
SET Email = 'patient2@example.com'
WHERE PatientID = 2 AND EncryptedEmail IS NULL;

UPDATE PATIENT
SET Email = 'patient3@example.com'
WHERE PatientID = 3 AND EncryptedEmail IS NULL;
GO

-- Open the symmetric key

OPEN SYMMETRIC KEY PatientSymmetricKey
DECRYPTION BY CERTIFICATE PatientCertificate;

-- Encrypt patient email addresses

UPDATE PATIENT
SET EncryptedEmail = EncryptByKey
(
    Key_GUID('PatientSymmetricKey'),
    Email
)
WHERE Email IS NOT NULL;

-- Display encrypted data

SELECT PatientID, Email, EncryptedEmail
FROM PATIENT
WHERE EncryptedEmail IS NOT NULL;

-- Demonstrate decryption

SELECT
    PatientID,
    EncryptedEmail,
    CONVERT(VARCHAR(100),
        DecryptByKey(EncryptedEmail)) AS DecryptedEmail
FROM PATIENT
WHERE EncryptedEmail IS NOT NULL;

-- Close the symmetric key

CLOSE SYMMETRIC KEY PatientSymmetricKey;
GO

-- Remove plaintext emails after verifying encryption

OPEN SYMMETRIC KEY PatientSymmetricKey
DECRYPTION BY CERTIFICATE PatientCertificate;

UPDATE PATIENT
SET Email = NULL
WHERE Email IS NOT NULL
AND CONVERT(VARCHAR(100),
    DecryptByKey(EncryptedEmail)) = Email;

CLOSE SYMMETRIC KEY PatientSymmetricKey;
GO

-- Verify that emails are stored in encrypted form

SELECT PatientID, Email, EncryptedEmail
FROM PATIENT
WHERE EncryptedEmail IS NOT NULL;
GO