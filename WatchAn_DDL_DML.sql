--Create database system and use database
CREATE DATABASE WatchAN
USE WatchAn

--Create a database system using DDL syntax that relevant with sales and purchase transactions. 

CREATE TABLE Customer (
CustomerID char(5) PRIMARY KEY,
CustomerName varchar(20) CHECK(LEN(CustomerName) BETWEEN 6 AND 12),
CustomerGender varchar(6) CHECK(CustomerGender = 'Male' OR CustomerGender ='Female'),
CustomerAddress varchar(100),
CustomerPhone varchar(15) CHECK(CustomerPhone LIKE('0%'))
)

CREATE TABLE Agent (
AgentID char(5) PRIMARY KEY,
AgentName varchar(20),
AgentGender varchar(6) CHECK(AgentGender = 'Male' OR AgentGender = 'Female'),
AgentAddress varchar(100) CHECK(AgentAddress LIKE('% Street')),
AgentEmail varchar(50),
AgentPhone varchar(15),
AgentSalary INT
)

CREATE TABLE Vendor (
VendorID char(5) PRIMARY KEY,
VendorName varchar(20) CHECK(VendorName LIKE('PT %')),
VendorAddress varchar(100),
VendorPhone varchar(15),
VendorEmail varchar(20) CHECK(VendorEmail LIKE('%@%'))
)

CREATE TABLE Brand (
BrandID char(5) PRIMARY KEY,
BrandName varchar(20)
)

CREATE TABLE Watch (
WatchID char(5) PRIMARY KEY,
WatchName varchar(20),
WatchPrice INT CHECK(WatchPrice > 100000),
WatchStock INT,
BrandID char(5) FOREIGN KEY REFERENCES Brand(BrandID)
)

CREATE TABLE HeaderSalesTransaction (
SalesID char(5) PRIMARY KEY,
CustomerID char(5) FOREIGN KEY REFERENCES Customer(CustomerID),
AgentID char(5) FOREIGN KEY REFERENCES Agent(AgentID),
SalesDate date
)

CREATE TABLE DetailSalesTransaction (
SalesID char(5) FOREIGN KEY REFERENCES HeaderSalesTransaction(SalesID),
WatchID char(5) FOREIGN KEY REFERENCES Watch(WatchID),
SalesQty INT,
PRIMARY KEY(SalesID, WatchID)
)

CREATE TABLE HeaderPurchaseTransaction (
PurchaseID char(5) PRIMARY KEY,
VendorID char(5) FOREIGN KEY REFERENCES Vendor(VendorID),
AgentID char(5) FOREIGN KEY REFERENCES Agent(AgentID),
PurchaseDate date
)

CREATE TABLE DetailPurchaseTransaction (
PurchaseID char(5) FOREIGN KEY REFERENCES HeaderPurchaseTransaction(PurchaseID),
WatchID char(5) FOREIGN KEY REFERENCES Watch(WatchID),
PurchaseQty INT,
PRIMARY KEY(PurchaseID, WatchID)
)

--Create query using DML syntax to fill the tables in database systems with data

-- Master tables

INSERT INTO Customer VALUES
('CU001','Emma Watson','Female','Jl. Nusantara 1','081234567891'),
('CU002','Brad Pitt','Male','Jl. Palmerah 2','081236767893'),
('CU003','Michael Bay','Male','Jl. Kedoya 1','081236767100'),
('CU004','Bruce Jenner','Male','Jl. Kedoya 3','083436767883'),
('CU005','Will Smith','Male','Jl. Kedoya 5','085636767883'),
('CU006','Andy Grammer','Male','Jl. Palmerah 1','085636237883'),
('CU007','Emma Stone','Female','Jl Nusantara 2','085636607883'),
('CU008','Anna Taylor','Female','Jl Kembangan','085636607820'),
('CU009','Gal Gadot','Female','Jl Meruya','085612607820'),
('CU010','Margot Robie','Female','Jl Kembangan 2','085612607816')

