CREATE DATABASE WatchAN
USE WatchAn

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
