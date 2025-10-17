--Assignment-1

CREATE TABLE Dept (
Deptno NUMBER(25)PRIMARY KEY,
Dname VARCHAR2(25),
Loc VARCHAR2(25));

CREATE TABLE Emps(
Empno NUMBER(25) PRIMARY KEY,
Ename VARCHAR2(25) NOT NULL,
Jobt VARCHAR2(25)NOT NULL,
Salary NUMBER(25),
Deptno NUMBER(25),
CONSTRAINT fk_dept FOREIGN KEY(Deptno) REFERENCES Dept(Deptno) ON DELETE CASCADE
);

INSERT INTO Dept(Deptno,Dname,Loc) VALUES (1,'HR','Blr');
INSERT INTO Dept(Deptno,Dname,Loc) VALUES (2,'Ops','Kol');
INSERT INTO Dept(Deptno,Dname,Loc) VALUES (3,'Tech','Mum');
INSERT INTO Dept(Deptno,Dname,Loc) VALUES (4,'HR','Blr');
INSERT INTO Dept(Deptno,Dname,Loc) VALUES (5,'Tech','Chen');
INSERT INTO Dept(Deptno,Dname,Loc) VALUES (6,'Sales','Chen');
INSERT INTO Dept(Deptno,Dname,Loc) VALUES (7,'Accounting','Chen');

Select * from Dept;

INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (11,'Arun','Manager',15000,1);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (12,'Tarun','Analyst',25000,1);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (13,'Aryan','Tester',35000,2);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (14,'Karan','Engineer',45000,3);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (15,'Keshav','Intern',15000,4);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (16,'Bharath','Manager',25000,1);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ) VALUES (18,'Khan','Manager',55000);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (17,'Bruno','Sales',25000,1);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (19,'Ramdas','Associate',25000,2);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (20,'Charan','Associate',25000,6);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (21,'Jeevan','Associate',25000,7);
INSERT INTO Emps(Empno,Ename,Jobt,Salary ,Deptno) VALUES (22,'Satvik','Associate',25000,7);
Select * from Emps;

-- 1. Display  Employee names along with their department names 
SELECT E.Ename,D.Dname FROM Dept D ,Emps E WHERE D.Deptno=E.Deptno;

SELECT Ename,Dname FROM Emps E INNER JOIN Dept D ON D.Deptno=E.Deptno;

-- 2.List all employees with their job titles and the location of their department
SELECT E.Ename,E.Jobt ,D.Loc FROM Emps E LEFT JOIN Dept D ON D.Deptno=E.Deptno;

-- 3.Display employees who work in sales department
SELECT E.Ename,E.Empno from Dept D,Emps E where D.Deptno=E.Deptno AND D.Dname='Sales';


--4.List all employees along with their department name and location , including departments that have no employees
SELECT E.Ename,D.Deptno,D.Loc FROM Emps E RIGHT JOIN Dept D ON D.Deptno = E.Deptno ;

--5.Display all departments and employees , even if some employees are not assigned to any department
SELECT E.Ename,D.Dname FROM Emps E LEFT JOIN Dept D ON D.Deptno=E.Deptno;

--6.Show each department name and total salary paid to its employees 
SELECT D.Dname,SUM(E.Salary) AS Total_Salary FROM Dept D LEFT JOIN Emps E ON D.Deptno=E.Deptno GROUP BY D.Dname;

--7.Find Departments that have more than 3 employees. Display dname and no. of employees
SELECT D.Dname,COUNT(Empno) AS No_of_employees FROM Dept D LEFT JOIN Emps E ON D.Deptno=E.Deptno GROUP BY D.Dname HAVING COUNT(*)>3;

--8.Display employees who work in the same location as the ACCOUNTING Department.
SELECT E.Ename, D.Loc FROM Dept D INNER JOIN Emps E ON D.Deptno=E.Deptno WHERE D.Loc=(SELECT Loc FROM Dept  WHERE Dname = 'Accounting') ;

--9.For each department , display the employee who has highest salary
SELECT E1.Ename,D1.Dname,E1.Salary FROM Dept D1 INNER JOIN Emps E1 ON E1.Deptno=D1.Deptno WHERE E1.Salary IN(SELECT MAX(E.Salary) AS Highest_Salary FROM Dept D LEFT JOIN Emps E ON D.Deptno=E.Deptno GROUP BY D.Dname);

--10.List employess whose salary is greater than the average salary of their department 
SELECT E.Ename,D.Deptno,E.Salary FROM Emps E RIGHT JOIN Dept D ON E.Deptno=D.Deptno WHERE E.Salary >
(SELECT AVG(E2.Salary) FROM Emps E2  WHERE D.Deptno=E2.Deptno);
