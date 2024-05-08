USE AdventureWorks2019;

-- 7b 1:
-- Napisz procedurê wypisuj¹c¹ do konsoli ci¹g Fibonacciego. Procedura musi przyjmowaæ jako argument wejœciowy liczbê n. 
-- Generowanie ci¹gu Fibonacciego musi zostaæ zaimplementowane jako osobna funkcja, wywo³ywana przez procedurê.

CREATE OR ALTER FUNCTION fibonacci (@n INT)
RETURNS @tablica TABLE (wynik INT)
AS
BEGIN
    DECLARE @a INT = 0, @b INT = 1, @c INT, @i INT = 2;

	SET @n = @n + 1; -- modyfikacja indeksowania - naturalniejsze dla mnie - wynikiem bêdzie ci¹g dla wyrazów do n w³¹cznie
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

EXEC pokazFibonacci 10; -- wywo³anie dla liczby 10 - wszystkie wwyniki dla liczb do 10 w³¹cznie, indeks w kolumnie po lewej NIE jest równy liczbie, do której ci¹g jest generowany

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 7b 2:
-- Napisz trigger DML, który po wprowadzeniu danych do tabeli Person zmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami.

DROP TRIGGER TriggerDuzeLitery; -- ale i tak nie zadzia³a, bo nie mamy uprawnieñ administratora
DISABLE TRIGGER TriggerDuzeLitery ON Person.Person; -- to stary trigger, w którym zrobi³am b³¹d

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

-- gdybyœmy chcieli zmodyfikowaæ WSZYSTKIE nazwiska, przy wprowadzeniu jakichkolwiek zmian, trigger wygl¹da³by tak:
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
-- Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu ‘TaxRate’ o wiêcej ni¿ 30%.

SELECT * FROM Sales.SalesTaxRate;

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 -- w po³¹czeniu z IF EXISTS - wykona trigger tylko je¿eli jakieœ wiersze spe³ni¹ warunek (1 = TRUE)
        FROM inserted i
        INNER JOIN deleted d ON i.SalesTaxRateID = d.SalesTaxRateID
        WHERE ABS(i.TaxRate - d.TaxRate) / NULLIF(d.TaxRate, 0) > 0.3 -- NULLIF zapobiegnie dzieleniu przez 0
    )
    BEGIN
        PRINT 'Zmiana wartoœci w polu TaxRate jest wiêksza ni¿ 30%!';
    END
END;

UPDATE Sales.SalesTaxRate
SET TaxRate = 20.0
WHERE SalesTaxRateID = 2;