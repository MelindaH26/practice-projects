# Design and Build a Database from Scratch
This project was completed as part of the Codecademy Back-End Engineering course.

## Purpose
The goal of this project was to design a database of your choosing, plan out the tables and their relations, create the database in PostgreSQL and insert test data.

For this project I decided to design a database for an appointment booking system for a business that has more than one location. E.g. A medical clinic that has more than one location with multiple doctors who can work at multiple locations, and patients can that can book an appointment a clinic of their choosing.

## Outcome
Throughout this project I learnt a lot about database design, types of table relationships as well as Primary and Foreign keys. 

Below you can see database schema diagram: 
![booking database schema diagram](https://github.com/MelindaH26/practice-projects/blob/main/sql/database-designing-from-scratch/clinic-database.PNG)
This database features:
- One to many relationship between Clinics and Patients
- One to many relationship between Clinics and Appointments
- One to many relationship between Patients and Appointments
- Many to many relationship between Clinics and Doctors implemented using a cross reference table clinics_doctors
- One to many relationship between Doctors and Appointments
- The implementation of Primary and Foreign Keys where necesary

The sql files also feature some test data that can be inserted into the database.

## Improvements
- Rename the 'time' column in the Appointments table to 'date'
- Add a 'time' column to the Appointments table for time of day
