
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
           Address varchar(15),
           DNUM numeric(10) references DEPARTMENT(DNO));

       CREATE TABLE DEPARTMENT(
           DNO numeric(10) primary key,
           DNAME varchar(20),
           DPHONE varchar(10),
           OFFICE_LOCATION varchar(20),
           CHAIR_SSN varchar(10) references PROFESSOR(SSN));

       CREATE TABLE COURSE (
           CNO numeric(6) primary key,
           TITLE varchar(20),
           TEXTBOOK varchar(20),
           UNITS int,
           DNUM int references DEPARTMENT(DNO));

       CREATE TABLE SECTION (
           SNO numeric(6) not null,
           CLASSROOM varchar(20),
           NO_OF_SEATS varchar(20),
           MEETING_DAYS varchar(20),
           START_TIME varchar(20),
           END_TIME varchar(20),
           PSSN varchar(20) references PROFESSOR(SSN),
           CNUM varchar(20),
           primary key (CNUM, SNO),
           foreign key (CNUM) references COURSE(CNO));

       CREATE TABLE PREREQUISITES (
           CNUM numeric(7),
           PRENUM char(6),
           primary key (CNUM, PRENUM),
           foreign key (CNUM) references COURSE(CNO),
           foreign key (PRENUM) references COURSE(CNO));

       CREATE TABLE MINOR(
           CWID numeric(8) NOT NULL,
           DNO INT NOT NULL,
           primary key (CWID, DNO),
           foreign key(CWID) references STUDENT(CWID),
           foreign key(CWID) references DEPARTMENT(DNO));


       CREATE TABLE COLLEGE_DEGREES(
           COLLEGE_DEGREES varchar(50),
           SSN varchar(9),
           primary key (COLLEGE_DEGREES),
           foreign key(SSN) references PROFESSOR(SSN));

       CREATE TABLE ENROLLMENT(
           CWID varchar(8) NOT NULL,
           CNO varchar(20) NOT NULL,
           SECTION_NUMBER varchar(5) NOT NULL,
           GRADE enum('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'),
           primary key(CWID, CNO,SECTION_NUMBER),
           foreign key(CWID) references STUDENT(CWID),
           foreign key(SECTION_NUMBER) references SECTION(SNO),
           foreign key (CNO) references COURSE(CNO));

INSERT INTO STUDENT(CWID, First_name, Last_name, Telephone_Number, Address, DNUM) VALUES
(10001234, 'Alice', 'Nguyen', '555-123-4567', '123 Maple St, Springfield', 111),
(10005678, 'Brian', 'Choi', '555-987-6543', '456 Oak Ave, Lincoln', 222),
(10009876, 'Clara', 'Martinez', '555-555-1122', '789 Pine Dr, Fairview', 111),
(10004321, 'David', 'Johnson', '555-333-2211', '101 Elm St, Riverdale', 222),
(10007654, 'Elena', 'Lee', '555-999-8888', '202 Birch Rd, Centerville', 111),
(10006543, 'Felix', 'Wong', '555-777-6666', '303 Cedar Ln, Brookfield', 222),
(10008765, 'Grace', 'Patel', '555-444-3333', '404 Spruce Ct, Franklin', 111),
(10003456, 'Hannah', 'Kim', '555-222-1111', '505 Willow Blvd, Greenville', 222);

INSERT INTO PROFESSOR(SSN, NAME, STREET_ADDRESS, CITY, STATE, ZIP_CODE, SEX, AREA_CODE, PHONE_NUMBER, TITLE, SALARY, COLLEGE_DEGREES) VALUES
('123456789', 'Linda Chen', '12 University Way', 'Boston', 'MA', '02115', 'F', '617', '5551234', 'Associate Professor', 85000, 'PhD, M.S.'),
('987654321', 'Michael Thompson', '45 Elm Street', 'Chicago', 'IL', '60616', 'M', '312', '5559876', 'Professor', 95000, 'PhD, M.Ed.'),
('456789123', 'Sarah Patel', '89 Oak Ave', 'Seattle', 'WA', '98101', 'F', '206', '5556789', 'Assistant Professor', 78000, 'PhD, B.Sc.');

INSERT INTO DEPARTMENT(DNO, DNAME, DPHONE, OFFICE_LOCATION, CHAIR_SSN) VALUES
(111, 'Computer Science', '555-123-4567', 'Building A, Room 101', '123456789'),
(222, 'Mathematics', '555-987-6543', 'Building B, Room 202', '987654321');

INSERT INTO COURSE(CNO, TITLE, TEXTBOOK, UNITS, DNUM) VALUES
(101, 'Introduction to Computer Science', 'Introduction to Python Programming', 3, 111),
(102, 'Data Structures', 'Data Structures and Algorithms in Python', 4, 111),
(201, 'Calculus I', 'Calculus: Early Transcendentals', 4, 222),
(202, 'Linear Algebra', 'Linear Algebra and Its Applications', 3, 222);

INSERT INTO SECTION(SNO, CLASSROOM, NO_OF_SEATS, MEETING_DAYS, START_TIME, END_TIME, PSSN, CNUM) VALUES
(1, 'Room 101', 30, 'MWF', '09:00', '10:00', '123456789', 101),
(2, 'Room 102', 35, 'TTh', '10:30', '12:00', '987654321', 102),
(3, 'Room 201', 40, 'MWF', '11:00', '12:30', '123456789', 201),
(4, 'Room 202', 40, 'TTh', '13:00', '14:30', '987654321', 202),
(5, 'Room 103', 25, 'MWF', '14:00', '15:00', '123456789', 101),
(6, 'Room 104', 30, 'TTh', '15:30', '17:00', '987654321', 102);

INSERT INTO ENROLLMENT(CWID, CNO, SECTION_NUMBER, GRADE) VALUES
(10001234, 101, 1, 'A+'),
(10005678, 102, 2, 'B'),
(10009876, 201, 3, 'A-'),
(10004321, 202, 4, 'B+'),
(10007654, 101, 5, 'A'),
(10006543, 102, 6, 'C+'),
(10008765, 201, 3, 'B-'),
(10003456, 202, 4, 'C'),
(10001234, 102, 2, 'A'),
(10005678, 101, 1, 'A-'),
(10009876, 202, 4, 'B'),
(10004321, 201, 3, 'C+'),
(10007654, 102, 6, 'B+'),
(10006543, 101, 5, 'C-'),
(10008765, 202, 4, 'A'),
(10003456, 101, 1, 'B+'),
(10001234, 201, 3, 'B'),
(10005678, 202, 4, 'C+'),
(10009876, 101, 5, 'A'),
(10004321, 102, 6, 'F');