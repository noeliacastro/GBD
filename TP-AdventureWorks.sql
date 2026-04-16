use [AdventureWorks2008R2]

--1. mostrar los empleados que tienen mas de 90 horas de vacaciones 
select	[NationalIDNumber] as ID,
		VacationHours as Horas_de_Vacaciones
from	[HumanResources].[Employee]
where	VacationHours > 90
--2. mostrar el nombre, precio y precio con iva de los productos fabricados
select  'Info' as Informacion,--columna agregada
		Name Nombre,
		Color Color,
		ListPrice 'Precio de Lista',
		ListPrice * 1.21 'Precio con IVA' --columna calculada
from	[Production].[Product]
where	ListPrice > 0
order by ListPrice desc

--3. mostrar los diferentes titulos de trabajo que existen
select  distinct (JobTitle) as 'Diferentes titulos de trabajo'
from HumanResources.Employee
where JobTitle is not null


--4. mostrar todos los posibles colores de productos 
select	distinct (Color) as 'Diferentes Colores de Productos' 
from	[Production].[Product]
where	Color is not null

--5. mostrar todos los tipos de pesonas que existen 
select distinct (PersonType) as 'tipos de personas'
from  Person.Person
where PersonType is not null

--6. mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
select	FirstName + ' ' + LastName as 'Nombre completo'
from	Person.Person
where   LastName='johnson'
order by 1



--7. mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo 
--o cuyo precio sea mayor a 500$ de color negro
select		*
from		[Production].[Product]
where		ListPrice < 150 and Color = 'red' 
or			ListPrice > 500 and Color = 'black'
order by	ListPrice asc, Color asc

--8. mostrar el codigo, fecha de ingreso y horas de vacaciones de los 
--empleados ingresaron a partir del año 2000 
select	*
from	[HumanResources].[Employee]
where	HireDate > '2000-01-01'

-- Ej 9:
select	*
from	Production.Product
where	SellEndDate < GETDATE()

--10. mostrar todos los porductos cuyo precio de lista este entre 200 y 300 
select *
from   Production.Product
where  (ListPrice) between 200 and 300


--11. mostrar todos los empleados que nacieron entre 1970 y 1985 
select *
from   HumanResources.Employee
where  YEAR(HireDate) between 1970 and 1985


-- 12. mostrar los codigos de venta y producto,cantidad de venta y precio unitario de los articulos 750,753 y 770
SELECT SalesOrderID, OrderQty, ProductID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE ProductID IN (750, 753, 770)

--13. mostrar todos los porductos cuyo color sea verde, blanco y azul 
select	*
from	Production.Product
where	Color in ('white','blue','green')


--14. mostrar el la fecha,nuero de version y subtotal de las ventas efectuadas en los años 2005 y 2006 
select  OrderDate,RevisionNumber,SubTotal
from   Sales.SalesOrderHeader
where  YEAR(OrderDate) in (2005,2006)

-- 15. mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas cuyo precio sea  mayor a 100 pesos
select	Name Nombre, 
		ListPrice Precio, 
		Color
from	Production.Product
where	ListPrice > 100 and Name like '%seat%'

--16. mostrar las bicicletas de montaña que  cuestan entre $1000 y $1200 
select Name,ListPrice
from   Production.Product
where  Name like '%Mountain Bike%' and  ListPrice between 1000 and 1200 
order by 2 


--17. mostrar los nombre de los productos que tengan cualquier combinacion de ‘mountain bike’ 
select  Name
from    Production.Product
where name like '%mountain bike%'
--18. mostrar las personas que su nombre empiece con la letra y 
select FirstName nombre
from   Person.Person
where  FirstName like 'y%'

--19. mostrar las personas que la segunda letra de su apellido es una s 
select LastName apellido
from Person.Person
where  LastName like '_s%'

