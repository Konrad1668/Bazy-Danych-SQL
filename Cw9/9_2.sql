begin transaction

	delete from Production.Product
	where ProductID = 707;

commit transaction;
	
rollback transaction;
