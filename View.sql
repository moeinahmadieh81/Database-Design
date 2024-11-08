
CREATE VIEW orders_customer AS
SELECT c.NationalCode, c.FirstName, c.LastName, c.PhoneNumber, c.Province, c.City, c.Street, o.OrderId, o.OrderDate, oi.ProductId, oi.NumberOfProducts
FROM Customers c
JOIN Orders o ON c.NationalCode = o.CustomerId
JOIN product_orders oi ON o.OrderId = oi.OrderId;
select * from orders_customer;

-- PRODUCT_TYPE_BRAND_COMPANY VIEW --
create view product_type_brand_company as
select p.ProductId,p.ProductName,p.ProductWeight,p.ProductCount,b.BrandId,b.BrandName,
c.CompanyId,c.CompanyName,c.EstablishDate,c.CompanyNumber,c.RepoAddress,m.ModelName  from Products as p
join brands as b on p.ProductBrand=b.BrandId
join company as c on p.CompanyId=c.CompanyId
join model as m on p.ModelId = m.ModelId;

select * from product_type_brand_company; 

-- Distributer_Distributes
create view distributes_distributor as
    select S.SupplierName, S.SupplierEmail, S.SupplierAddress, S.WorkHour, P.ProductName, B.BrandName, C.CompanyName, M.ModelName
    FROM product_supplier join Suppliers S on product_supplier.SupplierId = S.SupplierId
        join Products P on product_supplier.ProductId = P.ProductId
        join Company C on P.CompanyId = C.CompanyId
        join Brands B on P.ProductBrand = B.BrandId
        join Model M on P.ModelId = M.ModelId
    order by SupplierName;
    
    select * from distributes_distributor