INSERT INTO Agent VALUES
('AG001','Johnny Depp','Male','Brook Street','johnnydepp@gmail.com','081124792013','10000000'),
('AG002','Tom Hanks','Male','Luxembourg Street','tomhanks@gmail.com','082424792013','11000000'),
('AG003','Tom Cruise','Male','Paradise Street','tomcruise@yahoo.com','081156792013','12000000'),
('AG004','Al Pacino','Male','Kentwood Street','alpacino@outlook.com','081124802013','17000000'),
('AG005','Chris Pratt','Male','Diego Street','chrispratt@gmail.com','081124791813','14000000'),
('AG006','Mila Kunis','Female','Lanchester Street','milakunis@gmail.com','081124792010','19000000'),
('AG007','Salma Hayek','Female','Diamond Street','salmahy123@yahoo.com','081731792013','16000000'),
('AG008','Naomi Watts','Female','Eastwood Street','naomiwtts@gmail.com','081124798703','12500000'),
('AG009','Lady Gaga','Female','Yeongming Street','ladygaga@gmail.com','082310792013','17850000'),
('AG010','Miley Cyrus','Female','Woods Street','mileycyrus@gmail.com','082190792013','21300000')

INSERT INTO Brand VALUES
('BD001','Rolex'),
('BD002','BVLGARIA'),
('BD003','Jaeger LeCoult'),
('BD004','A.Lange & Sohne'),
('BD005','Audemars Piguet'),
('BD006','Patek Philippe'),
('BD007','IWC Schaffhausen'),
('BD008','Parmigiani Fleurier'),
('BD009','Omega'),
('BD010','Vacheron Constantin')

INSERT INTO Watch VALUES
('WA001','Reverso Hybris ','1250000','50 ','BD003'),
('WA002','ODYSSEUS','3250000','75','BD004'),
('WA003','RoyaOak BlackPanther','900000','200','BD005'),
('WA004','Golden ELLIPSE','650000','100','BD006'),
('WA005','GOL Schaffhanufseta','7890000','400','BD007'),
('WA006','TONDA GT','1200000','200','BD008'),
('WA007','BVLGARI ALUMINIUM ','750000','300','BD002'),
('WA008','OCTO ROMA WATCH','650000','100','BD002'),
('WA009','Oyster Perpetual','4650000','200','BD001'),
('WA010','Explorer','9100000','350','BD001')

INSERT INTO Vendor VALUES
('VN001','PT Rolex','Sillicon Valley Street','555-001','rolex@gmail.com'),
('VN002','PT BVLGARIA','Sillicon Valley Street','555-002','BVLGARIA@gmail.com'),
('VN003','PT Jaeger','Sillicon Valley Street','555-003','Jaeger@gmail.com'),
('VN004','PT A.Lange','Luxembourg Street','555-004','ALange@gmail.com'),
('VN005','PT Piguet','Luxembourg Street','555-005','Pigeut@gmail.com'),
('VN006','PT PatekPhil','Luxembourg Street','555-006','PatePhipe@gmail,com'),
('VN007','PT IWC','Eastwood Street','555-007','Schafusen@gmail.com'),
('VN008','PT Parmigiani','Eastwood Street','555-008','Parmigian@gmail.com'),
('VN009','PT Omega','Eastwood Street','555-009','Omega@gmail.com'),
('VN010','PT Vacheron','Westwood Street','555-010','Vacheron@gmail.com')

-- Transaction tables

