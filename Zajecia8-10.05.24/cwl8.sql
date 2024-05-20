USE AdventureWorks2019;

-- Zadanie 1:
-- Wykorzystuj¹c wyra¿enie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki
-- pracownika oraz jego danych, a nastêpnie zapisze je do tabeli tymczasowej TempEmployeeInfo. 

SELECT p.Rate AS Stawka, e.*
	INTO TempEmployeeInfo
	FROM HumanResources.Employee e
	JOIN HumanResources.EmployeePayHistory p
	ON e.BusinessEntityID = p.BusinessEntityID;

SELECT * FROM TempEmployeeInfo;
DROP TABLE IF EXISTS TempEmployeeInfo;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 2:
-- Uzyskaj informacje na temat przychodów ze sprzeda¿y wed³ug firmy i kontaktu.

WITH KontaktPrzychodCTE AS (
    SELECT s.Name AS NazwaSklepu,
		per.FirstName + ' ' + per.LastName AS ImieNazwisko,
        SUM(soh.TotalDue) AS Przychod
    FROM Sales.Customer c
    JOIN Sales.SalesOrderHeader soh 
		ON c.CustomerID = soh.CustomerID
    LEFT JOIN Sales.Store s -- LEFT - ¿eby by³y wszystkie rekordy z SalesOrderHeader, nawet jeœli nie maj¹ danych w Customer
		ON c.StoreID = s.BusinessEntityID
    LEFT JOIN Sales.SalesPerson sp 
		ON s.SalesPersonID = sp.BusinessEntityID
    LEFT JOIN Person.Person per 
		ON sp.BusinessEntityID = per.BusinessEntityID
    GROUP BY s.Name, per.FirstName, per.LastName
)

SELECT NazwaSklepu + ' (' + ImieNazwisko + ')' AS CompanyContact, Przychod AS Revenue
FROM KontaktPrzychodCTE
ORDER BY CompanyContact;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 3:
-- Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów

WITH ProduktSprzedazCTE AS (
    SELECT pc.Name AS Category,
        SUM(sod.LineTotal) AS SalesValue
    FROM Sales.SalesOrderDetail sod
	JOIN Production.Product p 
		ON sod.ProductID = p.ProductID
    JOIN Production.ProductSubcategory psc 
		ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    JOIN Production.ProductCategory pc 
		ON psc.ProductCategoryID = pc.ProductCategoryID
    GROUP BY 
        pc.Name
)

SELECT Category, SalesValue
FROM ProduktSprzedazCTE
ORDER BY Category;

SELECT * FROM Production.ProductCategory;