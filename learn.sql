CREATE DATABASE mytest
GO
USE mytest

CREATE TABLE testable
(
id int,
fname varchar(50),
lname varchar(50)
)

USE mytest
SELECT id,fname,lname FROM testable

INSERT INTO testable(id,fname,lname)
VALUES(
1,
'Moataz',
'essam'
)

USE [BikeStores ]
SELECT * FROM [sales].[customers]

SELECT DISTINCT first_name FROM [sales].[customers]

--like for text
SELECT first_name,state FROM [sales].[customers]
WHERE state LIKE 'NY'

-- = for number
SELECT * FROM sales.customers
WHERE zip_code = '14127'

SELECT * FROM sales.customers
WHERE zip_code <= '14127'

SELECT * FROM sales.customers
WHERE zip_code IN (14127,11553)

SELECT * FROM sales.customers
WHERE email LIKE '%yahoo%'

SELECT last_name FROM  sales.customers
SELECT last_name +'ahmed' AS famname FROM sales.customers

SELECT last_name FROM  sales.customers
SELECT last_name +'ahmed' AS famname INTO sales.customers2 FROM sales.customers
SELECT * FROM sales.customers2

---temp table
SELECT last_name +'ahmed' AS famname INTO #data FROM sales.customers
SELECT * FROM sales.customers2
SELECT * FROM #data

DELETE FROM sales.customers2
WHERE famname LIKE '%ahmed'
SELECT * FROM sales.customers2

SELECT famname FROM sales.customers2 
INSERT INTO sales.customers2(famname)
VALUES (
'ESSAM'
)
SELECT * FROM sales.customers2

UPDATE sales.customers2
SET famname = 'new moataz'
WHERE famname LIKE 'moataz'
SELECT * FROM sales.customers2


use [BikeStores ]
CREATE TABLE myemployee (empid INT , fname varchar(20),lname varchar(20))

INSERT INTO myemployee VALUES(1,'moataz','essam')
INSERT INTO myemployee VALUES(2,'motaz','essam')
INSERT INTO myemployee VALUES(3,'taz','essam')
SELECT * FROM myemployee

CREATE TABLE mysalary (empid INT , salary FLOAT)
INSERT INTO mysalary VALUES(1,2000)
INSERT INTO mysalary VALUES(2,1000)
INSERT INTO mysalary VALUES(3,NULL)
SELECT * FROM mysalary

SELECT a.empid,a.fname,a.lname,b.salary 
FROM myemployee a LEFT JOIN mysalary b ON a.empid = b.empid

SELECT SUM(salary) AS 'SUM SALARY' FROM mysalary
SELECT AVG(salary) FROM mysalary
SELECT MIN(salary) FROM mysalary
SELECT MAX(salary) FROM mysalary
SELECT LEFT(salary,1) FROM mysalary

SELECT * FROM myemployee
SELECT fname,lname ,CONCAT(UPPER(LEFT(fname,1)),LOWER(SUBSTRING(fname,2,LEN(fname)))) AS 'NEW COL' FROM myemployee


---example etl

CREATE TABLE products(
prodid INT,
prodname varchar(20),
prodprice INT
)
INSERT INTO products VALUES
(1,'CAR',10),
(2,'DOG',20),
(3,'HUMAN',20),
(4,'CAR',100)

CREATE TABLE showallproducts(
prodid INT,
prodname varchar(20),
totalprodprice INT
)
TRUNCATE TABLE showallproducts

INSERT INTO showallproducts(prodid,prodname,totalprodprice)

SELECT prodid,MAX(prodname),SUM(prodprice) AS 'allprodprice' FROM products

GROUP BY prodid;

SELECT * FROM showallproducts