-- 20. mostrar el nombre concatenado con el apellido de las personas cuyo apellido tengan terminacion española (ez)
select	FirstName + ' ' + LastName as Persona
from	Person.Person
where	LastName like '%ez'


-- 21. mostrar los nombres de los productos que su nombre termine en un numero 
select	Name as Producto
from	Production.Product
where	Name like '%[0-9]'

-- 22. mostrar las personas cuyo  nombre tenga una c o C como primer caracter, cualquier otro como segundo caracter, ni d ni D ni f ni g como tercer caracter, cualquiera entre j y r o entre s y w como cuarto caracter y el resto sin restricciones
select	FirstName Nombre
from	Person.Person
where	FirstName like '[c,C]_[^dDfg][j-w]%'

-- 23. mostrar las personas ordernadas primero por su apellido y luego por su nombre
select		FirstName + '            ' + LastName as Persona 
from		Person.Person
order by	LastName asc, FirstName asc

-- 24. mostrar cinco productos mas caros y su nombre ordenado en forma alfabetica
select	top 5	*
from			Production.Product
order by		ListPrice desc, Name asc

-- 25. mostrar la fecha mas reciente de venta
select	MAX(OrderDate) as 'fecha mas reciente de venta'
from	Sales.SalesOrderHeader


-- 26. mostrar el precio mas barato de todas las bicicletas 
select	MIN(ListPrice) as 'bici mas barata'
from	Production.Product
where	ProductNumber like '%bk%'

-- 27. mostrar la fecha de nacimiento del empleado mas joven 
select	Max(BirthDate) as 'Nacimiento del empleado mas joven'
from	HumanResources.Employee

-- 28. mostrar los representantes de ventas (vendedores) que no tienen definido el numero de territorio
SELECT *
FROM Sales.SalesPerson
WHERE TerritoryID IS NULL


-- 29. mostrar el peso promedio de todos los articulos. si el peso no estuviese definido, reemplazar por cero
select	AVG(ISNULL(Weight, 0)) as 'Peso Promedio'
from	Production.Product

-- 30. mostrar el codigo de subcategoria y el precio del producto mas barato de cada una de ellas 
select		ProductSubcategoryID as Subcategoria,
			MIN(ListPrice) 'Precio mas barato'
from		Production.Product
group by	ProductSubcategoryID


-- 31. mostrar los productos y la cantidad total vendida de cada uno de ellos
select		ProductID as Producto,
			SUM(OrderQty) as 'Total de Ventas'
from		Sales.SalesOrderDetail
group by	ProductID
order by	1

--32. mostrar los productos y la cantidad total vendida de cada uno de ellos, ordenarlos por mayor cantidad de ventas
select   ProductID as producto,
         sum(OrderQty) as 'total de ventas'
from     Sales.SalesOrderDetail
group by ProductID
order by 'total de ventas' desc

-- 33. mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por numero de factura.
select		SalesOrderID as Factura,
			SUM(OrderQty * UnitPrice) as Subtotal
from		Sales.SalesOrderDetail
group by	SalesOrderID
-- order by	1
-- order by	SalesOrderID
order by	Factura

--34. mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por nro de factura  pero solo de aquellas ordenes superen un total de $10.000
select		SalesOrderID as Factura,
			SUM(OrderQty * UnitPrice) as Subtotal
from		Sales.SalesOrderDetail
group by	SalesOrderID
having		SUM(OrderQty * UnitPrice) > 10000
order by	1

--36. mostrar las subcategorias de los productos que tienen dos o mas productos que cuestan menos de $150 
select		ProductSubcategoryID as 'Subcategoria de Producto',
			COUNT(*) as Cantidad
from		Production.Product
where		ListPrice < 150
group by	ProductSubcategoryID
having		COUNT(*) >= 2
order by	2 desc



