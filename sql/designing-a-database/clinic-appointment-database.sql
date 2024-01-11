CREATE TABLE clinic (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    phone VARCHAR(12) NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    honorific VARCHAR(4),
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone VARCHAR(30) UNIQUE
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(30) UNIQUE,
    phone VARCHAR(12) NOT NULL,
    primary_clinic INTEGER REFERENCES clinic(id)
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    time DATE UNIQUE NOT NULL,
    patient_id INTEGER REFERENCES patients(id) NOT NULL,
    clinic_id INTEGER REFERENCES clinic(id) NOT NULL,
    doctor_id INTEGER REFERENCES doctors(id) NOT NULL
);

CREATE TABLE clinics_doctors (
    clinic_id INTEGER REFERENCES clinic(id),
    doctor_id INTEGER REFERENCES doctors(id),
    PRIMARY KEY (clinic_id, doctor_id)
);


INSERT INTO clinic 
VALUES (
    DEFAULT,
    'First Clinic',
    '+61400111222',
    'firstclinic@email.test'
);

INSERT INTO clinic
VALUES (
    DEFAULT,
    'Second Clinic',
    '+61400222333',
    'secondclinic@email.test'
);

INSERT INTO doctors
VALUES (
    DEFAULT,
    'Dr.',
    'Rex',
    'Turtle',
    '+61400222333'
);

INSERT INTO doctors
VALUES (
    DEFAULT,
    'Mr',
    'Joe',
    'Peacock',
    '+61400444333'
);

INSERT INTO doctors
VALUES (
    DEFAULT,
    'Miss',
    'Jo',
    'Emu',
    '+61400999000'
);

INSERT INTO patients
VALUES (
    DEFAULT,
    'Happy',
    'Doe',
    'test@test.email',
    '+61444444444',
    1
);

INSERT INTO patients
VALUES (
    DEFAULT,
    'Lilly',
    'Doe',
    'ilikecats@email.test',
    '+61555555555',
    2
);

INSERT INTO patients
VALUES (
    DEFAULT,
    'Jimmy',
    'Smith',
    'testemail@test.test',
    '+61666666666',
    2
);

INSERT INTO patients
VALUES (
    DEFAULT,
    'Jane',
    'Citizen',
    'test1@test.test',
    '+61999999999',
    1
);

INSERT INTO appointments
VALUES (
    DEFAULT,
    'Mar 3, 2024 11:03 AM',
    1,
    2,
    2
);

INSERT INTO appointments
VALUES (
    DEFAULT,
    'Dec 29, 2024 9:34 AM',
    1,
    1,
    2
);

INSERT INTO appointments
VALUES (
    DEFAULT,
    'Jan 28, 2024 11:11 AM',
    2,
    2,
    2
);

INSERT INTO appointments
VALUES (
    DEFAULT,
    'Feb 27, 2024 7:51 AM',
    2,
    1,
    1
);

INSERT INTO appointments
VALUES (
    DEFAULT,
    'Mar 27, 2024 2:22 PM',
    3,
    1,
    3
);

INSERT INTO appointments
VALUES (
    DEFAULT,
    'Oct 17, 2024 8:23 AM',
    4,
    1,
    1
);

INSERT INTO clinics_doctors
VALUES (
    1,
    2
);

INSERT INTO clinics_doctors
VALUES (
    2,
    2
);

INSERT INTO clinics_doctors
VALUES (
    1,
    1
);

INSERT INTO clinics_doctors
VALUES (
    1,
    3
);