INSERT INTO HeaderSalesTransaction VALUES
('SA001','CU001','AG001','2018-07-01'),
('SA002','CU002','AG002','2018-03-20'),
('SA003','CU003','AG003','2018-07-02'),
('SA004','CU004','AG004','2018-01-12'),
('SA005','CU005','AG005','2018-08-30'),
('SA006','CU006','AG006','2018-01-11'),
('SA007','CU007','AG007','2018-02-15'),
('SA008','CU008','AG008','2018-03-04'),
('SA009','CU009','AG009','2018-09-27'),
('SA010','CU010','AG010','2018-06-09'),
('SA011','CU001','AG001','2018-06-08'),
('SA012','CU002','AG002','2018-06-07'),
('SA013','CU003','AG003','2018-06-11'),
('SA014','CU004','AG004','2018-11-19'),
('SA015','CU005','AG005','2018-12-17'),
('SA016','CU006','AG006','2018-01-21'),
('SA017','CU007','AG007','2018-10-22'),
('SA018','CU008','AG008','2018-05-18'),
('SA019','CU009','AG009','2018-04-29'),
('SA020','CU010','AG010','2018-09-01'),
('SA021','CU001','AG001','2018-09-07'),
('SA022','CU002','AG002','2018-09-13'),
('SA023','CU003','AG003','2018-07-28'),
('SA024','CU004','AG004','2018-11-11'),
('SA025','CU005','AG005','2018-08-18')

INSERT INTO HeaderPurchaseTransaction VALUES
('PC001','VN001','AG001','2018-01-01'),
('PC002','VN002','AG002','2018-02-02'),
('PC003','VN003','AG003','2018-03-03'),
('PC004','VN004','AG004','2018-04-04'),
('PC005','VN005','AG005','2018-05-05'),
('PC006','VN006','AG006','2018-06-06'),
('PC007','VN007','AG007','2018-07-07'),
('PC008','VN008','AG008','2018-08-08'),
('PC009','VN009','AG009','2018-09-09'),
('PC010','VN010','AG010','2018-10-10'),
('PC011','VN001','AG001','2018-11-11'),
('PC012','VN002','AG002','2018-12-12'),
('PC013','VN003','AG003','2018-01-13'),
('PC014','VN004','AG004','2018-02-14'),
('PC015','VN005','AG005','2018-03-15'),
('PC016','VN006','AG006','2018-04-16'),
('PC017','VN007','AG007','2018-05-17'),
('PC018','VN008','AG008','2018-06-18'),
('PC019','VN009','AG009','2018-07-19'),
('PC020','VN010','AG010','2018-08-20'),
('PC021','VN001','AG001','2018-09-21'),
('PC022','VN002','AG002','2018-10-22'),
('PC023','VN003','AG003','2018-11-23'),
('PC024','VN004','AG004','2018-12-24'),
('PC025','VN005','AG005','2018-01-25')

--Transaction Detail Tables

INSERT INTO DetailSalesTransaction VALUES
('SA001','WA001','5'),
('SA002','WA002','12'),
('SA003','WA003','8'),
('SA004','WA004','1'),
('SA005','WA005','24'),
('SA006','WA006','100'),
('SA007','WA007','30'),
('SA008','WA008','45'),
('SA009','WA009','70'),
('SA010','WA010','10'),
('SA011','WA001','12'),
('SA012','WA002','14'),
('SA013','WA003','2'),
('SA014','WA004','20'),
('SA015','WA005','14'),
('SA016','WA006','12'),
('SA017','WA007','9'),
('SA018','WA008','60'),
('SA019','WA009','22'),
('SA020','WA010','125'),
('SA021','WA001','15'),
('SA022','WA002','45'),
('SA023','WA003','37'),
('SA024','WA004','28'),
('SA025','WA005','1')

INSERT INTO DetailPurchaseTransaction VALUES
('PC001','WA001','12'),
('PC002','WA002','8'),
('PC003','WA003','24'),
('PC004','WA004','20'),
('PC005','WA005','17'),
('PC006','WA006','3'),
('PC007','WA007','150'),
('PC008','WA008','250'),
('PC009','WA009','10'),
('PC010','WA010','23'),
('PC011','WA001','200'),
('PC012','WA002','1'),
('PC013','WA003','5'),
('PC014','WA004','100'),
('PC015','WA005','320'),
('PC016','WA006','11'),
('PC017','WA007','55'),
('PC018','WA008','240'),
('PC019','WA009','1'),
('PC020','WA010','72'),
('PC021','WA001','1'),
('PC022','WA002','23'),
('PC023','WA003','170'),
('PC024','WA004','210'),
('PC025','WA005','1')

