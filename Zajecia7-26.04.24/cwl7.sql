USE AdventureWorks2019;

-- 7b 1:
-- Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. Procedura musi przyjmowa� jako argument wej�ciowy liczb� n. 
-- Generowanie ci�gu Fibonacciego musi zosta� zaimplementowane jako osobna funkcja, wywo�ywana przez procedur�.

CREATE OR ALTER FUNCTION fibonacci (@n INT)
RETURNS @tablica TABLE (wynik INT)
AS
BEGIN
    DECLARE @a INT = 0, @b INT = 1, @c INT, @i INT = 2;

	SET @n = @n + 1; -- modyfikacja indeksowania - naturalniejsze dla mnie - wynikiem b�dzie ci�g dla wyraz�w do n w��cznie
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

EXEC pokazFibonacci 10; -- wywo�anie dla liczby 10 - wszystkie wwyniki dla liczb do 10 w��cznie, indeks w kolumnie po lewej NIE jest r�wny liczbie, do kt�rej ci�g jest generowany

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 7b 2:
-- Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Person zmodyfikuje nazwisko tak, aby by�o napisane du�ymi literami.

DROP TRIGGER TriggerDuzeLitery; -- ale i tak nie zadzia�a, bo nie mamy uprawnie� administratora
DISABLE TRIGGER TriggerDuzeLitery ON Person.Person; -- to stary trigger, w kt�rym zrobi�am b��d

CREATE TRIGGER TriggerWielkieLitery
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE p
	SET p.LastName = UPPER(i.LastName) -- zmodyfikuje tylko to nazwisko, dla kt�rego modyfikujemy lub wprowadzamy dane
	FROM Person.Person p
	INNER JOIN inserted i
	ON p.BusinessEntityID = i.BusinessEntityID;
END;

-- gdyby�my chcieli zmodyfikowa� WSZYSTKIE nazwiska, przy wprowadzeniu jakichkolwiek zmian, trigger wygl�da�by tak:
--CREATE TRIGGER TriggerWielkieLitery
--ON Person.Person
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    -- Aktualizowanie wszystkich rekord�w w tabeli
--    UPDATE Person.Person
--    SET LastName = UPPER(LastName);
--END;

-- sprawdzamy czy trigger istnieje:
SELECT * FROM sys.triggers
WHERE name = 'TriggerWielkieLitery';

SELECT * FROM Person.Person;

UPDATE Person.Person
SET LastName = 'D�ffy'
WHERE BusinessEntityID = 2;

UPDATE Person.Person
SET FirstName = 'Keen'
WHERE BusinessEntityID = 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- 7b 3:
-- Przygotuj trigger �taxRateMonitoring�, kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi zmiana warto�ci w polu �TaxRate� o wi�cej ni� 30%.

SELECT * FROM Sales.SalesTaxRate;

CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 -- w po��czeniu z IF EXISTS - wykona trigger tylko je�eli jakie� wiersze spe�ni� warunek (1 = TRUE)
        FROM inserted i
        INNER JOIN deleted d ON i.SalesTaxRateID = d.SalesTaxRateID
        WHERE ABS(i.TaxRate - d.TaxRate) / NULLIF(d.TaxRate, 0) > 0.3 -- NULLIF zapobiegnie dzieleniu przez 0
    )
    BEGIN
        PRINT 'Zmiana warto�ci w polu TaxRate jest wi�ksza ni� 30%!';
    END
END;

UPDATE Sales.SalesTaxRate
SET TaxRate = 20.0
WHERE SalesTaxRateID = 2;