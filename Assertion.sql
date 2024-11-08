
create assertion product_register check (not exists (select ProductId, ModelId from products S,X where S.ProductId = X.ProductID and S.ModelId <> X.ModelId));

create assertion product_order check(not exists(select ProductId, COUNT(OrderId) from Orders group by ProductId having COUNT(OrderId) > 1);