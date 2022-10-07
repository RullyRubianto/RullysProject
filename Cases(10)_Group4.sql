
-- No 1
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

-- No 2
SELECT 
[Total Sale Transaction] = COUNT(hst.SalesID),
[Name] = UPPER(CustomerName)
FROM Customer c JOIN HeaderSalesTransaction hst
ON c.CustomerID = hst.CustomerID JOIN DetailSalesTransaction dst
ON hst.SalesID = dst.SalesID
WHERE DATEPART(MONTH, SalesDate)> 2 
GROUP BY CustomerName
HAVING COUNT(hst.SalesID) > 4

-- No 3
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

-- No 4
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

-- No 5
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

-- No 6
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

-- No 7
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

-- No 8
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

-- No 9
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

-- No 10
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
