--Simulates the transaction process
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