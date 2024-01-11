-- Join tables together to see appointment data for a specified clinic
SELECT appointments.time AS "Appointment time",
    clinic.name AS "Clinic",
    patients.first_name AS "Patient First Name",
    patients.last_name AS "Patient Last Name",
    doctors.honorific,
    doctors.last_name AS "doctor"
FROM appointments
JOIN clinic
	ON appointments.clinic_id = clinic.id
JOIN doctors
	ON appointments.doctor_id = doctors.id
JOIN patients
	ON appointments.patient_id = patients.id
WHERE clinic.id = 1;

-- View number of appointments in each clinic
SELECT clinic.name,
	COUNT(appointments.clinic_id)
FROM clinic
JOIN appointments
	ON appointments.clinic_id = clinic.id
GROUP BY clinic.name;

-- View number of apointments for each doctor in each clinic 
SELECT clinic.name AS "clinic",
    doctors.first_name AS "doctor",
    COUNT(doctors.first_name) AS "num of appoitments"
FROM clinic
JOIN appointments
	ON appointments.clinic_id = clinic.id
JOIN doctors 
	ON appointments.doctor_id = doctors.id
GROUP BY clinic.name, doctors.first_name;

-- Time and location and patient name for all appointments with a certain doctor (doctors schedule view)
SELECT time,
	clinic.name AS "clinic",
    patients.first_name AS "Patient First Name",
    patients.last_name AS "Patient Last Name",
    patients.phone AS "Patient Ph"
FROM appointments
JOIN doctors
	ON appointments.doctor_id = doctors.id
JOIN patients
	ON appointments.patient_id = patients.id
JOIN clinic
	ON appointments.clinic_id = clinic.id
WHERE doctors.id = 1;

-- See which doctors work at which clinics
SELECT clinic.name AS "clinic_name",
	doctors.honorific,
    doctors.first_name,
    doctors.last_name,
    doctors.phone
FROM doctors
JOIN clinics_doctors
	ON clinics_doctors.doctor_id = doctors.id
JOIN clinic 
	ON clinic.id = clinics_doctors.clinic_id
ORDER BY clinic.name;