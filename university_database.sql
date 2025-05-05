
CREATE DATABASE UNIVERSITY_DATABASE;

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
           First_Name varchar(50),
           Last_Name varchar(50),
           Telephone_Number varchar(10),
           Address varchar(40),
           DNUM numeric(10) references DEPARTMENT(DNO));

       CREATE TABLE DEPARTMENT(
           DNO numeric(10) primary key,
           DNAME varchar(20),
           DPHONE varchar(10),
           OFFICE_LOCATION varchar(50),
           CHAIR_SSN varchar(10) references PROFESSOR(SSN));

       CREATE TABLE COURSE (
           CNO numeric(6) primary key,
           TITLE varchar(50),
           TEXTBOOK varchar(60),
           UNITS int,
           DNUM int references DEPARTMENT(DNO));

       CREATE TABLE SECTION (
           SNO numeric(6) not null,
           CNUM numeric(6),
           CLASSROOM varchar(20),
           NO_OF_SEATS varchar(20),
           MEETING_DAYS varchar(20),
           START_TIME varchar(20),
           END_TIME varchar(20),
           PSSN varchar(20) references PROFESSOR(SSN),
           primary key (CNUM, SNO),
           foreign key (CNUM) references COURSE(CNO));

       CREATE TABLE PREREQUISITES (
           CNUM numeric(6),
           PRENUM numeric(6),
           primary key (CNUM, PRENUM),
           foreign key (CNUM) references COURSE(CNO),
           foreign key (PRENUM) references COURSE(CNO));

       CREATE TABLE MINOR(
           CWID numeric(8) NOT NULL,
           DNUM numeric(10) NOT NULL,
           primary key (CWID, DNUM),
           foreign key (CWID) references STUDENT(CWID),
           foreign key (DNUM) references DEPARTMENT(DNO));


       CREATE TABLE COLLEGE_DEGREES(
           COLLEGE_DEGREES varchar(50),
           PSSN numeric(9),
           primary key (PSSN, COLLEGE_DEGREES),
           foreign key(PSSN) references PROFESSOR(SSN));

       CREATE TABLE ENROLLMENT(
           CWID numeric(8) not null,
           SECTION_NUMBER numeric(6) not null,
           CNO numeric(6) not null,
           GRADE enum('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'),
           primary key(CWID, CNO, SECTION_NUMBER),
           foreign key(CWID) references STUDENT(CWID),
           foreign key (CNO, SECTION_NUMBER) references SECTION(CNUM, SNO));


INSERT INTO STUDENT(CWID, First_name, Last_name, Telephone_Number, Address, DNUM) VALUES
(10001234, 'Alice', 'Nguyen', '5551234567', '123 Maple St, Springfield', 111),
(10005678, 'Brian', 'Choi', '5559876543', '456 Oak Ave, Lincoln', 222),
(10009876, 'Clara', 'Martinez', '5555551122', '789 Pine Dr, Fairview', 111),
(10004321, 'David', 'Johnson', '5553332211', '101 Elm St, Riverdale', 222),
(10007654, 'Elena', 'Lee', '5559998888', '202 Birch Rd, Centerville', 111),
(10006543, 'Felix', 'Wong', '5557776666', '303 Cedar Ln, Brookfield', 222),
(10008765, 'Grace', 'Patel', '5554443333', '404 Spruce Ct, Franklin', 111),
(10003456, 'Hannah', 'Kim', '5552221111', '505 Willow Blvd, Greenville', 222);

INSERT INTO PROFESSOR(SSN, NAME, STREET_ADDRESS, CITY, STATE, ZIP_CODE, SEX, AREA_CODE, PHONE_NUMBER, TITLE, SALARY, COLLEGE_DEGREES) VALUES
(123456789, 'Linda Chen', '12 University Way', 'Boston', 'MA', '02115', 'F', '617', '5551234', 'Associate Professor', '85000', 'PhD, M.S.'),
(987654321, 'Michael Thompson', '45 Elm Street', 'Chicago', 'IL', '60616', 'M', '312', '5559876', 'Professor', '95000', 'PhD, M.Ed.'),
(456789123, 'Sarah Patel', '89 Oak Ave', 'Seattle', 'WA', '98101', 'F', '206', '5556789', 'Assistant Professor', '78000', 'PhD, B.Sc.');

INSERT INTO DEPARTMENT(DNO, DNAME, DPHONE, OFFICE_LOCATION, CHAIR_SSN) VALUES
(111, 'Computer Science', '5551234567', 'Building A, Room 101', '123456789'),
(222, 'Mathematics', '5559876543', 'Building B, Room 202', '987654321');

INSERT INTO COURSE(CNO, TITLE, TEXTBOOK, UNITS, DNUM) VALUES
(101, 'Introduction to Computer Science', 'Introduction to Python Programming', 3, 111),
(102, 'Data Structures', 'Data Structures and Algorithms in Python', 4, 111),
(201, 'Calculus I', 'Calculus: Early Transcendentals', 4, 222),
(202, 'Linear Algebra', 'Linear Algebra and Its Applications', 3, 222);

INSERT INTO SECTION(SNO, CNUM, CLASSROOM, NO_OF_SEATS, MEETING_DAYS, START_TIME, END_TIME, PSSN) VALUES
(1, 101, 'Room 101', '30', 'MWF', '09:00', '10:00', '123456789'),
(2, 102, 'Room 102', '35', 'TTh', '10:30', '12:00', '987654321'),
(3, 201, 'Room 201', '40', 'MWF', '11:00', '12:30', '123456789'),
(4, 202, 'Room 202', '40', 'TTh', '13:00', '14:30', '987654321'),
(5, 101, 'Room 103', '25', 'MWF', '14:00', '15:00', '123456789'),
(6, 102, 'Room 104', '30', 'TTh', '15:30', '17:00', '987654321');

INSERT INTO ENROLLMENT(CWID, SECTION_NUMBER, CNO, GRADE) VALUES
(10001234, 1, 101, 'A+'),
(10005678, 2, 102, 'B'),
(10009876, 3, 201, 'A-'),
(10004321, 4, 202, 'B+'),
(10007654, 5, 101, 'A'),
(10006543, 6, 102, 'C+'),
(10008765, 3, 201, 'B-'),
(10003456, 4, 202, 'C'),
(10001234, 2, 102, 'A'),
(10005678, 1, 101, 'A-'),
(10009876, 4, 202, 'B'),
(10004321, 3, 201, 'C+'),
(10007654, 6, 102, 'B+'),
(10006543, 5, 101, 'C-'),
(10008765, 4, 202, 'A'),
(10003456, 1, 101, 'B+'),
(10001234, 3, 201, 'B'),
(10005678, 4, 202, 'C+'),
(10009876, 5, 101, 'A'),
(10004321, 6, 102, 'F');