--37. mostrar todos los codigos de categorias existentes junto con la cantidad de productos y el precio de lista promedio por cada uno de aquellos productos que cuestan mas de $70 y el precio promedio es mayor a $300 
select		ProductSubcategoryID as 'Subcategoria de Producto',
			COUNT(*) as cantidad,
			AVG(ListPrice) as 'Precio Promedio'
from		Production.Product
where		ListPrice > 70
group by	ProductSubcategoryID
having		AVG(ListPrice) > 300
order by	2 desc

--39.mostrar  los empleados que también son vendedores
select		e.*
from		HumanResources.Employee e
inner join	Sales.SalesPerson s
on			e.BusinessEntityID = s.BusinessEntityID

--40. mostrar  los empleados ordenados alfabeticamente por apellido y por nombre 
select		p.LastName + ' ' + p.FirstName as Empleado
from		Person.Person p
inner join	HumanResources.Employee e
on			e.BusinessEntityID = p.BusinessEntityID
order by	1

--41. mostrar el codigo de logueo, numero de territorio y sueldo basico de los vendedores 
select		e.LoginID 'Codigo de Logueo',
			s.TerritoryID 'Numero de Territorio',
			s.Bonus 'Sueldo Basico'
from		HumanResources.Employee e
inner join	Sales.SalesPerson s
on			e.BusinessEntityID = s.BusinessEntityID

--42.mostrar los productos que sean ruedas(subcategoria - Wheels)
select		*
from		Production.Product p
inner join	Production.ProductSubcategory ps
on			p.ProductSubcategoryID = ps.ProductSubcategoryID
where		ps.Name = 'Wheels'

-- 43. mostrar los nombres de los productos que no son bicicletas(subcategoria - bikes) 
select		*
from		Production.Product p
inner join	Production.ProductSubcategory ps
on			p.ProductSubcategoryID = ps.ProductSubcategoryID
where		ps.Name not like '%bikes%'

--44.mostrar los precios de venta de aquellos  productos donde el precio de venta sea inferior al precio de lista recomendado  para ese producto ordenados por nombre de producto
select		p.Name Producto,
			sd.UnitPrice 'Precio Unitario',
			p.ListPrice 'Precio de Lista'
from		Production.Product p
inner join	Sales.SalesOrderDetail sd
on			p.ProductID = sd.ProductID
where		sd.UnitPrice < p.ListPrice
order by	p.Name

--45. Mostrar todos los productos que tengan igual precio. Se deben mostrar de a pares. codigo y nombre de cada uno de los dos productos y el precio de ambos.ordenar por precio en forma descendente 
-- self join
select		p1.Name 'Producto 1', 
			p2.Name 'Producto 2',
			p1.ListPrice 'Precio 1',
			p2.ListPrice 'Precio 2'
from		Production.Product p1
inner join	Production.Product p2
on			p1.ListPrice = p2.ListPrice
where		p1.ProductID > p2.ProductID -- evita duplicados
order by	3 desc

-- 47.mostrar el nombre de los productos y de los proveedores cuya subcategoria es 15 ordenados por nombre de proveedor 


select		p.Name Producto,
			v.Name Proveedor
from		Production.Product p
inner join	Purchasing.ProductVendor pv on p.ProductID = pv.ProductID
inner join	Purchasing.Vendor v on pv.BusinessEntityID = v.BusinessEntityID
where		p.ProductSubcategoryID = 15
order by	v.Name

-- 48.mostrar todas las personas (nombre y apellido) y en el caso que sean empleados mostrar tambien el login id, sino mostrar null 
-- tabla ppal: Person.Person
-- Listar las personas que no son empleados
select			p.FirstName + ' ' + p.LastName 'Nombre Completo'
				-- ,e.LoginID as Login
from			Person.Person p
left outer join	HumanResources.Employee e
on				p.BusinessEntityID = e.BusinessEntityID
where			e.BusinessEntityID is null

