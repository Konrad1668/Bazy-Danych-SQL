select * from Production.Product

begin transaction

update Production.Product 
set StandardCost = StandardCost * 1.1;

if(select sum(StandardCost) from Production.Product <= 50000
begin
	commit transaction;
end

else
begin
	rollback transaction;
end