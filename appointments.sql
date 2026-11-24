-- DAMG 6210 | Massachusetts Health Network | Group 4
-- appointments.sql: export of the PatientAppointmentReport view for Tableau.
-- PatientName is left out on purpose so no patient names reach the dashboard files.

USE MassHealthNetwork;
SET NOCOUNT ON;

SELECT
    AppointmentID,
    PatientID,
    StaffName,
    CONVERT(VARCHAR(19), AppointmentDateTime, 120)  AS AppointmentDateTime,
    ISNULL(Reason, '')                              AS Reason,
    Status
FROM PatientAppointmentReport
ORDER BY AppointmentID;
