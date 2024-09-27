-- Create database with name "JKHospitalDB"
CREATE DATABASE JKHospitalDB

USE JKHospitalDB

-- Table 1: Query to create "Patients Table"
CREATE TABLE Patients(
	Patient_ID NVARCHAR(10) PRIMARY KEY NOT NULL,
    Full_name NVARCHAR(50) NOT NULL,
    Address NVARCHAR(50) NOT NULL,
    Date_of_birth DATE NOT NULL,
    Insurance NVARCHAR(50) NOT NULL,
    Email_ID NVARCHAR(50) NULL,
    Telephone_number NVARCHAR(20) NULL,
    Username NVARCHAR(50) NOT NULL,
    PasswordHash BINARY(64) NOT NULL, 
	Salt UNIQUEIDENTIFIER,
    Date_left DATE NULL
);

-- Table 2: Query to create "Departments Table"
CREATE TABLE Departments (
    Department_ID NVARCHAR(10) PRIMARY KEY NOT NULL,
    Department_Name NVARCHAR(50) NOT NULL
);
-- Table 3: Query to create "Doctors Table"
CREATE TABLE Doctors(
	Doctor_ID NVARCHAR(10) PRIMARY KEY NOT NULL,
	Doctor_Name NVARCHAR(50) NOT NULL,
	Department_ID NVARCHAR(10) FOREIGN KEY REFERENCES Departments(Department_ID),
    Specialty NVARCHAR(50) NOT NULL
);

-- Table 4: Query to create "Medical Records Table"
CREATE TABLE MedicalRecords (
    Record_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Patient_ID NVARCHAR(10) FOREIGN KEY REFERENCES Patients(Patient_ID),
    Doctor_id NVARCHAR(10) FOREIGN KEY REFERENCES Doctors(Doctor_ID),
    Diagnosis NVARCHAR(50) NOT NULL,
    Medicines NVARCHAR(50) NOT NULL,
	Medicine_Prescribed_Date DATE NOT NULL,
    Allergies NVARCHAR(50) NOT NULL,
	Past_Appointment_Date DATE NULL
);

-- Table 5: Query to create "Appointments Table"
CREATE TABLE Appointments (
    Appointment_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Patient_id NVARCHAR(10) FOREIGN KEY REFERENCES Patients(Patient_ID),
    Doctor_id NVARCHAR(10) FOREIGN KEY REFERENCES Doctors(Doctor_ID),
    Appointment_date DATE NOT NULL,
    Appointment_time TIME NOT NULL,
    Department_id NVARCHAR(10) FOREIGN KEY REFERENCES Departments(Department_ID),
    Status NVARCHAR(20) NOT NULL,
    Patient_Review NVARCHAR(50) NULL 
);

-- Table 6: Query to create "CompletedAppointments Table"
CREATE TABLE CompletedAppointments (
    Appointment_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Patient_id NVARCHAR(10) FOREIGN KEY REFERENCES Patients(Patient_ID),
    Doctor_id NVARCHAR(10) FOREIGN KEY REFERENCES Doctors(Doctor_ID),
    Appointment_date DATE NOT NULL,
    Appointment_time TIME NOT NULL,
    Department_id NVARCHAR(10) FOREIGN KEY REFERENCES Departments(Department_ID),
    Status NVARCHAR(20) NOT NULL,
    Patient_Review NVARCHAR(50) NULL
);

-- Create a Stored Procedure to insert the data into Patients Table
CREATE PROCEDURE uspAddPatient 
@patientid NVARCHAR(10), @fullname NVARCHAR(50),
@address NVARCHAR(50),@dob DATE, @insurance NVARCHAR(50), 
@emailid NVARCHAR(50), @telephone_number NVARCHAR(20), 
@username NVARCHAR(50), @password NVARCHAR(50), @date_left DATE
AS
DECLARE @salt UNIQUEIDENTIFIER=NEWID()
INSERT INTO Patients(Patient_ID, Full_name, Address, Date_of_birth, 
Insurance, Email_ID,Telephone_number, Username, PasswordHash, Salt, Date_left)
VALUES(@patientid, @fullname, @address, @dob, @insurance, @emailid, @telephone_number,
@username, HASHBYTES('SHA2_512', @password+CAST(@salt AS NVARCHAR(36))), @salt, @date_left);

