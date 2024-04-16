-- punkt 2:
USE firma;

CREATE SCHEMA ksiegowosc;

-- punkt 4:
CREATE TABLE ksiegowosc.pracownicy (
id_pracownika INTEGER NOT NULL PRIMARY KEY,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
adres VARCHAR(50),
telefon INTEGER
);

CREATE TABLE ksiegowosc.godziny (
id_godziny INTEGER NOT NULL PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin INTEGER NOT NULL,
id_pracownika INTEGER,
FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);

CREATE TABLE ksiegowosc.pensja (
id_pensji INTEGER NOT NULL PRIMARY KEY,
stanowisko VARCHAR(50),
kwota FLOAT NOT NULL,
id_premii INTEGER NOT NULL,
FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
);

CREATE TABLE ksiegowosc.premia (
id_premii INTEGER NOT NULL PRIMARY KEY,
rodzaj VARCHAR(50),
kwota FLOAT NOT NULL
);

CREATE TABLE ksiegowosc.wynagrodzenie (
id_wynagrodzenia INTEGER NOT NULL PRIMARY KEY,
data DATE NOT NULL,
id_pracownika INTEGER NOT NULL,
id_godziny INTEGER NOT NULL,
id_pensji INTEGER NOT NULL,
id_premii INTEGER NOT NULL,
FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika),
FOREIGN KEY (id_godziny) REFERENCES rozliczenia.godziny(id_godziny),
FOREIGN KEY (id_pensji) REFERENCES rozliczenia.pensje(id_pensji),
FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii)
);

-- komentarze: ppm na tabelê > properties > extended properties

-- punkt 5:
INSERT INTO ksiegowosc.pracownicy VALUES
(1, 'Jan', 'Kowalski', 'ul. Kwiatowa 1, Warszawa', '123456789'),
(2, 'Anna', 'Nowak', 'ul. S³oneczna 5, Kraków', '987654321'),
(3, 'Piotr', 'Nowakowski', 'ul. Wiejska 10, Gdañsk', '555111222'),
(4, 'Maria', 'Wiœniewska', 'ul. Leœna 8, Poznañ', '999888777'),
(5, 'Andrzej', 'Kowalczyk', 'ul. Rycerska 3, Wroc³aw', '333444555'),
(6, 'Magdalena', 'Lis', 'ul. Ogrodowa 7, £ódŸ', '666777888'),
(7, 'Katarzyna', 'Wójcik', 'ul. Kwiatowa 2, Warszawa', '111222333'),
(8, 'Tomasz', 'Duda', 'ul. Polna 6, Kraków', '222333444'),
(9, 'Marcin', 'Kamiñski', 'ul. Miodowa 4, Gdañsk', '444555666'),
(10, 'Alicja', 'Zieliñska', 'ul. Lipowa 9, Poznañ', '777888999');

INSERT INTO ksiegowosc.godziny VALUES
(1, '2024-04-01', 160, 1),
(2, '2024-04-02', 180, 2),
(3, '2024-04-03', 200, 3),
(4, '2024-04-04', 150, 4),
(5, '2024-04-05', 140, 5),
(6, '2024-04-06', 190, 6),
(7, '2024-04-07', 170, 7),
(8, '2024-04-08', 160, 8),
(9, '2024-04-09', 160, 9),
(10, '2024-04-10', 180, 10);

INSERT INTO ksiegowosc.pensja VALUES
(1, 'Specjalista', 5000, 1),
(2, 'Asystent', 3500, 2),
(3, 'Kierownik', 7000, 3),
(4, 'Technik', 4000, 4),
(5, 'Administrator', 4500, 5),
(6, 'Analityk', 5500, 6),
(7, 'Pracownik fizyczny', 3000, 7),
(8, 'Dyrektor', 10000, 8),
(9, 'Sekretarka', 3200, 9),
(10, 'Programista', 6000, 10);

INSERT INTO ksiegowosc.premia VALUES
(1, 'Za wyniki', 1000),
(2, 'Motywacyjna', 500),
(3, 'Sta¿owa', 300),
(4, 'Specjalna', 1500),
(5, 'Œwi¹teczna', 700),
(6, 'Roczna', 2000),
(7, 'Wakacyjna', 800),
(8, 'Dodatkowa', 1200),
(9, 'Jubileuszowa', 2500),
(10, 'Premia specjalna', 1800);

INSERT INTO ksiegowosc.wynagrodzenie VALUES
(1, '2024-04-01', 1, 1, 1, 1),
(2, '2024-04-02', 2, 2, 2, 2),
(3, '2024-04-03', 3, 3, 3, 3),
(4, '2024-04-04', 4, 4, 4, 4),
(5, '2024-04-05', 5, 5, 5, 5),
(6, '2024-04-06', 6, 6, 6, 6),
(7, '2024-04-07', 7, 7, 7, 7),
(8, '2024-04-08', 8, 8, 8, 8),
(9, '2024-04-09', 9, 9, 9, 9),
(10, '2024-04-10', 10, 10, 10, 10);

-- 6a:
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- 6b:
SELECT id_pracownika FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.pensja 
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensja.id_pensji 
WHERE (ksiegowosc.pensja.kwota > 1000);

-- 6c:
SELECT id_pracownika FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.pensja
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia 
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.premia.id_premii
WHERE (ksiegowosc.pensja.kwota > 2000) AND (ksiegowosc.premia.kwota = 0);

-- 6d:
SELECT * FROM ksiegowosc.pracownicy 
WHERE (ksiegowosc.pracownicy.imie LIKE 'J%');

-- 6e:
SELECT * FROM ksiegowosc.pracownicy 
WHERE (ksiegowosc.pracownicy.nazwisko LIKE '%n%') AND (ksiegowosc.pracownicy.imie LIKE '%a');

-- 6f:
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.godziny.liczba_godzin
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
WHERE (ksiegowosc.godziny.liczba_godzin > 160);

-- 6g:
SELECT imie, nazwisko FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.pensja
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensja.id_pensji
WHERE (ksiegowosc.pensja.kwota >= 1500) AND (ksiegowosc.pensja.kwota <= 3000);

-- 6h:
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
JOIN ksiegowosc.pensja
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensja.id_pensji
WHERE (ksiegowosc.godziny.liczba_godzin > 160) AND (ksiegowosc.pensja.kwota < 1200);

-- 6i:
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.stanowisko, ksiegowosc.pensja.kwota 
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensja
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensja.id_pensji
ORDER BY ksiegowosc.pensja.kwota;

-- 6j:
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensja.stanowisko, ksiegowosc.pensja.kwota AS kwota_pensji, ksiegowosc.premia.kwota AS kwota_premii
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensja
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensja.id_pensji
JOIN ksiegowosc.premia 
ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.premia.id_premii
ORDER BY ksiegowosc.pensja.kwota, ksiegowosc.premia.kwota DESC;