
CREATE DATABASE university_database;

       CREATE TABLE PROFESSOR(
           SSN numeric(9) primary key,
           NAME varchar(20),
           STREET_ADDRESS varchar(20),
           CITY varchar(20),
           STATE varchar(20),
           ZIP_CODE varchar(20),
           SEX enum('M','F'),
           AREA_CODE varchar(3),
           PHONE_NUMBER varchar(7),
           TITLE varchar(20),
           SALARY varchar(20),
           COLLEGE_DEGREES varchar(20));

       CREATE TABLE STUDENT(
           CWID numeric(8) primary key,
           First_Name VARCHAR(50),
           Last_Name VARCHAR(50),
           Telephone_Number VARCHAR(10),
           Address VARCHAR(15),
           DNUM varchar(20),
           FOREIGN KEY(DNUM) REFERENCES Department(DNO));

       CREATE TABLE DEPARTMENT(
           DNO numeric(10) primary key,
           DNAME varchar(20),
           DPHONE varchar(10),
           OFFICE_LOCATION varchar(20),
           CHAIR_SSN varchar(9),
           foreign key (CHAIR_SSN) references PROFESSOR(SSN));

       CREATE TABLE COURSE (
           CNO numeric(6) primary key,
           TITLE VARCHAR(20),
           TEXTBOOK VARCHAR(20),
           UNITS INT,
           DNUM INT,
           FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNO));

       CREATE TABLE SECTION (
           SNO numeric(6) primary key,
           CLASSROOM varchar(20),
           NO_OF_SEATS varchar(20),
           MEETING_DAYS varchar(20),
           START_TIME varchar(20),
           END_TIME varchar(20),
           PSSN varchar(20),
           CNUM varchar(20),
           FOREIGN KEY (PSSN) REFERENCES PROFESSOR(SSN),
           FOREIGN KEY (CNUM) REFERENCES COURSE(CNO));

       CREATE TABLE PREREQUISITES (
           CNUM numeric(7),
           PRENUM CHAR(6),
           primary key (CNUM, PRENUM),
           FOREIGN KEY (CNUM) REFERENCES COURSE(CNO),
           FOREIGN KEY (PRENUM) REFERENCES COURSE(CNO));

       CREATE TABLE MINOR(
           CWID numeric(8) NOT NULL,
           DNO INT NOT NULL,
           PRIMARY KEY(CWID, DNO),
           FOREIGN KEY(CWID) REFERENCES STUDENT(CWID),
           FOREIGN KEY(CWID) REFERENCES DEPARTMENT(DNO));


       CREATE TABLE COLLEGE_DEGREES(
           COLLEGE_DEGREES varchar(50),
           SSN varchar(9),
           PRIMARY KEY(COLLEGE_DEGREES),
           FOREIGN KEY(SSN) REFERENCES PROFESSOR(SSN));

       CREATE TABLE ENROLLMENT(
           CWID VARCHAR(8) NOT NULL,
           SECTION_NUMBER VARCHAR(5) NOT NULL,
           GRADE enum('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'),
           PRIMARY KEY(CWID, SECTION_NUMBER),
           FOREIGN KEY(CWID) REFERENCES STUDENT(CWID),
           FOREIGN KEY(SECTION_NUMBER) REFERENCES SECTION(SNO));