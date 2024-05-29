begin transaction

	delete from Production.Product
	where ProductID = 707;

submit transaction;
	
rollback transaction;