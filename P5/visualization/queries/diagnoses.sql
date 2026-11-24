-- DAMG 6210 | Massachusetts Health Network | Group 4
-- diagnoses.sql: export of the PatientDiagnosisReport view for Tableau.
-- PatientName is left out on purpose so no patient names reach the dashboard files.

USE MassHealthNetwork;
SET NOCOUNT ON;

SELECT
    PatientID,
    VisitID,
    DiagnosisCode,
    DiagnosisName,
    CONVERT(VARCHAR(10), DiagnosisDate, 120)  AS DiagnosisDate,
    IsPrimary
FROM PatientDiagnosisReport
ORDER BY VisitID, IsPrimary DESC;