-- Using EXECUTE query to use uspAddPatient Stored Procedure to Insert data
EXECUTE uspAddPatient @patientid = 'P01', @fullname = 'John Doe', @address = '27 Albert Road', @dob = '1975-01-12', 
@insurance = 'Free Insurance', @emailid = 'john.doe@mail.com', @telephone_number = '981 8811 112', 
@username = 'johndoe', @password = 'johnP@ssword', @date_left = NULL
EXECUTE uspAddPatient @patientid = 'P02', @fullname = 'Liam Pain', @address = '72 Robert Road', @dob = '1969-03-02', 
@insurance = 'Dune Insurance', @emailid = 'Liam.Pain@mail.com', @telephone_number = '977 8822 113', 
@username = 'liampain', @password = 'liamP@ssword', @date_left = NULL
EXECUTE uspAddPatient @patientid = 'P03', @fullname = 'Robert Jr', @address = '7 little Road', @dob = '1973-01-12', 
@insurance = 'Pad Insurance', @emailid = 'robert.jr@mail.com', @telephone_number = '881 7711 212', 
@username = 'robertjr', @password = 'robertP@ssword', @date_left = NULL
EXECUTE uspAddPatient @patientid = 'P04', @fullname = 'Thomas Frank', @address = '22 kings lane', @dob = '1988-08-26', 
@insurance = 'Pvt Insurance', @emailid = 'thomas.frank@mail.com', @telephone_number = '987 8212 266', 
@username = 'thomasfrank', @password = 'thomasP@ssword', @date_left = NULL
EXECUTE uspAddPatient @patientid = 'P05', @fullname = 'Tim Kim', @address = '03 allen Road', @dob = '1980-05-08', 
@insurance = 'Gram Insurance', @emailid = 'tim.kim@mail.com', @telephone_number = '781 7811 002', 
@username = 'timkim', @password = 'timkP@ssword', @date_left = NULL
EXECUTE uspAddPatient @patientid = 'P06', @fullname = 'Tina Huang', @address = '24 Finate Lane', @dob = '1990-12-04', 
@insurance = 'Frad Insurance', @emailid = 'tina.huang@mail.com', @telephone_number = '981 8811 112', 
@username = 'tinahuang', @password = 'tinahP@ssword', @date_left = NULL
EXECUTE uspAddPatient @patientid = 'P07', @fullname = 'John Smith', @address = '27 Albert Road', @dob = '1975-01-12', 
@insurance = 'Tong Insurance', @emailid = 'john.smith@mail.com', @telephone_number = '981 8811 112', 
@username = 'johnsmith', @password = 'smithP@ssword', @date_left = '2024-04-15'
EXECUTE uspAddPatient @patientid = 'P08', @fullname = 'Khabib', @address = '14 Little Brooke Close', @dob = '1995-12-04', 
@insurance = 'Eagle Insurance', @emailid = 'Khabib.N@mail.com', @telephone_number = '966 7788 999', 
@username = 'khabibn', @password = 'khabibP@ssword', @date_left = NULL


-- Query to INSERT data into Departments Table
INSERT INTO Departments (department_id, department_name)
VALUES
('DP1', 'Orhtopedics'),('DP2', 'Neurology'), ('DP3', 'Oncology'), ('DP4', 'Cardiology'), 
('DP5', 'Pediatrics'), ('DP6', 'Dermatology'), ('DP7', 'Gastroenterology');


