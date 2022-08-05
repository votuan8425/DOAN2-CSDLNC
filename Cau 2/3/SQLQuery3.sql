WITH cte_BOM (ProductID, Name, Color, Quantity, ProductLevel, ProductAssemblyID, Sort)
AS  (SELECT P.ProductID,
            CAST (P.Name AS VARCHAR (100)),
            P.Color,
            CAST (1 AS DECIMAL (8, 2)),
            1,
            NULL,
            CAST (P.Name AS VARCHAR (100))
     FROM   Production.Product AS P
            INNER JOIN
            Production.BillOfMaterials AS BOM
            ON BOM.ComponentID = P.ProductID
            AND BOM.ProductAssemblyID IS NULL
            AND (BOM.EndDate IS NULL
                OR BOM.EndDate > GETDATE())
     UNION ALL
     SELECT P.ProductID,
            CAST (REPLICATE('|---', cte_BOM.ProductLevel) + P.Name AS VARCHAR (100)),
            P.Color,
            BOM.PerAssemblyQty,
            cte_BOM.ProductLevel + 1,
            cte_BOM.ProductID,
            CAST (cte_BOM.Sort + '\' + p.Name AS VARCHAR (100))
     FROM   cte_BOM
            INNER JOIN Production.BillOfMaterials AS BOM
            ON BOM.ProductAssemblyID = cte_BOM.ProductID
            INNER JOIN Production.Product AS P
            ON BOM.ComponentID = P.ProductID
            AND (BOM.EndDate IS NULL
                OR BOM.EndDate > GETDATE())
    )
SELECT   ProductID,
         Name,
         Color,
         Quantity,
         ProductLevel,
         ProductAssemblyID,
         Sort
FROM     cte_BOM
ORDER BY Sort;

CREATE NONCLUSTERED INDEX [_dta_index_BillOfMaterials_15_1157579162__K2_K5_3_8] ON [Production].[BillOfMaterials]
(
	[ProductAssemblyID] ASC,
	[EndDate] ASC
)
INCLUDE([ComponentID],[PerAssemblyQty]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
CREATE STATISTICS [_dta_stat_1157579162_3_2_5] ON [Production].[BillOfMaterials]([ComponentID], [ProductAssemblyID], [EndDate])
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [_dta_index_Product_15_482100758__K1_K6_2] ON [Production].[Product]
(
	[ProductID] ASC,
	[Color] ASC
)
INCLUDE([Name]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
