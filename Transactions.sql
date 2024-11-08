ALTER TABLE Products
ADD COLUMN is_sold BOOLEAN DEFAULT false;
UPDATE Products
SET is_sold = TRUE
WHERE ProductId IN (
    SELECT DISTINCT productId
    FROM product_orders
);

CREATE PROCEDURE ProcessOrder(IN OrderId INT)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION, SQLWARNING
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Update stock for the supplier
    UPDATE product_supplier pi
    JOIN (SELECT * from product_orders oi
                         where oi.OrderId = OrderId) oi on (pi.SupplierId = oi.SupplierId AND pi.ProductId = oi.ProductId)
    SET pi.NumberOfProducts = pi.NumberOfProducts - oi.NumberOfProducts;


    COMMIT;
END;


CALL ProcessOrder(1);

select * from product_supplier;

select * from product_orders
where OrderId = 1;