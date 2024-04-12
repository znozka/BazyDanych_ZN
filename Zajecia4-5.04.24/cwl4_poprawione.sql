-- punkt 1:
CREATE DATABASE firma;

-- punkt 2:
USE firma;

CREATE SCHEMA rozliczenia;

-- punkt 3 (a-c):
CREATE TABLE rozliczenia.pracownicy (
id_pracownika INTEGER NOT NULL PRIMARY KEY,
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
adres VARCHAR(50),
telefon INTEGER
);

CREATE TABLE rozliczenia.godziny (
id_godziny INTEGER NOT NULL PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin INTEGER NOT NULL,
id_pracownika INTEGER
);

CREATE TABLE rozliczenia.pensje (
id_pensji INTEGER NOT NULL PRIMARY KEY,
stanowisko VARCHAR(50),
kwota FLOAT NOT NULL,
id_premii INTEGER NOT NULL
);

CREATE TABLE rozliczenia.premie (
id_premii INTEGER NOT NULL PRIMARY KEY,
rodzaj VARCHAR(50),
kwota FLOAT NOT NULL
);

-- punkt 3 (d):
ALTER TABLE rozliczenia.pensje ADD CONSTRAINT fk_premia_id FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);
ALTER TABLE rozliczenia.godziny ADD CONSTRAINT fk_pracownik_id FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

-- punkt 4:
INSERT INTO rozliczenia.pracownicy VALUES 
(1, 'Jan', 'Kowalski', 'Magnoliowa 13', 123789456),
(2, 'Anna', 'Nowak', 'Dębowa 7', 987654321),
(3, 'Piotr', 'Wiśniewski', 'Słoneczna 25', 456123789),
(4, 'Maria', 'Dąbrowska', 'Brzozowa 11', 789456123),
(5, 'Krzysztof', 'Lewandowski', 'Polna 3', 321654987),
(6, 'Barbara', 'Wójcik', 'Lipowa 9', 654987321),
(7, 'Andrzej', 'Kamiński', 'Topolowa 15', 987321654),
(8, 'Magdalena', 'Kowalczyk', 'Żurawia 21', 741852963),
(9, 'Tomasz', 'Zieliński', 'Szkolna 8', 852963741),
(10, 'Joanna', 'Woźniak', 'Rzeczna 17', 369258147);

INSERT INTO rozliczenia.godziny VALUES 
(1, '2024-04-01', 8, 1),
(2, '2024-04-02', 7, 2),
(3, '2024-04-03', 6, 3),
(4, '2024-04-04', 8, 1),
(5, '2024-04-05', 9, 2),
(6, '2024-04-06', 7, 3),
(7, '2024-04-07', 8, 1),
(8, '2024-04-08', 6, 2),
(9, '2024-04-09', 7, 3),
(10, '2024-04-10', 8, 1);

INSERT INTO rozliczenia.premie VALUES
(1, 'Premia za wyniki sprzedaży', 1000),
(2, 'Premia roczna', 1500),
(3, 'Premia za osiągnięcie celów', 1200),
(4, 'Premia za staż pracy', 800),
(5, 'Premia za innowacyjne rozwiązania', 2000),
(6, 'Premia za zaangażowanie', 900),
(7, 'Premia za zdobycie nowego klienta', 1300),
(8, 'Premia za efektywność', 1100),
(9, 'Premia za długoletnią współpracę', 1600),
(10, 'Premia za najlepszy projekt roku', 1800);

INSERT INTO rozliczenia.pensje VALUES
(1, 'Specjalista ds. Sprzedaży', 5000, 1),
(2, 'Księgowy', 4500, 2),
(3, 'Programista', 6000, 3),
(4, 'Doradca Klienta', 4200, 10),
(5, 'Administrator Systemów', 5500, 6),
(6, 'Analityk Finansowy', 5800, 5),
(7, 'Specjalista ds. Marketingu', 4800, 4),
(8, 'Project Manager', 6200, 9),
(9, 'Architekt Systemowy', 6700, 8),
(10, 'Specjalista ds. HR', 4900, 7);

-- punkt 5:
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- punkt 6:
SELECT DATEPART(WEEK, data) FROM rozliczenia.godziny;
SELECT DATEPART(MONTH, data) FROM rozliczenia.godziny;

-- punkt 7:
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto FLOAT;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 0.77;

SELECT * FROM rozliczenia.pensje;
SELECT * FROM rozliczenia.godziny;
SELECT * FROM rozliczenia.pracownicy;
SELECT * FROM rozliczenia.premie;