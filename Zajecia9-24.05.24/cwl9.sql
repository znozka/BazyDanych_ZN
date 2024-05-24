USE AdventureWorks2019;

-- Zadanie 4:
-- Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost wszystkich produktów w tabeli Production.Product o 10%, 
-- je¿eli suma wszystkich StandardCost po aktualizacji nie przekracza 50 000. W przeciwnym razie zapytanie powinno wycofaæ transakcjê.

-- PRZYKLAD 1:
BEGIN TRANSACTION;

BEGIN TRY
	-- Aktualizacja StandardCost o 10%
	UPDATE Production.Product
	SET StandardCost = StandardCost * 1.10;

	-- Sprawdzenie, czy suma StandardCost po aktualizacji nie przekracza 50 000
	DECLARE @TotalStandardCost MONEY;
	SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;

	IF @TotalStandardCost <= 50000
	BEGIN
		-- Jeœli suma nie przekracza 50 000, zatwierdŸ transakcjê
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST (@TotalStandardCost AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		-- Jeœli suma przekracza 50 000, wycofaj transakcjê
		ROLLBACK;
		PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50000. Aktualna suma: ' + CAST (@TotalStandardCost AS NVARCHAR(50));
	END
END TRY
BEGIN CATCH
	-- Jeœli wyst¹pi b³¹d, wycofaj transakcjê i wyœwietl komunikat o b³êdzie 
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- PRZYKLAD 2:
BEGIN TRANSACTION;
-- Aktualizacja StandardCost o 10%
UPDATE Production.Product
SET StandardCost = StandardCost * 1.10;

-- Sprawdzenie, czy suma StandardCost po aktualizacji nie przekracza 50 000 
DECLARE @TotalStandardCost MONEY;
SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;

IF @TotalStandardCost <= 50000
BEGIN
	-- Jeœli suma nie przekracza 50000, zatwierdŸ transakcjê
	COMMIT;
	PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST (@TotalStandardCost AS NVARCHAR(50));
END
ELSE
BEGIN
	-- Jeœli suma przekracza 50000, wycofaj transakcjê ROLLBACK;
	ROLLBACK
	PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50 000. Aktualna suma: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
END

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 1:

-- Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), a nastêpnie aktualizuje cenê produktu 
-- o ProductID równym 680 w tabeli Production.Product o 10% i nastêpnie zatwierdza transakcjê.
BEGIN TRANSACTION;

BEGIN TRY
	UPDATE Production.Product
	SET ListPrice = ListPrice * 1.10
	WHERE ProductID = 680;

    DECLARE @UpdatedPrice MONEY;
    SELECT @UpdatedPrice = CAST(ListPrice AS NVARCHAR(50)) FROM Production.Product WHERE ProductID = 680;

	COMMIT;
	PRINT 'Transakcja zatwierdzona. Cena wynosi: ' + @UpdatedPrice;
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 2:
-- Napisz zapytanie, które zaczyna transakcjê, usuwa produkt o ProductID równym 707 z tabeli Production.Product, ale nastêpnie wycofuje transakcjê.
BEGIN TRANSACTION;

BEGIN TRY
	DELETE FROM Production.Product
	WHERE ProductID = 707;

	ROLLBACK;
	PRINT 'Transakcja wycofana';
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 3:
-- Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli Production.Product, a nastêpnie zatwierdza transakcjê.
BEGIN TRANSACTION;

BEGIN TRY
	INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, rowguid, ModifiedDate)
	VALUES ('New Product', 'NP-001', 1, 1, NULL, 100, 750, 0.00, 0.00, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, GETDATE(), NEWID(), GETDATE());

    DECLARE @NewProduct NVARCHAR(50);
    SELECT @NewProduct = Name FROM Production.Product WHERE ProductNumber = 'NP-001';

	COMMIT;
	PRINT 'Transakcja zatwierdzona. Nazwa nowego produktu to: ' + @NewProduct;
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

DELETE FROM Production.Product WHERE ProductNumber = 'NP-001';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 5:
-- Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt do tabeli Production.Product. 
-- Jeœli ProductNumber ju¿ istnieje w tabeli, zapytanie powinno wycofaæ transakcjê.
BEGIN TRANSACTION;

BEGIN TRY
	IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'NP-002')
	BEGIN
	PRINT 'Transakcja wycofana. Produkt o podanym numerze ju¿ istnieje.';
		ROLLBACK;
		END
	ELSE
	BEGIN
		INSERT INTO Production.Product (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, rowguid, ModifiedDate)
		VALUES ('New Product 2', 'NP-002', 2, 2, NULL, 102, 752, 0.50, 0.50, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, GETDATE(), NEWID(), GETDATE());
			
		DECLARE @ProductNumber NVARCHAR(50);
		SELECT @ProductNumber = ProductNumber FROM Production.Product WHERE Name = 'New Product 2';

		COMMIT;
		PRINT 'Transakcja zatwierdzona. Dodano produkt o numerze: ' + @ProductNumber;
	END
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

DELETE FROM Production.Product WHERE ProductNumber = 'NP-002';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 6:
-- Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ OrderQty dla ka¿dego zamówienia w tabeli Sales.SalesOrderDetail.
-- Je¿eli którykolwiek z zamówieñ ma OrderQty równ¹ 0, zapytanie powinno wycofaæ transakcjê.
BEGIN TRANSACTION;

BEGIN TRY
	IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		ROLLBACK;
		PRINT 'Transakcja wycofana. Co najmniej jedno z zamówieñ ma OrderQty równe 0.';
		END
	ELSE
	BEGIN
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty + 1;	
		-- SET OrderQty = OrderQty - 1;

		COMMIT;
		PRINT 'Transakcja zatwierdzona. Wartoœci OrderQty zosta³y zaktualizowane.';
	END
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * FROM Sales.SalesOrderDetail;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 7:
-- Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty, których StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów 
-- w tabeli Production.Product. Je¿eli liczba produktów do usuniêcia przekracza 10, zapytanie powinno wycofaæ transakcjê.
BEGIN TRANSACTION;

DECLARE @AvgCost MONEY;
DECLARE @ProductCount INT;

SELECT @AvgCost = AVG(StandardCost) FROM Production.Product;
SELECT @ProductCount = COUNT (*) FROM Production.Product WHERE StandardCost > @AvgCost;

BEGIN TRY
	DELETE FROM Production.Product
	WHERE StandardCost > @AvgCost;

	IF @ProductCount <= 10
	BEGIN
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma usuniêtych produktów: ' + CAST(@ProductCount AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		ROLLBACK;
		PRINT 'Transakcja wycofana. Suma produktów do usuniêcia: ' + CAST (@ProductCount AS NVARCHAR(50));
	END
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;