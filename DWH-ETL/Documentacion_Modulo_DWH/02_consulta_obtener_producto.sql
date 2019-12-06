-- Pruebas de calidad de información de productos




-- Consulta para obtener informacion de productos

SELECT
*
FROM
Production.Product
-- 295 en ambos scripts. OK
SELECT
pr.ProductNumber as product_number,
pr.Name as nombre,
pr.MakeFlag as interno,
pr.FinishedGoodsFlag as vendible,
pr.Color,
pr.Size as talla,
pr.Weight as peso,
pr.ProductLine as linea,
pr.Class as clase,
pr.Style as estilo,
pc.Name as categoria,
ps.Name as subcategoria


FROM
Production.Product pr
left join Production.ProductSubcategory ps on pr.ProductSubcategoryId = ps.ProductSubcategoryId
left join Production.ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID

WHERE
pr.FinishedGoodsFlag is true