--Simulates the transaction process for purchase and sales transactions
--Customers bought watches from WatchAN in February 2018
--WatchAn staff inserts data from customers to the database
INSERT INTO HeaderSalesTransaction VALUES
('SA026', 'CU010', 'AG001', '2018-02-01'),
('SA027', 'CU009', 'AG002', '2018-02-02'),
('SA028', 'CU008', 'AG003', '2018-02-03'),
('SA029', 'CU007', 'AG004', '2018-02-04'),
('SA030', 'CU006', 'AG005', '2018-02-05')

--WatchAN staff inserts detail transaction to the database
INSERT INTO DetailSalesTransaction VALUES
('SA026', 'WA010', 2),
('SA027', 'WA009', 4),
('SA028', 'WA008', 10),
('SA029', 'WA007', 2),
('SA030', 'WA006', 3)

--WatchAN stock watches from different vendors in February 2018
INSERT INTO HeaderPurchaseTransaction VALUES
('PC026', 'VN001', 'AG001', '2018-02-06'),
('PC027', 'VN002', 'AG002', '2018-02-07'),
('PC028', 'VN003', 'AG003', '2018-02-08'),
('PC029', 'VN004', 'AG004', '2018-02-09'),
('PC030', 'VN005', 'AG005', '2018-02-10')

--WatchAN staff reported it by inserting data to the database
INSERT INTO DetailPurchaseTransaction VALUES
('PC026', 'WA001', 15),
('PC027', 'WA002', 20),
('PC028', 'WA003', 30),
('PC029', 'WA004', 32),
('PC030', 'WA005', 12)

/*a. To support database management process in WatchAN, Joel asked you to provide some 
query that resulting important data. The requirements that asked from his are:*/

/*1. Display PurchaseId, AgentID, AgentGender, and Total Price 
(obtained from the sum of watch price) for each vendor which id ends with ‘4’ 
and the Total price is greater than 500000.*/

SELECT 
hpt.PurchaseID, 
a.AgentID, 
AgentGender,
[Total Price] = SUM(WatchPrice)
FROM  Agent a JOIN HeaderPurchaseTransaction hpt 
ON a.AgentID = hpt.AgentID JOIN DetailPurchaseTransaction dpt
ON hpt.PurchaseID = dpt.PurchaseID JOIN Watch w
ON dpt.WatchID = w.WatchID
WHERE VendorID LIKE '%4'
GROUP BY hpt.PurchaseID, a.AgentID, AgentGender
HAVING SUM(WatchPrice) > 500000

/*2. Display TotalSalesTransaction (obtained from total number of sales transaction), 
Name (obtained from customer name in uppercase format) for every customer who bought
watch after the 2nd month of the year and have bought more than 4 watch in one transaction.*/

SELECT 
[Total Sale Transaction] = COUNT(hst.SalesID),
[Name] = UPPER(CustomerName)
FROM Customer c JOIN HeaderSalesTransaction hst
ON c.CustomerID = hst.CustomerID JOIN DetailSalesTransaction dst
ON hst.SalesID = dst.SalesID
WHERE DATEPART(MONTH, SalesDate)> 2 
GROUP BY CustomerName
HAVING COUNT(hst.SalesID) > 4

/*3.	Display BrandCode (obtained by adding ‘Brand ’ word in front of the last three digits of 
brand id), BrandName, Max Stock (obtained from highest stock of watch stock and ends with ‘pcs ’), 
and Min Stock (obtained from lowest stock of watch stock and ends with ‘pcs ’) for every watch which 
sold on 2018 and the watch brand name is ‘BVLGARIA’.*/

