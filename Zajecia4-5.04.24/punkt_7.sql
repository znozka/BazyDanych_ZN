-- punkt 7:
USE firma;

--ALTER TABLE rozliczenia.pensje ADD kwota_netto INTEGER NOT NULL;

--UPDATE rozliczenia.pensje SET kwota_netto = kwota * 0.77;

--EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

SELECT *FROM rozliczenia.pensje;
SELECT *FROM rozliczenia.godziny;
SELECT *FROM rozliczenia.pracownicy;
SELECT *FROM rozliczenia.premie;