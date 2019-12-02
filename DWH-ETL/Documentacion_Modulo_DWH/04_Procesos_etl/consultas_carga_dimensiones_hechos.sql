-- Clientes (18508)
SELECT
cus.CustomerID as cliente_code,
per.PersonType,
cast(per.Demographics as xml) as demog,
ad.PostalCode,
ad.City,
sp.Name as Estado
FROM
Sales.Customer cus,
Person.Person per
left join Person.BusinessEntityAddress bea on per.BusinessEntityId = bea.BusinessEntityId 
left join Person.Address ad ON bea.AddressId = ad.AddressId
left join Person.StateProvince sp ON ad.StateProvinceID = sp.StateProvinceID
where
cus.PersonId = per.BusinessEntityId


-- Vendedores (17)
SELECT
SELECT
sp.BusinessEntityID as vendedor_code,
em.Gender,
em.BirthDate,
em.HireDate,
em.JobTitle,
st.Name as region,
st.[Group] as territorio
FROM
Sales.SalesPerson sp
left join Person.Person per on sp.BusinessEntityID = per.BusinessEntityID
left join HumanResources.Employee em on sp.BusinessEntityID = em.BusinessEntityID
left join Sales.SalesTerritory st on sp.TerritoryID = st.TerritoryID


-- Productos (295)
SELECT
pr.ProductNumber,
pr.Name,
pr.MakeFlag,
pr.FinishedGoodsFlag,
pr.Color,
pr.Size,
pr.Weight,
pr.ProductLine,
pr.Class,
pr.Style,
pc.Name as categoria,
ps.Name as subcategoria
From 
Production.Product pr
left join Production.ProductSubcategory ps ON pr.ProductSubcategoryID = ps.ProductSubcategoryID
left join Production.ProductCategory pc On ps.ProductCategoryID = pc.ProductCategoryID
WHERE
pr.FinishedGoodsFlag = 1

-- Ventas (121317)
SELECT
z.SalesOrderNumber,
z.ProductNumber,
z.OrderDate,
z.CustomerId,
z.OnlineOrderFlag,
z.SalesPersonId,
z.OrderQty,
z.UnitPrice,
z.UnitPriceDiscount,
z.LineTotal,
pch.StandardCost,
OrderQty*StandardCost as coste_total,
z.LineTotal -  OrderQty*StandardCost as margen_total
FROM
(
SELECT
soh.SalesOrderNumber,
pr.ProductNumber,
pr.ProductID,
soh.OrderDate,
soh.CustomerId,
soh.OnlineOrderFlag,
soh.SalesPersonId,
sod.OrderQty,
sod.UnitPrice,
sod.UnitPriceDiscount,
sod.LineTotal
FROM
Sales.SalesOrderHeader soh,
Sales.SalesOrderDetail sod,
Production.Product pr
WHERE
soh.[Status] = 5 and
soh.SalesOrderId = sod.SalesOrderId AND
sod.ProductId = pr.ProductId
) z
left join Production.ProductCostHistory pch ON z.ProductID = pch.ProductID and z.OrderDate >= pch.StartDate and z.OrderDate <= isnull(pch.EndDate,convert(Date,'2099-12-31'))