-- Query to INSERT data into Doctors Table
 INSERT INTO Doctors (Doctor_ID, Doctor_Name, Department_ID, Specialty)
 VALUES ('D1', 'Dr. Lewis Hamilton', 'DP1', 'Orthopedician'), ('D2', 'Dr. Fernando Alonso', 'DP2', 'Neurologist'), 
 ('D3','Dr. Max Verstappen', 'DP3', 'Oncologist'), ('D4','Dr. Charles Leclerc', 'DP4', 'Cardiologist'),
 ('D5','Dr. Lando Norris', 'DP5', 'Pediatricion'), ('D6','Dr. Daniel Ricciardo', 'DP6', 'Dermatologist'), 
 ('D7','Dr. Pierre Gasley', 'DP7', 'Gastroenterologist')

 

 -- Query to INSERT data into Appointments Table
 INSERT INTO Appointments (Patient_id, Doctor_id, Appointment_date, Appointment_time, Department_id, Status, Patient_Review)
 VALUES ('P01','D1','2024-05-10','11:00:00','DP1','Pending', NULL),
 ('P02','D2','2024-05-11','14:30:00','DP2','Pending', NULL),
 ('P03','D3','2024-05-14','13:00:00','DP3','Pending',NULL),
 ('P04','D4','2024-05-15','08:00:00','DP4','Pending', NULL),
 ('P05','D5','2024-05-12','16:30:00','DP5','Pending', NULL),
 ('P06','D6','2024-05-13','15:30:00','DP6','Pending', NULL),
 ('P07','D7','2024-05-18','12:30:00','DP7','Pending', NULL),
 ('P08','D1',GETDATE(),'09:30:00','DP1','Pending', NULL)

-- Query to INSERT data into Appointments Table
INSERT INTO MedicalRecords (Patient_id, Doctor_id, Diagnosis, Medicines, Medicine_Prescribed_Date, Allergies, Past_Appointment_Date)
VALUES ('P01','D1','Ligament Tear','Ibuprofen','2024-02-07', 'None', '2024-01-07'),
('P02','D2','Migraine', 'Sumatriptan','2024-02-08', 'Fish', '2024-02-08'),
('P03','D3','Cancer','Tamoxifen','2024-04-14', 'Sulfasalazine', '2024-02-04'),
('P04','D4','Hyper Tension','Amlodipine','2024-03-01', 'Lactose', '2024-03-01'),
('P05','D5','Common Cold','Paracetamol','2024-01-05', 'Astama', '2024-01-05'),
('P06','D6','Acne','Depi White Cream','2024-02-20', 'None', '2024-02-20'),
('P07','D7','Kidney Stones','Alpha Blocker','2024-02-15', 'None', '2024-02-15'),
('P08','D1','Back Pain','Tylenol','2024-01-13', 'None', '2024-01-13')


--Query to INSERT data into Completed Appointments Table
INSERT INTO CompletedAppointments(Patient_id, Doctor_id, Appointment_date, Appointment_time, Department_id, Status, Patient_Review)
VALUES ('P03','D3','2024-04-14','13:00:00','DP3','Completed','Satisfied with the Treatment'),
('P07','D7','2024-03-18','20:00:00','DP7','Completed','Excellent Treatment')


--Part 2:
--Q2. Add the constraint to check that the appointment date is not in the past.
ALTER TABLE Appointments
ADD CONSTRAINT Check_Appointment_Date CHECK (CONVERT(DATE, Appointment_date) >= CONVERT(DATE, GETDATE()));


--Q3. List all the patients with older than 40 and have Cancer in diagnosis.
SELECT p.Full_name, p.Date_of_birth, m.Diagnosis
FROM Patients p
JOIN MedicalRecords m ON p.patient_id = m.patient_id
WHERE DATEDIFF(YEAR, p.Date_of_birth, GETDATE()) > 40
AND m.diagnosis LIKE '%Cancer%';

--Q4. 
--a) Search the database of the hospital for matching character strings by name of medicine. 
-----Results should be sorted with most recent medicine prescribed date first.
--Create a Stored Procedure to fullfill the requirment
CREATE PROCEDURE SearchMedicine (@medicine VARCHAR(50))
AS
BEGIN
    SELECT *
    FROM MedicalRecords
    WHERE medicines LIKE '%' + @medicine + '%'
    ORDER BY medicine_prescribed_date DESC;
END;


--Check the result using EXCECUTE for the created Procedure
EXEC SearchMedicine 'Alpha Blocker';

