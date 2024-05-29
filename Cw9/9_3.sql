begin transaction

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
	'BB-1668-01',
	'Silver',
	2000
	100,
	1.5,
	15,
	0.3,
	'CM',
	'G',
	20,
	getdate()
);

select *
from Production.Product
where Name = 'Ball Bearing'

commit transaction;



