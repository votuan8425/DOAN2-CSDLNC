select distinct E.*
from Sales.SalesOrderHeader as SOH join Sales.SalesPerson as SP on SOH.SalesPersonID = SP.BusinessEntityID 
join HumanResources.Employee as E on SP.BusinessEntityID = E.BusinessEntityID 
where  OrderDate > '2011-06-30' and OrderDate < '2011-08-01' and OnlineOrderFlag = '0'

CREATE NONCLUSTERED INDEX [_dta_index_SalesOrderHeader_15_1922105888__K12_K7_K3] ON [Sales].[SalesOrderHeader]
(
	[SalesPersonID] ASC,
	[OnlineOrderFlag] ASC,
	[OrderDate] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

CREATE STATISTICS [_dta_stat_1922105888_12_3] ON [Sales].[SalesOrderHeader]([SalesPersonID], [OrderDate])

CREATE STATISTICS [_dta_stat_1922105888_7_3] ON [Sales].[SalesOrderHeader]([OnlineOrderFlag], [OrderDate])
