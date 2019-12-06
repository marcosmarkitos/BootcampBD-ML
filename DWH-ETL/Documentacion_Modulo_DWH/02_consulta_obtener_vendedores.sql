-- Pruebas de calidad de información de clientes vendedores



-- Consulta para obtener informacion de vendedores

SELECT
*
FROM
...
-- 17 con ambos scripts. OK
SELECT
sp.BusinessEntityID as vendedor_code,
em.Gender as sexo,
em.BirthDate as fecha_nacimiento,
em.HireDate as fecha_contratacion,
em.JobTitle as puesto,
st.Name as region,
st.Group as territorio

FROM
Sales.SalesPerson sp
inner join HumanResources.Employee em on sp.BusinessEntityID = em.BusinessEntityID
left join Sales.SalesTerritory st on sp.TerritoryID = st.TerritoryID
