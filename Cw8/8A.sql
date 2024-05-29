--adventureworks2022

with TempEmployeeInfo as 
(
    select
    	emp.BusinessEntityID, -- hre.employee
        prs.FirstName, prs.LastName, -- person.persons
		hreph.Rate -- hre.payhistory
    from
        HumanResources.EmployeePayHistory as hreph
        
    join HumanResources.Employee as emp on hreph.BusinessEntityID = emp.BusinessEntityID
    join Person.Person as prs on emp.BusinessEntityID = prs.BusinessEntityID
)

select * 
from TempEmployeeInfo;
