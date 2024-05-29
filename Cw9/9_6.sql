select *
from Sales.SalesOrderDetail;

begin transaction;

update Sales.SalesOrderDetail
set OrderQty = OrderQty * 2;

if exists(select 1 from Sales.SalesOrderDetail where OrderQty = 0)
begin
	rollback transaction;
end

else
begin
	commit transaction;
end





