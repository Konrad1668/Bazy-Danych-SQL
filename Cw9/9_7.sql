select *
from Production.Product

begin transaction;

declare @AverageCost money;
select @AverageCost = avg(StandardCost)
from Production.Product;


declare @DeletionAmmount int;
select @DeletionAmmount = count(*)
from Production.Product
where StandardCost > @AverageCost;


if @DeletionAmmount <= 10;
begin
	delete Production.Product
	where StandardCost > @AverageCost;
commit transaction;
end

else 
begin
	rollback transaction;
end
