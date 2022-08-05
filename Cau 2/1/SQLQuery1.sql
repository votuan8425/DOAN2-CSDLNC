select P.ProductID, P.Name, P.ListPrice
from Purchasing.PurchaseOrderHeader as POH join Purchasing.PurchaseOrderDetail as POD on POH.PurchaseOrderID = POD.PurchaseOrderID
join Production.Product as P on P.ProductID = POD.ProductID
where POH.OrderDate between '2011-04-01' and '2011-05-01'

drop INDEX [_dta_index_Product_15_482100758__K1_2_10] ON [Production].[Product]
(
	[ProductID] ASC
)
INCLUDE([Name],[ListPrice]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
drop INDEX [_dta_index_PurchaseOrderDetail_15_1506104406__K1_K5] ON [Purchasing].[PurchaseOrderDetail]
(
	[PurchaseOrderID] ASC,
	[ProductID] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [_dta_index_PurchaseOrderHeader_15_1602104748__K7] ON [Purchasing].[PurchaseOrderHeader]
(
	[OrderDate] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

CREATE STATISTICS [_dta_stat_1602104748_7_1] ON [Purchasing].[PurchaseOrderHeader]([OrderDate], [PurchaseOrderID])

commit