-- 49. mostrar los vendedores (nombre y apellido) y el territorio asignado a c/u(identificador y nombre de territorio). En los casos en que un territorio no tiene vendedores mostrar igual los datos del territorio unicamente sin datos de vendedores
-- tabla ppal: SalesTerritory
select				p.FirstName + ' ' + p.LastName Vendedor,
					st.TerritoryID Identidicador,
					st.Name Territorio
from				Sales.SalesPerson sp
right outer join	Sales.SalesTerritory st on st.TerritoryID = sp.TerritoryID
inner join			Person.Person p on p.BusinessEntityID = sp.BusinessEntityID

-- 50.mostrar el producto cartesiano entre la tabla de vendedores cuyo numero de identificacion de negocio sea 280 y el territorio de venta sea el de francia
select		*
from		Sales.SalesPerson sp
cross join	Sales.SalesTerritory st
where		sp.BusinessEntityID = 280 
and			st.Name = 'France'

--51.listar todos las productos cuyo precio sea inferior al precio promedio de todos los productos 
select      * 
FROM        [Production].[Product]
where       ListPrice < (select avg(ListPrice) from [Production].[Product])
ORDER BY    ListPrice DESC

-- promedio de precio de los productos por categoria = 438,6662 USD

--52.listar el nombre, precio de lista, precio promedio y diferencia de precios entre cada producto y el valor promedio general 
SELECT          Name Producto, 
                ListPrice Precio, 
                (select avg(ListPrice) from Production.Product) as Promedio, 
                ListPrice - (select avg(ListPrice) from Production.Product) as Diferencia
FROM            Production.Product
ORDER BY        ListPrice DESC

-- 53. mostrar el o los codigos del producto mas caro 
SELECT      ProductID Codigo, 
            Name Producto,
            ListPrice Precio 
FROM        Production.Product
-- WHERE       ListPrice = (SELECT MAX(ListPrice) FROM Production.Product)
WHERE       ListPrice = 3578.27

-- valor maximo = 3578,27 USD


--54. mostrar el producto mas barato de cada subcategoría. mostrar subcategoria, codigo de producto y el precio de lista mas barato ordenado por subcategoria 
SELECT      psc.Name Subcategoria, 
            p.ProductID Codigo, 
            p.ListPrice Precio
FROM        Production.Product p
INNER JOIN  Production.ProductSubcategory psc 
ON          p.ProductSubcategoryID = psc.ProductSubcategoryID
WHERE       ListPrice = (
                            SELECT  MIN(ListPrice) 
                            FROM    Production.Product p2 
                            WHERE   p2.ProductSubcategoryID = psc.ProductSubcategoryID
                        )
ORDER BY    psc.Name


--55.mostrar los nombres de todos los productos presentes en la subcategoría de ruedas 

-- x join
SELECT      p.Name Producto
FROM        Production.Product p    
INNER JOIN  Production.ProductSubcategory psc 
ON          p.ProductSubcategoryID = psc.ProductSubcategoryID
WHERE       psc.Name = 'Wheels'

--x subconsulta
SELECT      Name Producto
FROM        Production.Product
WHERE       ProductSubcategoryID = (
                                        SELECT  ProductSubcategoryID 
                                        FROM    Production.ProductSubcategory 
                                        WHERE   Name = 'Wheels'
                                    )

--x subconsulta con EXISTS
SELECT      Name Producto
FROM        Production.Product p
WHERE       EXISTS (
                        SELECT  1 
                        FROM    Production.ProductSubcategory psc 
                        WHERE   psc.Name = 'Wheels' 
                                AND psc.ProductSubcategoryID = p.ProductSubcategoryID
                    )



--56.mostrar todos los productos que no fueron vendidos
-- X join
SELECT      p.Name Producto
FROM        Production.Product p
LEFT JOIN   Sales.SalesOrderDetail sod  
ON          p.ProductID = sod.ProductID
WHERE       sod.SalesOrderDetailID IS NULL

