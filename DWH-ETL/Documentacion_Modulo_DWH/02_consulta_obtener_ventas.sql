-- Pruebas de calidad de información de ventas realizadas




-- Consulta para obtener informacion de las ventas realizadas

SELECT
*
FROM
Sales.SalesOrderHeader
-- 121253 Vs 121317 de la solución
SELECT
soh.SalesOrderNumber as pedido,
sod.ProductID as producto,
soh.OrderDate as fecha,
soh.OrderDate as hora,
soh.OnlineOrderFlag as es_online,
soh.CustomerID as cliente,
soh.SalesPersonID as vendedor,
sod.OrderQty as cantidad,
sod.UnitPrice as importe_unidad,
sod.UnitPriceDiscount as descuento_unidad,
sod.LineTotal as importe_total,
pch.StandardCost as coste_unidad,
OrderQty * StandardCost as coste_total,
LineTotal - OrderQty * StandardCost as margen_total 

FROM
Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
inner join Production.ProductCostHistory pch on sod.ProductID = pch.ProductID 

where
soh.Status = 5 and soh.OrderDate >= pch.StartDate and soh.OrderDate <= coalesce (pch.EndDate, to_Date('2099-12-31','YYYY-MM-DD'))

--------------------------------------------------------
Otra solución metiendo el productName:
SELECT
z.pedido,
z.productNumber,
z.producto,
z.fecha,
z.hora,
z.es_online,
z.cliente,
z.vendedor,
z.cantidad,
z.importe_unidad,
z.descuento_unidad,
z.importe_total,
pch.StandardCost as coste_unidad,
cantidad * StandardCost as coste_total,
importe_total - cantidad * StandardCost as margen_total 

FROM
(
SELECT
soh.SalesOrderNumber as pedido,
sod.ProductID as producto,
soh.OrderDate as fecha,
soh.OrderDate as hora,
soh.OnlineOrderFlag as es_online,
soh.CustomerID as cliente,
soh.SalesPersonID as vendedor,
sod.OrderQty as cantidad,
sod.UnitPrice as importe_unidad,
sod.UnitPriceDiscount as descuento_unidad,
sod.LineTotal as importe_total,
pr.productNumber

FROM
Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
inner join Production.Product pr on sod.ProductID = pr.ProductID 

where
soh.Status = 5) z
left join Production.ProductCostHistory pch on z.producto = pch.ProductId 
and z.fecha >= pch.StartDate
and z.fecha <= coalesce (pch.EndDate, to_Date('2099-12-31','YYYY-MM-DD'))

