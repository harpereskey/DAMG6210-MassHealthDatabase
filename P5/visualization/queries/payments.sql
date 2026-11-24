-- DAMG 6210 | Massachusetts Health Network | Group 4
-- payments.sql: one row per payment, flattened for Tableau. Relate to billing on BillID.
-- Subtype columns are wrapped in ISNULL(..., '') so a CSV export shows
-- empty cells instead of the text "NULL".

USE MassHealthNetwork;
SET NOCOUNT ON;

SELECT
    pay.PaymentID,
    pay.BillID,
    b.VisitID,
    pay.Amount,
    CONVERT(VARCHAR(10), pay.PaymentDate, 120)          AS PaymentDate,
    pay.PaymentType,
    ISNULL(ic.CompanyName, '')                          AS Insurer,
    ISNULL(ip.ClaimNumber, '')                          AS ClaimNumber,
    ISNULL(CAST(ip.AmountApproved AS VARCHAR(20)), '')  AS AmountApproved,
    ISNULL(pp.PaymentMethod, '')                        AS PaymentMethod
FROM PAYMENT pay
JOIN BILL b                    ON b.BillID = pay.BillID
LEFT JOIN INSURANCE_PAYMENT ip ON ip.PaymentID = pay.PaymentID
LEFT JOIN PATIENT_INSURANCE pi ON pi.PatientInsuranceID = ip.PatientInsuranceID
LEFT JOIN INSURANCE_COMPANY ic ON ic.InsuranceCompanyID = pi.InsuranceCompanyID
LEFT JOIN PATIENT_PAYMENT pp   ON pp.PaymentID = pay.PaymentID
ORDER BY pay.PaymentID;
