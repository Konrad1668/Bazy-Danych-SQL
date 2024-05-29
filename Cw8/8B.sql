--adventureworksLT2022

with CompanyRevenues as
(
	select
		cust.CompanyName + ' (' + cust.FirstName + ' ' + cust.LastName + ' )' as CompanyContact, -- sales.cust
		SUM(soh.TotalDue) as revenue

	from SalesLT.Customer as cust
	join SalesLT.SalesOrderHeader soh on cust.CustomerID = soh.CustomerID
	
	group by
        cust.CompanyName, cust.FirstName, cust.LastName
)

select *
from CompanyRevenues
order by revenue;