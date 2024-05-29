--adventureworksLT2022

with Sales as
(
	select pc.name as category od.UnitPrice as SalesValue -- sales.productCategory
	
	from SalesLT.ProductCategory as pc
	join SalesLT.Product as pr on pr.ProductCategoryID = pc.ProductCategoryID
	join SalesLT.SalesOrderDetail as sod on pr.ProductID = sod.ProductID
)

select *
from Sales
order by category