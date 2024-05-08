USE AdventureWorks2019;

-- 7b 1:
-- Napisz procedure wypisujaca do konsoli ciag Fibonacciego. Procedura musi przyjmowac jako argument wejsciowy liczbe n. 
-- Generowanie ciagu Fibonacciego musi zostac zaimplementowane jako osobna funkcja, wywolywana przez procedure.

CREATE OR ALTER FUNCTION fibonacci (@n INT)
RETURNS @tablica TABLE (wynik INT)
AS
BEGIN
    DECLARE @a INT = 0, @b INT = 1, @c INT, @i INT = 2;

	SET @n = @n + 1; -- modyfikacja indeksowania - naturalniejsze dla mnie - wynikiem bedzie ciag dla wyrazów do n wlacznie
    IF @n > 0
    BEGIN
        INSERT INTO @tablica VALUES (@a);

        IF @n > 1
        BEGIN
            INSERT INTO @tablica VALUES (@b);
            
			WHILE @i < @n
            BEGIN
                SET @c = @a + @b;
                INSERT INTO @tablica VALUES (@c);
                SET @a = @b;
                SET @b = @c;
                SET @i = @i + 1;
            END
        END
    END

    RETURN;
END;

GO

CREATE OR ALTER PROCEDURE pokazFibonacci (@n INT)
AS
BEGIN
    SELECT wynik FROM dbo.fibonacci(@n);
END;

GO

EXEC pokazFibonacci 10; -- wywolanie dla liczby 10 - wszystkie wwyniki dla liczb do 10 wlacznie, indeks w kolumnie po lewej NIE jest równy liczbie, do której ciag jest generowany

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 7b 2:
-- Napisz trigger DML, który po wprowadzeniu danych do tabeli Person zmodyfikuje nazwisko tak, aby bylo napisane duzymi literami.

DROP TRIGGER TriggerDuzeLitery; -- ale i tak nie zadziala, bo nie mamy uprawnieñ administratora
DISABLE TRIGGER TriggerDuzeLitery ON Person.Person; -- to stary trigger, w którym zrobilam blad

CREATE TRIGGER TriggerWielkieLitery
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE p
	SET p.LastName = UPPER(i.LastName) -- zmodyfikuje tylko to nazwisko, dla którego modyfikujemy lub wprowadzamy dane
	FROM Person.Person p
	INNER JOIN inserted i
	ON p.BusinessEntityID = i.BusinessEntityID;
END;

-- gdybysmy chcieli zmodyfikowac WSZYSTKIE nazwiska, przy wprowadzeniu jakichkolwiek zmian, trigger wygladalby tak:
--CREATE TRIGGER TriggerWielkieLitery
--ON Person.Person
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    -- Aktualizowanie wszystkich rekordów w tabeli
--    UPDATE Person.Person
--    SET LastName = UPPER(LastName);
--END;

-- sprawdzamy czy trigger istnieje:
SELECT * FROM sys.triggers
WHERE name = 'TriggerWielkieLitery';

SELECT * FROM Person.Person;

UPDATE Person.Person
SET LastName = 'Dóffy'
WHERE BusinessEntityID = 2;

UPDATE Person.Person
SET FirstName = 'Keen'
WHERE BusinessEntityID = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 7b 3:
-- Przygotuj trigger ‘taxRateMonitoring’, który wyswietli komunikat o bledzie, jezeli nastapi zmiana wartosci w polu ‘TaxRate’ o wiecej niz 30%.

SELECT * FROM Sales.SalesTaxRate;

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 -- w polaczeniu z IF EXISTS - wykona trigger tylko jezeli jakies wiersze spelnia warunek (1 = TRUE)
        FROM inserted i
        INNER JOIN deleted d ON i.SalesTaxRateID = d.SalesTaxRateID
        WHERE ABS(i.TaxRate - d.TaxRate) / NULLIF(d.TaxRate, 0) > 0.3 -- NULLIF zapobiegnie dzieleniu przez 0
    )
    BEGIN
        PRINT 'Zmiana wartosci w polu TaxRate jest wieksza niz 30%!';
    END
END;

UPDATE Sales.SalesTaxRate
SET TaxRate = 20.0
WHERE SalesTaxRateID = 2;