CREATE TABLE employee (
    Ssn CHAR(9) PRIMARY KEY,
    Fname VARCHAR(50),
    Minit CHAR(1),
    Lname VARCHAR(50),
    Address VARCHAR(255),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Bdate DATE,
    Dno INT,
    Super_ssn CHAR(9),
    FOREIGN KEY (Dno) REFERENCES department(Dnumber),
    FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
);

CREATE TABLE department (
    Dnumber INT PRIMARY KEY,
    Dname VARCHAR(50),
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE,
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

CREATE TABLE dept_location (
    Dnumber INT,
    Dlocation VARCHAR(50),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
);

CREATE TABLE dependent (
    Essn CHAR(9),
    Dependent_name VARCHAR(50),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);

CREATE TABLE project (
    Pnumber INT PRIMARY KEY,
    Pname VARCHAR(50),
    Plocation VARCHAR(50),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES department(Dnumber)
);

CREATE TABLE works_on (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(5,2),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);
