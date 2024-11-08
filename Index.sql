-- INDEX ON CUSTOMER PHONE NUMBER
CREATE INDEX PhoneNumber_IDX ON Customers(PhoneNumber);

-- INDEX ON SUPPLIER AMOUNT
CREATE INDEX Amount_Index ON Suppliers(SupplierAmount);

-- INDEX ON PRODUCT WEIGHT
CREATE INDEX Wieght_Index ON Products(ProductWeight);

-- INDEX ON BRAND NAME
CREATE INDEX Name_Index ON Brands(BrandName);