-- b) Return a full list of diagnosis and allergies for a specific patient who has an appointment today (i.e., the system date when the query is run)

CREATE FUNCTION GetPatientDiagnosisAndAllergies(@patient_ID NVARCHAR(10))
RETURNS TABLE
AS
RETURN
(SELECT P.Patient_ID, P.Full_name, MR.Diagnosis, MR.Allergies
 FROM Patients P
    JOIN
        Appointments Ap ON P.Patient_ID = Ap.Patient_Id
    JOIN
        MedicalRecords MR ON P.Patient_ID = MR.Patient_ID
    WHERE
        Ap.Appointment_date = CONVERT(DATE, GETDATE())
        AND P.Patient_ID = @patient_ID
);

-- Query to Check the result for the created Function

Select *
From GetPatientDiagnosisAndAllergies('P08');

-- c)Update the details for an existing doctor
CREATE PROCEDURE UpdateDoctorDetails 
    @doctor_id NVARCHAR(10),
    @new_doctor_name VARCHAR(50),
    @new_specialty VARCHAR(50)
AS
BEGIN
    UPDATE Doctors
    SET Doctor_Name = @new_doctor_name,
        Specialty = @new_specialty
    WHERE doctor_id = @doctor_id;
END;

--When Updating use EXCECUTE for the created Procedure with New Infomation

EXEC UpdateDoctorDetails 'D5', 'Dr. Norris', 'Pediatricion'

-- See the changes made using the following query (Note: Changed to "Dr. Lando Norris")
SELECT * FROM Doctors;

-- d) Delete the appointment who status is already completed.
CREATE PROCEDURE MoveCompletedAppointments
AS
BEGIN
    SET IDENTITY_INSERT CompletedAppointments ON; 

    INSERT INTO CompletedAppointments (Patient_id, Doctor_id, Appointment_date, Appointment_time, Department_id, Status, Patient_Review)
    SELECT Patient_id, Doctor_id, Appointment_date, Appointment_time, Department_id, Status, Patient_Review
    FROM Appointments
    WHERE Status = 'Completed';

    SET IDENTITY_INSERT CompletedAppointments OFF; 

    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;

-- Q5. Create view for All Appointment Details:

CREATE VIEW AllAppointmentsDetails AS
SELECT a.Appointment_ID, a.Appointment_date, a.Appointment_time, d.Doctor_Name,
dept.Department_Name, d.Specialty, a.Patient_Review, a.patient_id
FROM Appointments a
JOIN 
	Doctors d ON a.Doctor_id = d.Doctor_ID
JOIN 
	Departments dept ON d.Department_ID = dept.Department_ID

UNION
SELECT ca.Appointment_ID, ca.Appointment_date, ca.Appointment_time,
d.Doctor_Name, dept.Department_Name, d.Specialty, ca.Patient_Review, ca.patient_id
FROM CompletedAppointments ca
JOIN 
    Doctors d ON ca.doctor_id = d.doctor_id
JOIN 
    Departments dept ON d.department_id = dept.department_id;

-- Query to see the result of the created VIEW
SELECT * FROM AllAppointmentsDetails;


-- Q6.Create a trigger so that the current state of an appointment can be changed to available when it is cancelled.
CREATE TRIGGER ChangeStatusToAvailable
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(status)
    BEGIN
        UPDATE Appointments
        SET status = 'Available'
        WHERE status = 'Cancelled';
    END;
END;

--Check for the existing Value in the table
select * from Appointments
--Update the Value to execute the Created TRIGGER 
UPDATE Appointments
SET status = 'Cancelled'
WHERE Appointment_ID = '4' AND status = 'Pending';

--Check for the changed value
select * from Appointments


--Q7.Write a select query which allows the hospital to identify the number of completed appointments with the specialty of doctors as ‘Gastroenterologists’.
SELECT COUNT(*) AS completed_appointments
FROM CompletedAppointments ca
JOIN Doctors d ON ca.doctor_id = d.doctor_id
WHERE ca.status = 'completed'
AND d.specialty = 'Gastroenterologist';


--Q8. Backup & Recovery Procedures is done using SSMS Interface