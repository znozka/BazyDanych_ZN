USE AdventureWorks2019;

-- Zadanie 4:
-- Napisz zapytanie, kt�re zaczyna transakcj� i aktualizuje StandardCost wszystkich produkt�w w tabeli Production.Product o 10%, 
-- je�eli suma wszystkich StandardCost po aktualizacji nie przekracza 50 000. W przeciwnym razie zapytanie powinno wycofa� transakcj�.

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
		-- Je�li suma nie przekracza 50 000, zatwierd� transakcj�
		COMMIT;
		PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST (@TotalStandardCost AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		-- Je�li suma przekracza 50 000, wycofaj transakcj�
		ROLLBACK;
		PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50000. Aktualna suma: ' + CAST (@TotalStandardCost AS NVARCHAR(50));
	END
END TRY
BEGIN CATCH
	-- Je�li wyst�pi b��d, wycofaj transakcj� i wy�wietl komunikat o b��dzie 
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
	-- Je�li suma nie przekracza 50000, zatwierd� transakcj�
	COMMIT;
	PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST (@TotalStandardCost AS NVARCHAR(50));
END
ELSE
BEGIN
	-- Je�li suma przekracza 50000, wycofaj transakcj� ROLLBACK;
	ROLLBACK
	PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50 000. Aktualna suma: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
END

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 1:

-- Napisz zapytanie, kt�re wykorzystuje transakcj� (zaczyna j�), a nast�pnie aktualizuje cen� produktu 
-- o ProductID r�wnym 680 w tabeli Production.Product o 10% i nast�pnie zatwierdza transakcj�.
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
-- Napisz zapytanie, kt�re zaczyna transakcj�, usuwa produkt o ProductID r�wnym 707 z tabeli Production.Product, ale nast�pnie wycofuje transakcj�.
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
-- Napisz zapytanie, kt�re zaczyna transakcj�, dodaje nowy produkt do tabeli Production.Product, a nast�pnie zatwierdza transakcj�.
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
-- Napisz zapytanie SQL, kt�re zaczyna transakcj� i pr�buje doda� nowy produkt do tabeli Production.Product. 
-- Je�li ProductNumber ju� istnieje w tabeli, zapytanie powinno wycofa� transakcj�.
BEGIN TRANSACTION;

BEGIN TRY
	IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'NP-002')
	BEGIN
	PRINT 'Transakcja wycofana. Produkt o podanym numerze ju� istnieje.';
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
-- Napisz zapytanie SQL, kt�re zaczyna transakcj� i aktualizuje warto�� OrderQty dla ka�dego zam�wienia w tabeli Sales.SalesOrderDetail.
-- Je�eli kt�rykolwiek z zam�wie� ma OrderQty r�wn� 0, zapytanie powinno wycofa� transakcj�.
BEGIN TRANSACTION;

BEGIN TRY
	IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		ROLLBACK;
		PRINT 'Transakcja wycofana. Co najmniej jedno z zam�wie� ma OrderQty r�wne 0.';
		END
	ELSE
	BEGIN
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty + 1;	
		-- SET OrderQty = OrderQty - 1;

		COMMIT;
		PRINT 'Transakcja zatwierdzona. Warto�ci OrderQty zosta�y zaktualizowane.';
	END
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * FROM Sales.SalesOrderDetail;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Zadanie 7:
-- Napisz zapytanie SQL, kt�re zaczyna transakcj� i usuwa wszystkie produkty, kt�rych StandardCost jest wy�szy ni� �redni koszt wszystkich produkt�w 
-- w tabeli Production.Product. Je�eli liczba produkt�w do usuni�cia przekracza 10, zapytanie powinno wycofa� transakcj�.
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
		PRINT 'Transakcja zatwierdzona. Suma usuni�tych produkt�w: ' + CAST(@ProductCount AS NVARCHAR(50));
	END
	ELSE
	BEGIN
		ROLLBACK;
		PRINT 'Transakcja wycofana. Suma produkt�w do usuni�cia: ' + CAST (@ProductCount AS NVARCHAR(50));
	END
END TRY
BEGIN CATCH
	ROLLBACK;
	SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;