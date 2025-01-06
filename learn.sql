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

--Learn advanced SQL--

SELECT TOP (1000) [id]
      ,[fname]
      ,[lname]
  FROM [mytest].[dbo].[testable]

CREATE VIEW ViewTest
AS
SELECT fname FROM [mytest].[dbo].[testable]
WHERE fname LIKE 'moataz'

SELECT * FROM ViewTest

SELECT TOP (1000) [staff_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[phone]
      ,[active]
      ,[store_id]
      ,[manager_id]
  FROM [BikeStores ].[sales].[staffs]


DROP view COUNTSOTREID

CREATE VIEW COUNTSOTREID
AS 
SELECT  [brand_id],[brand_name],[category_id],[category_name] 
FROM [production].[brands] a inner join [production].[categories] b
ON a.brand_id = b.category_id
WHERE brand_id = category_id

SELECT brand_name FROM COUNTSOTREID
UPDATE COUNTSOTREID
SET brand_name ='Electra'
WHERE brand_name LIKE 'Electra New'
SELECT * FROM COUNTSOTREID


CREATE TRIGGER triggerdemo
ON [production].[products].[model_year]
AFTER INSERT
AS
BEGIN
PRINT 'NOT ALLOWED'
ROLLBACK TRANSACTION
END
GO

CREATE PROCEDURE mytestpro
@parastocks INT
AS
SET NOCOUNT ON
SELECT * FROM [production].[stocks]
WHERE quantity = @parastocks

EXEC mytestpro @parastocks = '0'

DROP PROC mytestpro


CREATE FUNCTION SQ(@num INT)
RETURNS INT
AS
BEGIN
	RETURN @num * 5
END

SELECT dbo.sq(5) AS square;
