-- DAMG 6210 | Massachusetts Health Network | Group 4
-- billing.sql: export of the BillingPaymentReport view for Tableau.
-- PatientName is left out on purpose so no patient names reach the dashboard files.

USE MassHealthNetwork;
SET NOCOUNT ON;

SELECT
    BillID,
    PatientID,
    CONVERT(VARCHAR(10), BillDate, 120)  AS BillDate,
    TotalAmount,
    TotalPaid,
    OutstandingBalance,
    Status
FROM BillingPaymentReport
ORDER BY BillID;
