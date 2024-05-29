begin transaction

declare @NewProductNo NVARCHAR(25) = 'BB-1668-02'

if not exists (select 1 from Production.Product where ProductNumber = @NewProductNo)
begin
	insert into Production.Product
	(
		Name,
		ProductNumber,
		Color,
		SafetyStockLevel,
		ReorderPoint,
		StandardCost,
		ListPrice,
		Size,
		SizeUnitMeasureCode,
		WeightUnitMeasureCode,
		Weight,
		SellStartDate
	)

	values
	(
		'Ball Bearing',
		@NewProductNo,
		'Silver',
		2000,
		100,
		1.5,
		15,
		0.3,
		'CM',
		'G',
		20,
		getdate()
	);

	commit transaction;
end

else
begin
	rollback transaction;
end

select *
from Production.Product
where ProductNumber  = @NewProductNo;