SELECT 
[BrandCode] = 'Brand ' + RIGHT(b.BrandID, 3), 
BrandName, 
[Max Stock] = CAST(MAX(WatchStock)AS varchar) + 'pcs ', 
[Min Stock] = CAST(MIN(WatchStock)AS varchar) + 'pcs '
FROM Brand b
JOIN Watch w
ON b.BrandID = w.BrandID
JOIN DetailSalesTransaction dts
ON w.WatchID = dts.WatchID
JOIN HeaderSalesTransaction hst
ON dts.SalesID = hst.SalesID
WHERE YEAR(SalesDate) = '2018'
AND BrandName = 'BVLGARIA'
GROUP BY b.BrandID, b.BrandName

/*4.	Display CustomerName, Customer Gender (obtained from customer gender in uppercase format), 
Total Watch Purchased (obtained from the sum of quantity), and Watch Owned (obtained from the count 
of watch) for every customer whose id is either ‘CU002’ or ‘CU003’ and did a transaction on odd month.*/

SELECT 
cs.CustomerName,
[Customer Gender] = UPPER(CustomerGender),
[Total Watch Purchased] = SUM(SalesQty),
[Watch Owned] = COUNT(WatchID)
FROM Customer cs JOIN HeaderSalesTransaction hst
ON cs.CustomerID = hst.CustomerID JOIN DetailSalesTransaction dst
ON hst.SalesID = dst.SalesID
WHERE cs.CustomerID = 'CU002' OR cs.CustomerID = 'CU003' AND
DATEPART(MONTH, SalesDate) %2=1
GROUP BY cs.CustomerName, cs.CustomerGender

/*5.	Display AgentName, AgentAddress, AgentPhone (obtained by replacing the first letter of agent phone 
with ‘+62’), and TotalPurchaseTransaction (obtained from the total of transaction and ends with 
‘ Transaction(s)’) for every watch which price is greater than 1000000 and total purchase transaction is more than 1.
(alias subquery)
*/

SELECT 
AgentName,
AgentAddress,
AgentPhone = REPLACE (AgentPhone, Substring(AgentPhone,1,2), '+62'),
[TotalPurchaseTransaction] = CAST(tpt.[TotalPurchaseTransaction] AS VARCHAR) + ' Transaction(s)'
FROM Agent a,
(
SELECT AgentID, [TotalPurchaseTransaction] = COUNT(hpt.PurchaseID), WatchPrice
FROM HeaderPurchaseTransaction hpt JOIN DetailPurchaseTransaction dpt
ON hpt.PurchaseID = dpt.PurchaseID JOIN Watch w
ON dpt.WatchID = w.WatchID
GROUP BY AgentID, WatchPrice
) AS tpt
WHERE
a.AgentID = tpt.AgentID AND
tpt.WatchPrice > 1000000 AND
tpt.[TotalPurchaseTransaction] > 1

/*6.	Display CustomerID, and TotalTransaction (obtained from the total of sales transaction and ends with 
‘ Transaction(s)’), for every watch that has name longer than 18 characters and the last character is not an 
‘a’ character.
(alias subquery)*/

SELECT 
c.CustomerID, 
[TotalTransaction] = CAST(COUNT(hst.SalesID)AS varchar) + ' Transaction(s)'
FROM Customer c, HeaderSalesTransaction hst,
DetailSalesTransaction dst,
(
 SELECT [Watch ID] = watchID 
 FROM Watch
 WHERE LEN(WatchName) > 18
 AND RIGHT(WatchName, 1) != 'a'
) AS watchLength
WHERE c.CustomerID = hst.CustomerID AND
hst.SalesID = dst.SalesID AND
dst.WatchID = watchLength.[Watch ID]
GROUP BY c.CustomerID

