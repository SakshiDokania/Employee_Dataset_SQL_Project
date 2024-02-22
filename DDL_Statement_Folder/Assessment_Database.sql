-- Check if DB and Tables already exist, if so, remove
DROP DATABASE IF EXISTS workshopDB;
CREATE DATABASE IF NOT EXISTS workshopDB;
USE workshopDB;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS SalaryClass, Departments, Employees, DepartmentEmployee;

-- Create Salary Class Table
CREATE TABLE SalaryClass(
	SalaryID 	CHAR(3)    	NOT NULL,
    Salary      INT         NOT NULL,
    PRIMARY KEY (SalaryID)
);

-- Create Departments Table
CREATE TABLE Departments(
    DepartmentID	CHAR(3)         NOT NULL,
    DepartmentName	VARCHAR(50)     NOT NULL,
    Location		VARCHAR(50)		NOT NULL,
    PRIMARY KEY (DepartmentID)
);

-- Create Employees Table
CREATE TABLE Employees(
    EmployeeID		   CHAR(7)           NOT NULL,
	DepartmentID	   CHAR(3)        	 NOT NULL,
	SalaryID	       CHAR(3)			     NOT NULL,
    Title			   VARCHAR(50)		 NOT NULL,
	EmployeeFirstName  VARCHAR(30)       NOT NULL,
    EmployeeLastName   VARCHAR(30)       NOT NULL,
    Gender        	   ENUM('M','F','O') NOT NULL,    
    yearHired   	   INT    		     NOT NULL,
    birthYear  		   INT   		     NOT NULL,
    PerformanceBonus   ENUM('T','F'), 
    FOREIGN KEY (SalaryID) REFERENCES SalaryClass (SalaryID),
	FOREIGN KEY (DepartmentID) REFERENCES DEpartments (DepartmentID),
    PRIMARY KEY (EmployeeID, SalaryID, DepartmentID)
);

-- Create DepartmentEmployee Table
CREATE TABLE DepartmentEmployee(
    EmployeeID      CHAR(7)         NOT NULL,
    DepartmentID    CHAR(3)         NOT NULL,
    FOREIGN KEY (EmployeeID)  REFERENCES Employees   (EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID),
    PRIMARY KEY (EmployeeID, DepartmentID)
);