-- por subconsulta con exists
SELECT      Name Producto
FROM        Production.Product p
WHERE       NOT EXISTS (
                            SELECT  1 
                            FROM    Sales.SalesOrderDetail sod 
                            WHERE   sod.ProductID = p.ProductID
                        )   


-- 58.mostrar todos los vendedores (nombre y apellido) que no tengan asignado un territorio de ventas 

-- x join
SELECT      p.FirstName + ' ' + p.LastName as Vendedor
FROM        Person.Person p
INNER JOIN  Sales.SalesPerson sp
ON          p.BusinessEntityID = sp.BusinessEntityID
LEFT JOIN   Sales.SalesTerritory st
ON          st.TerritoryID = sp.TerritoryID
WHERE       st.TerritoryID IS NULL

-- por subconsulta con exists
SELECT      p.FirstName + ' ' + p.LastName as Vendedor
FROM        Person.Person p
INNER JOIN  Sales.SalesPerson sp
ON          p.BusinessEntityID = sp.BusinessEntityID
WHERE       NOT EXISTS (
                            SELECT  1 
                            FROM    Sales.SalesTerritory st 
                            WHERE   st.TerritoryID = sp.TerritoryID
                        )

|--59. mostrar las ordenes de venta que se hayan facturado en territorio de estado unidos unicamente 'us' 
-- por join
SELECT      soh.*
FROM        Sales.SalesOrderHeader AS soh
INNER JOIN  Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
WHERE       st.CountryRegionCode = 'US'

-- por subconsulta
SELECT      *
FROM        Sales.SalesOrderHeader 
WHERE       TerritoryID IN (SELECT TerritoryID 
                                FROM Sales.SalesTerritory 
                                WHERE CountryRegionCode = 'US')


-- 60. al ejercicio anterior agregar ordenes de francia e inglaterra
SELECT      *
FROM        Sales.SalesOrderHeader 
WHERE       TerritoryID IN (SELECT TerritoryID 
                                FROM Sales.SalesTerritory 
                                WHERE CountryRegionCode IN ('US', 'FR', 'GB'))

--61.mostrar los nombres de los diez productos mas caros. Utilizr subconsultas con operador IN
SELECT      Name, ListPrice
FROM        Production.Product
WHERE       ListPrice IN (  SELECT TOP 10 ListPrice 
                            FROM Production.Product 
                            ORDER BY ListPrice DESC
                        )

--62.mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o superior a 20 utilizando subconsultas con operador IN
SELECT      Name, ProductID
FROM        Production.Product
WHERE       ProductID IN (  SELECT ProductID
                            FROM Sales.SalesOrderDetail 
                            GROUP BY ProductID 
                            HAVING COUNT(*) >= 20
                        )

--63. listar el nombre y apellido de los empleados que tienen un sueldo basico de 5000 pesos. Utilizar subconsultas con operador IN
SELECT      p.FirstName +' '+ p.LastName as Empleado
FROM        HumanResources.Employee e
INNER JOIN  Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
WHERE       e.BusinessEntityID IN   (   SELECT BusinessEntityID 
                                        FROM Sales.SalesPerson   
                                        WHERE Bonus = 5000
                                    ) 

-- 64.mostrar los nombres de todos los productos de ruedas que fabrica adventure works cycles. Resolver por subconsulta con =any
SELECT Name producto
FROM Production.Product
WHERE ProductSubcategoryID =ANY (	SELECT	ProductSubcategoryID
									FROM	Production.ProductSubcategory
									WHERE	Name = 'Wheels')

--65.mostrar los clientes ubicados en un territorio no cubierto por ningún vendedor
-- por subconsulta con operador <>ALL
SELECT *
FROM Sales.Customer 
-- WHERE TerritoryID NOT IN (SELECT TerritoryID FROM Sales.SalesPerson)
WHERE TerritoryID != ALL (SELECT TerritoryID FROM Sales.SalesPerson) 

