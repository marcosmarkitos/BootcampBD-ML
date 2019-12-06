-- Pruebas de calidad de información de clientes



-- Consulta para obtener informacion de clientes

SELECT
*
FROM
...
-- 19143 con ambos scripts. OK pero distinto a lo marcado en la solución (18508)
SELECT
cus.CustomerID as cliente_code,
per.PersonType as tipo_cliente,
cast(per.Demographics as xml) as demog,
ad.PostalCode as cod_postal,
ad.City as ciudad,
sp.Name as Estado,
cr.Name as pais

FROM
Person.person per
inner join Sales.Customer cus on per.BusinessEntityID = cus.PersonID
left join Person.BusinessEntityAddress bea on per.BusinessEntityID = bea.BusinessEntityID
left join Person.Address ad on bea.AddressID = ad.AddressID
left join Person.StateProvince sp on ad.StateProvinceID = sp.StateProvinceID
left join Person.CountryRegion cr on sp.CountryRegionCode = cr.CountryRegionCode


