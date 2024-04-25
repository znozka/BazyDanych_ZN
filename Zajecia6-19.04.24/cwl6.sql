USE firma;

-- 6k:
UPDATE ksiegowosc.pensja
SET stanowisko = 'Programista'
WHERE stanowisko = 'Specjalista';

SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.pensja
GROUP BY stanowisko;

-- 6l:
SELECT 
	AVG(kwota) AS srednia_placa,
	MIN(kwota) AS minimalna_placa,
	MAX(kwota) AS maksymalna_placa
FROM ksiegowosc.pensja
WHERE stanowisko = 'Programista';

-- 6m:
SELECT SUM(pen.kwota) + SUM(pre.kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja pen
LEFT JOIN ksiegowosc.wynagrodzenie wyn ON wyn.id_pensji = pen.id_pensji
LEFT JOIN ksiegowosc.premia pre ON wyn.id_premii = pre.id_premii;

-- 6n/f:
SELECT pen.stanowisko, SUM(pre.kwota + pen.kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja pen
INNER JOIN ksiegowosc.wynagrodzenie wyn ON pen.id_pensji = wyn.id_pensji
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = wyn.id_pracownika
INNER JOIN ksiegowosc.premia pre ON pre.id_premii = wyn.id_premii
GROUP BY pen.stanowisko

-- 6o/g:
SELECT stanowisko, COUNT(*) AS liczba_premii
FROM ksiegowosc.pensja pen
LEFT JOIN ksiegowosc.wynagrodzenie wyn ON wyn.id_pensji = pen.id_pensji
LEFT JOIN ksiegowosc.premia pre ON pen.id_premii = pre.id_premii
GROUP BY pen.stanowisko;

-- 6p/h:
UPDATE ksiegowosc.pensja
SET kwota = 1000
WHERE kwota = 3500;

DELETE pra FROM ksiegowosc.pracownicy pra
JOIN ksiegowosc.wynagrodzenie wyn ON pra.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.pensja pen ON wyn.id_pensji = pen.id_pensji
WHERE pen.kwota < 1200;

SELECT * FROM ksiegowosc.pracownicy;
SELECT * FROM ksiegowosc.pensja;


-- ZESTAW 6b:
-- a:
ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon VARCHAR(15); -- 9 cyfr numeru + 5 dodanych + spacja

UPDATE ksiegowosc.pracownicy
SET telefon = '(+48) ' + telefon;

-- b:
ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon VARCHAR(18);

UPDATE ksiegowosc.pracownicy
SET telefon = '(+48) ' + SUBSTRING(telefon, 1, 3) + '-' + SUBSTRING(telefon, 4, 3) + '-' + SUBSTRING(telefon, 7, 3);

SELECT * FROM ksiegowosc.pracownicy;

-- c:
SELECT UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, adres, telefon 
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy);

-- d:
SELECT pra.imie, HASHBYTES('MD5', pra.imie) AS imie_md5,
	pra.nazwisko, HASHBYTES('MD5', pra.nazwisko) AS nazwisko_md5,
	pra.telefon, HASHBYTES('MD5', pra.telefon) AS telefon_md5,
	pen.kwota, HASHBYTES('MD5', CAST(pen.kwota AS VARCHAR)) AS pensja_md5
FROM ksiegowosc.pracownicy pra
LEFT JOIN ksiegowosc.wynagrodzenie wyn ON pra.id_pracownika = wyn.id_pracownika
LEFT JOIN ksiegowosc.pensja pen ON pen.id_pensji = wyn.id_pensji;
-- LEFT bo pracownicy moga nie mieæ przypisanych ¿adnych pensji

-- f:
SELECT pra.id_pracownika, pra.imie, pra.nazwisko, pen.stanowisko, pen.kwota AS pensja, pre.rodzaj AS rodzaj_premii, pre.kwota AS premia
FROM ksiegowosc.pracownicy pra
LEFT JOIN ksiegowosc.wynagrodzenie wyn ON pra.id_pracownika = wyn.id_pracownika
LEFT JOIN ksiegowosc.pensja pen ON pen.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia pre ON pre.id_premii = wyn.id_premii;

-- g:
-- Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, gdzie wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³
SELECT 'Pracownik/pracowniczka ' + pra.imie + ' ' + pra.nazwisko 
	+ ', w dniu ' + CONVERT(VARCHAR, wyn.data, 104) -- 104 - format niemiecki (dd.mm.rrrr)
	+ ' otrzyma³/a pensjê ca³kowit¹ na kwotê ' + CONVERT(VARCHAR, SUM(pre.kwota + pen.kwota))
	+ ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ' + CONVERT(VARCHAR, pen.kwota)
	+ ' z³, premia: ' + CONVERT(VARCHAR, pre.kwota)
	+ ' z³, nadgodziny: ' + CONVERT(VARCHAR, (CASE WHEN godz.liczba_godzin > 160 
												THEN (godz.liczba_godzin - 160) 
												ELSE 0 
												END))
	+ ' godzin' AS Raport
FROM ksiegowosc.pracownicy pra
LEFT JOIN ksiegowosc.wynagrodzenie wyn ON pra.id_pracownika = wyn.id_pracownika
LEFT JOIN ksiegowosc.pensja pen ON pen.id_pensji = wyn.id_pensji
LEFT JOIN ksiegowosc.premia pre ON pre.id_premii = wyn.id_premii
LEFT JOIN ksiegowosc.godziny godz ON pra.id_pracownika = godz.id_pracownika
GROUP BY pra.imie, pra.nazwisko, wyn.data, pen.kwota, pre.kwota, godz.liczba_godzin;