--66. listar los productos cuyos precios de venta sean mayores o iguales que el precio de venta máximo de cualquier subcategoría de producto. Por subconsulta con operador >=ANY
SELECT Name producto, ListPrice
FROM Production.Product
WHERE ListPrice >= ANY (SELECT MAX(ListPrice)
						FROM Production.Product
						GROUP BY ProductSubcategoryID)

/*
67.listar el nombre de los productos, el nombre de la subcategoria a la que pertenece junto a su categoría de precio. La categoría de precio se calcula de la siguiente manera. 
	-si el precio está entre 0 y 1000 la categoría es económica.
	-si la categoría está entre 1001 y 2000, normal 
	-y si su valor es mayor a 2000 la categoría es cara.
*/
SELECT      p.Name producto,
            p.ListPrice Precio,
            ps.Name subcategoria,
            (CASE 
                WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
                WHEN ListPrice BETWEEN 1001 AND 2000 THEN 'Normal'
                ELSE 'Cara'
            END) as categoria
FROM        Production.Product p
INNER JOIN  Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
ORDER BY    p.ListPrice DESC


--68.tomando el ejercicio anterior, mostrar unicamente aquellos productos cuya categoria sea "economica"
SELECT  *
FROM    (   SELECT  p.Name producto,
                    p.ListPrice Precio,
                    ps.Name subcategoria,
                    (CASE 
                        WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
                        WHEN ListPrice BETWEEN 1001 AND 2000 THEN 'Normal'
                        ELSE 'Cara'
                    END) as categoria
            FROM        Production.Product p
            INNER JOIN  Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
        ) as subconsulta
WHERE   subconsulta.categoria = 'Economica'

-- insert, update y delete

-- 69.aumentar un 20% el precio de lista de todos los productos  
UPDATE Production.Product
SET ListPrice = ListPrice * 1.2

--70.aumentar un 20% el precio de lista de los productos del proveedor 1540
UPDATE Production.Product
SET ListPrice = ListPrice * 1.2
WHERE ProductID IN (SELECT ProductID 
                    FROM Purchasing.ProductVendor 
                    WHERE BusinessEntityID = 1540)

-- por join
UPDATE p
SET ListPrice = ListPrice * 1.2
FROM Production.Product p
INNER JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
WHERE pv.BusinessEntityID = 1540 


-- 71.agregar un dia de vacaciones a los 10 empleados con mayor antiguedad.
UPDATE  e
SET     VacationHours = VacationHours + 24
FROM    HumanResources.Employee e
WHERE   BusinessEntityID IN     (
                                    SELECT TOP 10   BusinessEntityID 
                                    FROM            HumanResources.Employee 
                                    ORDER BY        HireDate
                                )

--72. eliminar los detalles de compra (purchaseorderdetail) cuyas fechas de vencimiento pertenezcan al tercer trimestre del año 2006
DELETE FROM Purchasing.PurchaseOrderDetail
-- WHERE DueDate BETWEEN '2006-07-01' AND '2006-09-30'
WHERE YEAR(DueDate) = 2006 AND MONTH(DueDate) BETWEEN 7 AND 9

--73.quitar registros de la tabla salespersonquotahistory cuando las ventas del año hasta la fecha almacenadas en la tabla salesperson supere el valor de 2500000
DELETE FROM Sales.SalesPersonQuotaHistory
WHERE       BusinessEntityID IN (
                                    SELECT BusinessEntityID 
                                    FROM Sales.SalesPerson 
                                    WHERE SalesYTD > 2500000
                                )

-- 74. clonar estructura y datos de los campos nombre ,color y precio de lista de la tabla production.product en una tabla llamada productos
 

SELECT Name, Color, ListPrice
INTO 	productos
FROM	Production.product

select * from productos

