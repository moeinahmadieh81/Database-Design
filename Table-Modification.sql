INSERT INTO Customers (NationalCode,FirstName, LastName, PhoneNumber, Province, City, Street) VALUES ('1234567810', 'Harry', 'Kane', '44796268462', '212 Baker Street', 'London', 'London');
-- INSERT DATA INTO ORDER TABLE
INSERT INTO Orders(NumberOfProducts,OrderDate,CustomerId,ProductId)values(10,'2021-12-30','1234567810','599268216196');
-- Update harry's phonenumber
UPDATE Customers
SET PhoneNumber = '4473427800'
WHERE NationalCode = '1234567810'; 

-- DELETE QUERY
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Customers
WHERE NOT EXISTS (
  SELECT Orderid
  FROM Orders
  WHERE Orders.CustomerId = Customers.NationalCode
);