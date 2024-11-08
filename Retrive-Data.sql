SELECT SupplierId, SupplierName, ProductName, ProductId, TotalAmount
FROM (
  SELECT SupplierId, SupplierName, ProductName, ProductId, TotalAmount, ROW_NUMBER() OVER (PARTITION BY SupplierId ORDER BY SupplierId, TotalAmount DESC) AS row_num
  FROM (
      SELECT s.SupplierId, s.SupplierName, p.ProductName, p.ProductId, SUM(oi.NumberOfProducts) AS TotalAmount
        FROM Suppliers s
        JOIN product_supplier pi ON s.SupplierId = pi.SupplierId
        JOIN Products p ON pi.ProductId = p.ProductId
        JOIN product_orders oi ON p.ProductId = oi.ProductId
        GROUP BY s.supplierId, p.ProductId
        ) As subquery2
) AS subquery
WHERE row_num <= 10;







SELECT City, ProductId, ProductName, TotalAmount
FROM (
  SELECT City, ProductId, ProductName, TotalAmount, ROW_NUMBER() OVER (PARTITION BY City ORDER BY City, TotalAmount DESC) AS row_num
  FROM (
      SELECT c.City, p.ProductId, p.ProductName, SUM(oi.NumberOfProducts) AS TotalAmount
        FROM Customers c
        JOIN Orders o ON c.NationalCode = o.CustomerId
        JOIN product_orders oi ON o.OrderId = oi.OrderId
        JOIN Products p ON oi.ProductId = p.ProductId
        GROUP BY c.City, p.ProductId
        ORDER BY c.City, TotalAmount DESC
        ) As subquery2
) AS subquery
WHERE row_num <= 10;


SELECT s.SupplierId, s.SupplierName AS UserName, SUM(oi.NumberOfProducts) AS TotalAmount
FROM Suppliers s
JOIN product_supplier pi ON s.SupplierId = pi.SupplierId
JOIN Products p ON pi.ProductId = p.ProductId
JOIN product_orders oi ON p.ProductId = oi.ProductId
JOIN Orders o ON oi.OrderId = o.OrderId
WHERE YEAR(o.OrderDate) = YEAR(CURDATE())
GROUP BY s.SupplierId
ORDER BY TotalAmount DESC
LIMIT 5;


SELECT COUNT(*) AS DistributorCount
FROM (
    SELECT pi.SupplierId
    FROM product_supplier pi
    JOIN Products p ON pi.ProductId = p.ProductId
    JOIN product_orders oi ON p.ProductId = oi.ProductId
    WHERE p.ProductName = 'rose flower cake'
    GROUP BY pi.SupplierId
    HAVING SUM(oi.NumberOfProducts) > (
        SELECT SUM(oi.NumberOfProducts)
        FROM product_supplier pi
        JOIN Products p ON pi.ProductId = p.ProductId
        JOIN product_orders oi ON p.ProductId = oi.ProductId
        WHERE p.ProductName = 'croissant cake'
        GROUP BY pi.SupplierId
    )
) AS Distributors;


select product_orders.ProductId, ProductName, SUM(NumberOfProducts) as total_amount
from (select OrderId
    from product_orders join Products on product_orders.ProductId = Products.ProductId join Model on Products.ModelId = Model.ModelId
    where Model.ModelName = 'Shir') as subquery join product_orders on subquery.orderId = product_orders.OrderId join Products P on product_orders.ProductId = P.ProductId join Model M on P.ModelId = M.ModelId
where M.ModelName != 'Shir'
group by product_orders.ProductId
ORDER BY total_amount DESC
LIMIT 3