-- 75. clonar solo estructura de los campos identificador ,nombre y apellido de la tabla person.person en una tabla llamada personas 
SELECT BusinessEntityID, FirstName, LastName
INTO 	personas	
FROM	person.Person
WHERE 	1=2

SELECT * FROM personas

--76.insertar un producto dentro de la tabla productos.tener en cuenta los siguientes datos. el color de producto debe ser rojo, el nombre debe ser "bicicleta mountain bike" y el precio de lista debe ser de 4000 pesos.
INSERT INTO productos (Name, Color, ListPrice)
VALUES ('bicicleta mountain bike', 'rojo', 4000)

select * from productos

--77. copiar los registros de la tabla person.person a la tabla personas cuyo identificador este entre 100 y 200
INSERT INTO personas (BusinessEntityID, FirstName, LastName)
SELECT BusinessEntityID, FirstName, LastName
FROM person.Person
WHERE BusinessEntityID BETWEEN 100 AND 200

--78. aumentar en un 15% el precio de los pedales de bicicleta
UPDATE productos
SET ListPrice = ListPrice * 1.15
WHERE Name LIKE '%pedal%'

SELECT * FROM productos
WHERE Name LIKE '%pedal%'

--79. eliminar de las personas cuyo nombre empiecen con la letra m
DELETE FROM personas
WHERE FirstName LIKE 'm%'

SELECT * FROM personas

--80. borrar todo el contenido de la tabla productos
DELETE FROM productos

--81. borrar todo el contenido de la tabla personas sin utilizar la instrucción delete.
TRUNCATE TABLE personas




--82. crear un procedimiento almacenado que dada una determinada inicial ,devuelva codigo, nombre,apellido y direccion de correo de los empleados cuyo nombre coincida con la inicial ingresada
create procedure informarEmpleadosPorInicial
(@inicial char(1))
as 
  begin 
       select   BusinessEntityID as codigo,
	            FirstName+' '+ LastName as Empleado,
				EmailAddress as 'correo electronico'
	   from     HumanResources.vEmployee
	   where    FirstName like @inicial + '%'
	   order by FirstName
  end
go

execute informarEmpleadosPorInicial @inicial ='a'
execute informarEmpleadosPorInicial @inicial= 'j'
execute informarEmpleadosPorInicial @inicial= 'm'

--83. crear un procedimiento almacenado que devuelva los productos que lleven de fabricado la cantidad de dias que le pasemos como parametro
create procedure tiempoDeFabricacion (@dias int=1)
as 
  begin
       select name,ProductNumber,DaysToManufacture
	   from   Production.Product
	   where  DaysToManufacture= @dias
  end
go

execute tiempoDeFabricacion @dias=2
execute tiempoDeFabricacion @dias=4
execute tiempoDeFabricacion @dias=5
execute tiempoDeFabricacion 

--84. crear un procedimiento almacenado que permita actualizar y ver los precios de un determinado 
--producto que reciba como parametro
create procedure actualizarPrecio(@cantidad as float , @codigo as int)
as 
  begin 
       update Production.Product
	   set ListPrice=ListPrice * @cantidad
	   where ProductID=@codigo

       select Name,ListPrice
	   from  Production.Product
	   where ProductID=@codigo
   end
go
select ListPrice from Production.Product
where ProductID=886 --404.104
execute actualizarPrecio 1.1, 886 --440.1144

--85. armar un procedimineto almacenado que devuelva los proveedores que proporcionan el producto 
--especificado por parametro.
create procedure proveedores (@producto varchar(30)='%')
as
  select     v.name proveedor,
             p.Name producto
  from       Purchasing.Vendor as v
  inner join Purchasing.ProductVendor as pv
  on         v.BusinessEntityID =pv.BusinessEntityID
  inner join Production.Product as p
  on         pv.ProductID=p.ProductID
  where      p.Name like @producto
  order by   v.Name
go

execute proveedores 'r%'
go
execute proveedores 'reflector'
go
execute proveedores

