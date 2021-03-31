Create database TableRelations

Create table Persons (
PersonId int Identity Primary key ,
FirstName varchar(20) NOT NULL,
Salary decimal(15,2) NULL,
PassportID INT  Not NULL
)

Create Table Passports (
PassportId int Primary key ,
PassportNumber CHAR(8) NOT NULL
)

Alter table Persons
Add constraint FK_Persons_Passports
Foreign key (PassportID) REFERENCES Passports(PassportId)

Alter Table Persons
ADD UNIQUE (PassportID) -- уникалност на номерата и номера
Alter Table Passports
ADD UNIQUE (PassportNumber)

Insert INTO Persons (FirstName, Salary, PassportID) Values 
('Roberto', 43300.00, 102) ,
('Tom',	56100.00, 103),
('Yana', 60200.00, 101)

Insert INTO Passports (PassportId,PassportNumber) Values 
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2')


-- ONE TO ONE RELATIONSHIPS



Create Table Models (
ModelID int Primary key Identity(101,1), --zapochva ot 101 i + 1
[Name] varchar(15) Not NULL,
ManifacturerID int Foreign key References Manifacturers(ManifacturerID))


Create table Manifacturers (
ManifacturerID int Primary key Identity, 
[Name] varchar(15) Not NULL,
EsatblishedOn DATE NOT NULL)

INSERT INTO Manifacturers ([Name], EsatblishedOn) VALUES 
('BMW',	'07/03/1916'),
('Tesla', '01/01/2003'),
('Lada',	'01/05/1966')

INSERT INTO  Models([Name], ManifacturerID) VALUES 
('X1',	1),
('i6',	1),
('Model S',	2),
('Model X',	2),
('Model 3',	2),
('Nova', 3)

-- ONE TO MANY RELATIONS



Create table Students (
StidentID int Primary key Identity,
[Name] varchar(15) NOT NULL)

Create Table Exams (
ExamID int Primary key Identity(101,1),
[Name] varchar(25) NOT NULL)

Create table StudentsExams(
SudentID int NOT NULL,  
ExamID int NOT NULL)

ALTER TABLE StudentsExams
Add Constraint PK_StudentsExams PRIMARY KEY (SudentID, ExamID) -- kompoziting key


ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentExams_Students Foreign key (SudentID) REFERENCES Students(StidentID),
 CONSTRAINT FK_StudentExams_EXAMS Foreign key (ExamID) REFERENCES Exams(ExamID)

 -- MANY TO MANY RELATIONS



 CREATE Table Teachers
 (TeacherID int Primary key Identity(101,1),
 [Name] varchar(15),
 ManagerID int Foreign key REFERENCES Teachers(TeacherID))

 -- self refferencing  vseki ima shef v organizaciqta CEO e NULL
 INSERT INTO Teachers VALUES
 ('John',	NULL),
('Maya',	106),
('Silvia',	106),
('Ted',	105),
('Mark',	101),
('Greta',	101)





