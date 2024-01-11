CREATE TABLE clinic (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE doctors (
    ID SERIAL PRIMARY KEY,
    honorific VARCHAR(4),
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone VARCHAR(30) UNIQUE
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL,
    phone VARCHAR(12) NOT NULL,
    primary_clinic INTEGER REFERENCES clinic(id)
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    time DATE UNIQUE NOT NULL,
    clinic_id INTEGER REFERENCES clinic(id) NOT NULL,
    patient_id INTEGER REFERENCES patient(id) NOT NULL,
    doctor_id INTEGER REFERENCES doctors(id) NOT NULL
);

CREATE TABLE clinics_doctors (
    clinic_id INTEGER REFERENCES clinic(id),
    doctor_id INTEGER REFERENCES doctors(id),
    PRIMARY KEY (clinic_id, doctor_id)
);