--86. crear un procedimiento almacenado que devuelva nombre,apellido y sector del empleado que le 
--pasemos como argumento.no es necesario pasar el nombre y apellido exactos al procedimiento.
create procedure  empleados 
   @apellido nvarchar (50)='%',
   @nombre nvarchar (50)='%'
as
  select  FirstName,LastName,Department
  from    HumanResources.vEmployeeDepartmentHistory
  where   FirstName like @nombre and LastName like @apellido 
go

execute empleados 'eric%'
go 
execute empleados

--funciones escalares

--87.armar una funcion que devuelva los productos que estan por encima del promedio de precios general
create function promedio()
returns money
as
begin declare @promedio money
      select  @promedio = AVG (ListPrice) from Production.Product
	  return  @promedio
end

--uso de la funcion
select * 
from   Production.Product
where  ListPrice>dbo.promedio()

select AVG(ListPrice) from Production.Product --526,4788

-- 88
create function ventasProductos (@codigoProducto int)
returns int
as 
  begin
     declare @total int
	 select @total=sum (OrderQty)
	 from Sales.SalesOrderDetail where ProductID=@codigoProducto
	 if(@total is null)
	   set @total=0
     return @total
  end

--uso de la funcion
select ProductID 'codigo producto',
       Name 'nombre',
	   dbo.ventasProductos(ProductID) as 'total de ventas'
from Production.Product
order by 3 desc

-- 89.armar una función que dado un año , devuelva nombre y  apellido de los empleados 
--que ingresaron ese año 
create function añoIngresoEmpleados (@año int)
returns table
as 
   return
   (
     select FirstName, LastName,HireDate
     from Person.Person p
     inner join HumanResources.Employee e
     on e.BusinessEntityID=p.BusinessEntityID
     where year (HireDate)=@año
    )
--uso de la funcion
select *from dbo.añoIngresoEmpleados(2004) --45
select*from dbo.añoIngresoEmpleados(2000)  --1

--90.armar una función que dado el codigo de negocio cliente de la fabrica, devuelva el codigo, nombre y las ventas del año hasta la fecha para cada producto vendido en el negocio ordenadas por esta ultima columna. 
create function ventasNegocio (@codNegocio int)
returns table
as 
return
(  
    select   P.ProductID,  P.Name, SUM(SD.lineTotal) as 'total'
	from     Production.Product as P
	join     Sales.SalesOrderDetail as SD on SD.ProductID=P.ProductID
	join     Sales.SalesOrderHeader as SH on SH.SalesOrderID=SD.SalesOrderID
	join     Sales.Customer as C on SH.CustomerID=C.CustomerID
	where    C.StoreID=@codNegocio
	group by P.ProductID,P.Name
)
--uso de la funcion
select   *
from     dbo.ventasNegocio (1340)
order by 3 desc;

--funciones de multisentencia
	
--91. crear una  función llmada "ofertas" que reciba un parámetro correspondiente a un precio y nos retorne una tabla 
--con código,nombre, color y precio de todos los productos cuyo precio sea inferior al parámetro ingresado
create function ofertas(@minimo decimal(6,2))
returns @oferta table
(codigo int,
nombre varchar(40),
color varchar(30),
precio decimal(6,2)
)
as
    begin
	   insert  @oferta
	   select  ProductID,Name,Color,ListPrice
	   from    Production.Product
	   where   ListPrice<@minimo
	    return
    end 
--uso de la funcion
select *
from   dbo.ofertas(5)

--datetime
--92. mostrar la cantidad de horas que transcurrieron desde el comienzo del año
select DATEDIFF(HOUR,'01-02-2026',GETDATE())

--93. mostrar la cantidad de dias transcurridos entre la primer y la ultima venta 

select DATEDIFF(DAY,(select min(OrderDate)FROM sales.SalesOrderHeader),
                    (select MAX(OrderDate) from Sales.SalesOrderHeader))