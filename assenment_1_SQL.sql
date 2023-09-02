-- CREATE TABLE DEPARTMENT
--       (DEPTNO    CHAR(3)           NOT NULL,
--        DEPTNAME  VARCHAR(36)       NOT NULL,
--        MGRNO     CHAR(6)                   ,
--        ADMRDEPT  CHAR(3)           NOT NULL, 
--        LOCATION  CHAR(16),
--        PRIMARY KEY (DEPTNO))

-- Table 1: SalesPeople
-- Snum is Primary key
-- Sname is Unique constraint
-- Snum Sname City Comm
-- 1001 Peel. London .12
-- 1002  Serres Sanjose .13
-- 1004 Motika London .11
-- 1007 Rifkin Barcelona .15
-- 1003 Axelrod Newyork .10

-- CREATE table SalesPeople
-- ( Snum  char(5) NOT NULL,
--  Sname VARCHAR(36)  NOT NULL,
--  PRIMARY KEY (Snum));

-- Table 2: Customers
-- Cnum is Primary Key
-- City has not null constraint .
-- Snum is foreign key constraint refers Snum column of SalesPeople table.
-- Cnum Cname City Snum
-- 2001  Hoffman London 1001
-- 2002  Giovanni Rome 1003
-- 2003  Liu Sanjose 1002
-- 2004  Grass Berlin 1002
-- 2006 Clemens London 1001
-- 2008 Cisneros Sanjose 1007
-- 2007 Pereira Rome 1004

-- CREATE table Customers
-- ( Cnum  char(5) NOT NULL,
--  City VARCHAR(36)  NOT NULL,
--  Snum char(5),
--  PRIMARY KEY (Cnum),
--  FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum));

-- Table 3: Orders
-- Onum is Primary key
-- Cnum is foreign key refers to Cnum column of Customers table. Snum is foreign key refers Snum column of SalesPeople table.
-- Onum Amt Odate Cnum Snum
-- 3001 18.69 3-10-1990 2008 1007
-- 3003 767.19 3-10-1990 2001 1001
-- 3002 1900.10 3-10-1990 2007 1004
-- 3005  5160.45 3-10-1990 2003 1002
-- 3006  1098.16 3-10-1990 2008 1007
-- 3009 1713.23 4-10-1990 2002 1003
-- 3007  75.75 4-10-1990 2004 1002
-- 3008  4273.00 5-10-1990 2006 1001
-- 3010  1309.95 6-10-1990 2004 1002
-- 3011  9891.88 6-10-1990 2006 1001

-- CREATE table Orders
-- ( Onum  char(5) NOT NULL,
--  Cnum char(5) ,
--  Snum char(5),
--  PRIMARY KEY (Onum),
--  FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
--  FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum));

-- Insert values into the SalesPeople table with City and Comm columns

-- INSERT INTO SalesPeople (Snum, Sname)
-- VALUES
--   ('1001', 'Peel'),
--   ('1002', 'Serres'),
--   ('1004', 'Motika'),
--   ('1007', 'Rifkin'),
--   ('1003', 'Axelrod');

-- INSERT INTO Customers (Cnum, City)
-- VALUES
--   ('2001', 'London'),
--   ('2002', 'Rome'),
--   ('2003', 'Sanjose'),
--   ('2004', 'Berlin'),
--   ('2006', 'London'),
--   ('2008', 'Sanjose'),
--   ('2007', 'Rome');

--   
--   INSERT INTO Orders (Onum,Cnum, Snum)
-- VALUES
--   ('3001', '2008', '1007'),
--   ('3003',  '2001', '1001'),
--   ('3002','2007', '1004'),
--   ('3005', '2003', '1002'),
--   ('3006',  '2008', '1007'),
--   ('3009', '2002', '1003'),
--   ('3007','2004', '1002'),
--   ('3008','2006', '1001'),
--   ('3010', '2004', '1002'),
--   ('3011', '2006', '1001');
--   
-- INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum)
-- VALUES
--   ('3001', 18.69, '1990-03-10', '2008', '1007'),
--   ('3003', 767.19, '1990-03-10', '2001', '1001'),
--   ('3002', 1900.10, '1990-03-10', '2007', '1004'),
--   ('3005', 5160.45, '1990-03-10', '2003', '1002'),
--   ('3006', 1098.16, '1990-03-10', '2008', '1007'),
--   ('3009', 1713.23, '1990-04-10', '2002', '1003'),
--   ('3007', 75.75, '1990-04-10', '2004', '1002'),
--   ('3008', 4273.00, '1990-05-10', '2006', '1001'),
--   ('3010', 1309.95, '1990-06-10', '2004', '1002'),
--   ('3011', 9891.88, '1990-06-10', '2006', '1001');


-- ALTER TABLE Orders
-- ADD Amt DECIMAL(10, 2),  
-- ADD Odate DATE;          

--   
--   UPDATE Orders
-- SET
--   Amt =  9891.88,
--   Odate = '1990-06-10'
-- WHERE
--   Onum IN ('3011');

-- ALTER TABLE SalesPeople
-- ADD COLUMN   City VARCHAR(36)  NOT NULL,
-- ADD FOREIGN KEY (City) REFERENCES Customers(City);

select * from Orders;
select * from SalesPeople;
select * from Customers;

-- Count the number of Salespeople whose name begins with 'a' or 'A':

SELECT COUNT(*)
FROM SalesPeople
WHERE Sname LIKE 'A%' OR Sname LIKE 'a%';


--  Display all the Salesperson whose all orders worth is more than Rs. 2000.



SELECT S.Snum, S.Sname
FROM SalesPeople S
WHERE NOT EXISTS (
    SELECT O.Snum
    FROM Orders O
    WHERE O.Snum = S.Snum
    GROUP BY O.Snum
    HAVING SUM(O.Amt) <= 2000
);

-- Count the number of Salespeople belonging to New York:

SELECT COUNT(DISTINCT S.Snum) AS Num_Of_Salespeople
FROM Customers C
JOIN SalesPeople S ON C.Snum = S.Snum
WHERE C.City = 'New York';



-- Display the number of Salespeople belonging to London and belonging to Paris:

SELECT City, COUNT(DISTINCT S.Snum) AS NumberOfSalespeople
FROM Customers C
JOIN SalesPeople S ON C.Snum = S.Snum
WHERE City IN ('London', 'Paris')
GROUP BY City;



-- Display the number of orders taken by each Salesperson and their date of orders:

SELECT S.Sname AS SalespersonName, O.Onum AS OrderNumber, O.Odate AS OrderDate
FROM SalesPeople S
JOIN Customers C ON S.Snum = C.Snum
JOIN Orders O ON C.Cnum = O.Cnum
ORDER BY S.Sname, O.Onum;