/*7.	Display Customer First Name (obtained from the first word of customer name), and Total Quantity 
(obtained from the sum of quantity) for every customer who bought a watch with total quantity greater than
the average quantity of all transaction that occurred on 2018. 
(alias subquery)*/

SELECT 
[First Name] = LEFT(CustomerName, CHARINDEX(' ', CustomerName)-1), 
[Total Quantity] = SUM(SalesQty)
FROM Customer c, 
HeaderSalesTransaction hst,
DetailSalesTransaction dst,
(
 SELECT [SalesQuantity] = AVG(SalesQty)
 FROM DetailSalesTransaction dst
 JOIN HeaderSalesTransaction hst
 ON dst.SalesID = hst.SalesID
 WHERE YEAR(SalesDate) = '2018'
) AS AvgQty
WHERE c.CustomerID = hst.CustomerID AND
hst.SalesID = dst.SalesID AND
dst.SalesQty > AvgQty.[SalesQuantity]
GROUP BY CustomerName

/*8. Display Brand Name (obtained from brand name in lowercase format), and Total Watch (obtained from the 
count of watch and ends with ‘ watch(es)’) for every watch that sold on a day before the maximum day of every 
sales transaction date in September. 
(alias subquery)*/

SELECT 
[Brand Name] = LOWER(BrandName),
[Total Watch] = CAST(COUNT(w.WatchID) AS VARCHAR) + ' watch(es)'
FROM
(
SELECT
[dayMax] = MAX(DATEPART(DAY,SalesDate))
FROM HeaderSalesTransaction hst
WHERE DATENAME(MONTH, SalesDate) = 'September'
) AS dm, Watch w, Brand b, DetailSalesTransaction dst, HeaderSalesTransaction hst
WHERE b.BrandID = w.BrandID AND
w.WatchID = dst.watchID AND
hst.SalesID = dst.SalesID AND
DATEPART(DAY, SalesDate) < dm.[dayMax] 
GROUP BY BrandName

/*9.	Create a view named ‘CustomCustomerViewer’ to display CustomerID, CustomerName, Maximum Quantity 
(obtained from the highest of quantity sold), and Minimum Quantity (obtained from the lowest of quantity sold), 
for every sales transaction that occurred on 2018 and the customer’s name contains ‘o’ character.*/

CREATE VIEW CustomCustomerViewer AS(
SELECT
c.CustomerID,
CustomerName,
[Maximum Quantity] = MAX(SalesQty),
[Minimum Quantity] = MIN(SalesQty)
FROM Customer c JOIN HeaderSalesTransaction hst
ON c.CustomerID = hst.CustomerID JOIN DetailSalesTransaction dst
ON hst.SalesID = dst.SalesID
WHERE DATEPART(YEAR, SalesDate) = 2018 AND
CustomerName LIKE '%o%'
GROUP BY c.CustomerID, CustomerName
)

/*10. Create a view named ‘CustomVendorViewer’ to display VendorName, WatchName, Purchase Date, Total Purchase 
(obtained from the sum of quantity), and Minimum Purchase (obtained from the minimum of quantity) for every 
transaction that occurred in June and had minimum purchase that is greater than 4.*/

CREATE VIEW CustomVendorViewer AS(
SELECT
VendorName,
WatchName,
[Purchase Date] = PurchaseDate,
[Total Purchase] = SUM(PurchaseQty),
[Minimum Purchase] = MIN(PurchaseQty)
FROM Vendor Vd JOIN HeaderPurchaseTransaction hpt
ON vd.VendorID = hpt.VendorID JOIN DetailPurchaseTransaction dpt
ON hpt.PurchaseID = dpt.PurchaseID JOIN Watch w
ON dpt.WatchID = w.WatchID
WHERE DATENAME(MONTH, PurchaseDate) = 'June'
GROUP BY VendorName, WatchName, PurchaseDate
HAVING MIN(PurchaseQty) > 4
)