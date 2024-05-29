update Production.Product 
set ListPrice = 1431.50
where ProductID = 680;

--

begin transaction

	update Production.Product
	set ListPrice = ListPrice * 1.1
	where ProductID = 680;

commit transaction;

select ProductID, Name, ListPrice
from Production.Product
where ProductID = 680;