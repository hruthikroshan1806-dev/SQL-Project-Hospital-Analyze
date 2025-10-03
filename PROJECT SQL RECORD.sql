CREATE TABLE sql_project (						
hospital VARCHAR (100) ,
location VARCHAR (100),
department 	VARCHAR (100),
doctors_count 	NUMERIC (10,2),
patients_count 	NUMERIC (10,2),
admission_date 	DATE ,
discharge_date	DATE ,
medical_expenses 	NUMERIC(10,2)
);

SELECT * FROM sql_project;
copy 
sql_project( hospital, location, department, doctors_count, patients_count, admission_date, 
discharge_date, medical_expenses)
FROM '‪C:\Users\rajin\Downloads\Hospital_Data.csv'
DELIMITER ','
CSV HEADER;


ALTER TABLE sql_project
ALTER COLUMN patients_count TYPE INTEGER; 

 ALTER TABLE sql_project
ALTER COLUMN doctors_count TYPE INTEGER; 

SELECT * FROM sql_project;
--1. Total Number of Patients 
--o Write an SQL query to find the total number of patients across all hospitals. 

SELECT SUM (patients_count) AS Total_patients 
FROM sql_project;

--2. Average Number of Doctors per Hospital 
--o Retrieve the average count of doctors available in each hospital. 
SELECT hospital, AVG (doctors_count) AS avg_doctors 
FROM sql_project
GROUP BY hospital ;

--3. Top 3 Departments with the Highest Number of Patients 
--o Find the top 3 hospital departments that have the highest number of patients. 

SELECT  hospital, department, SUM(patients_count) AS highest_number_of_patient
FROM sql_project 
GROUP BY hospital, department
ORDER BY  highest_number_of_patient DESC LIMIT 3;
 
--4. Hospital with the Maximum Medical Expenses 
--o Identify the hospital that recorded the highest medical expenses. 

SELECT hospital, SUM (medical_expenses) AS Highest_medical_expenses
FROM sql_project
GROUP BY hospital
ORDER BY Highest_medical_expenses DESC;

--5. Daily Average Medical Expenses 
--o Calculate the average medical expenses per day for each hospital. 

SELECT * FROM sql_project;

SELECT hospital, 
AVG (medical_expenses  / NULLIF ( discharge_date - admission_date,0)) 
AS daily_avg_expenses
FROM 
sql_project
GROUP BY 
hospital
ORDER BY
daily_avg_expenses DESC ;


--6. Longest Hospital Stay 
--o Find the patient with the longest stay by calculating the difference between 
--Discharge Date and Admission Date.

 SELECT patients_count,
		 hospital,
		 department,
		 (discharge_date - admission_date ) AS lenth_of_stay 
		 FROM
		 sql_project
		 ORDER BY lenth_of_stay  DESC LIMIT 1 ;

--7. Total Patients Treated Per City 
--o Count the total number of patients treated in each city.
SELECT location,
SUM (patients_count) AS total_patients_treated 
FROM sql_project
GROUP BY location
ORDER BY  total_patients_treated DESC ;

--8. Average Length of Stay Per Department 
--o Calculate the average number of days patients spend in each department.

SELECT
 	department,
		 AVG(discharge_date - admission_date ) AS lenth_of_stay_per_dept
		 FROM
		 sql_project
		 GROUP BY 
		 department 
		 ORDER BY 
		 lenth_of_stay_per_dept DESC ;

--9. Identify the Department with the Lowest Number of Patients 
--o Find the department with the least number of patients. 

SELECT department, SUM(patients_count) AS total_patients
FROM sql_project
GROUP BY department
ORDER BY total_patients ASC 
LIMIT 1 ;

--10. Monthly Medical Expenses Report 
•-- Group the data by month and calculate the total medical expenses for each month
SELECT
    TO_CHAR(admission_date, 'YYYY-MON') AS ExpenseMonth,
	SUM(medical_expenses) AS TotalMedicalExpenses
FROM
    sql_project  
GROUP BY
  ExpenseMonth
ORDER BY
 ExpenseMonth;


