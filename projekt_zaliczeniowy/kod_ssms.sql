CREATE DATABASE projekt;
USE projekt;

-- TWORZENIE TABEL:
CREATE TABLE GeoEon (
    id_eon INT PRIMARY KEY,
    nazwa_eon VARCHAR(50),
);
CREATE TABLE GeoEra (
    id_era INT PRIMARY KEY,
    id_eon INT,
    nazwa_era VARCHAR(50),
    FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon)
);
CREATE TABLE GeoOkres (
    id_okres INT PRIMARY KEY,
    id_era INT,
    nazwa_okres VARCHAR(50),
    FOREIGN KEY (id_era) REFERENCES GeoEra(id_era)
);
CREATE TABLE GeoEpoka (
    id_epoka INT PRIMARY KEY,
    id_okres INT,
    nazwa_epoka VARCHAR(50),
    FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres)
);
CREATE TABLE GeoPietro (
    id_pietro INT PRIMARY KEY,
    id_epoka INT,
    nazwa_pietro VARCHAR(50),
    FOREIGN KEY (id_epoka) REFERENCES GeoEpoka(id_epoka)
);

INSERT INTO GeoEon (id_eon, nazwa_eon) VALUES
	(1, 'FANEROZOIK');
INSERT INTO GeoEra (id_era, id_eon, nazwa_era) VALUES
	(1, 1, 'Kenozoik'),
	(2, 1, 'Mezozoik'),
	(3, 1, 'Paleozoik');
INSERT INTO GeoOkres (id_okres, id_era, nazwa_okres) VALUES
	(1, 1, 'Czwartorzêd'),
	(2, 1, 'Neogen'),
	(3, 1, 'Paleogen'),
	(4, 2, 'Kreda'),
	(5, 2, 'Jura'),
	(6, 2, 'Trias'),
	(7, 3, 'Perm'),
	(8, 3, 'Karbon'),
	(9, 3, 'Dewon');
INSERT INTO GeoEpoka (id_epoka, id_okres, nazwa_epoka) VALUES
	(1, 1, 'Holocen'),
	(2, 1, 'Plejstocen'),
	(3, 2, 'Pliocen'),
	(4, 2, 'Miocen'),
	(5, 3, 'Oligocen'),
	(6, 3, 'Eocen'),
	(7, 3, 'Paleocen'),
	(8, 4, 'Kreda Górna'),
	(9, 4, 'Kreda Dolna'),
	(10, 5, 'Jura Górna'),
	(11, 5, 'Jura Œrodkowa'),
	(12, 5, 'Jura Dolna'),
	(13, 6, 'Trias Górny'),
	(14, 6, 'Trias Œrodkowy'),
	(15, 6, 'Trias Dolny'),
	(16, 7, 'Perm Górny'),
	(17, 7, 'Perm Dolny'),
	(18, 8, 'Karbon Górny'),
	(19, 8, 'Karbon Dolny'),
	(20, 9, 'Dewon Górny'),
	(21, 9, 'Dewon Œrodkowy'),
	(22, 9, 'Dewon Dolny');
INSERT INTO GeoPietro (id_pietro, id_epoka, nazwa_pietro) VALUES
	(1, 3, 'Gelas'),
	(2, 3, 'Piacent'),
	(3, 3, 'Zankl'),
	(4, 4, 'Mesyn'),
	(5, 4, 'Torton'),
	(6, 4, 'Serrawal'),
	(7, 4, 'Lang'),
	(8, 4, 'Burdyga³'),
	(9, 4, 'Akwitan'),
	(10, 5, 'Szat'),
	(11, 5, 'Rupel'),
	(12, 6, 'Priabon'),
	(13, 6, 'Barton'),
	(14, 6, 'Lutet'),
	(15, 6, 'Iprez'),
	(16, 7, 'Tanet'),
	(17, 7, 'Zeland'),
	(18, 7, 'Dan'),
	(19, 8, 'Mastrycht'),
	(20, 8, 'Kampan'),
	(21, 8, 'Santon'),
	(22, 8, 'Koniak'),
	(23, 8, 'Turon'),
	(24, 8, 'Cenoman'),
	(25, 9, 'Alb'),
	(26, 9, 'Apt'),
	(27, 9, 'Barrem'),
	(28, 9, 'Hoteryw'),
	(29, 9, 'Wala¿yn'),
	(30, 9, 'Berias'),
	(31, 10, 'Tyton'),
	(32, 10, 'Kimeryd'),
	(33, 10, 'Oksford'),
	(34, 11, 'Kellowej'),
	(35, 11, 'Baton'),
	(36, 11, 'Bajos'),
	(37, 11, 'Aalen'),
	(38, 12, 'Toark'),
	(39, 12, 'Pliensbach'),
	(40, 12, 'Synemur'),
	(41, 12, 'Hetang'),
	(42, 13, 'Retyk'),
	(43, 13, 'Noryk'),
	(44, 13, 'Karnik'),
	(45, 14, 'Ladyn'),
	(46, 14, 'Anizyk'),
	(47, 15, 'Olenek'),
	(48, 15, 'Ind'),
	(49, 16, 'Tatar'),
	(50, 16, 'Kazañ'),
	(51, 16, 'Ufa'),
	(52, 17, 'Kungur'),
	(53, 17, 'Artinsk'),
	(54, 17, 'Sakmar'),
	(55, 17, 'Assel'),
	(56, 18, 'Stefan'),
	(57, 18, 'Westfal'),
	(58, 18, 'Namur'),
	(59, 19, 'Wizen'),
	(60, 19, 'Turnej'),
	(61, 20, 'Famen'),
	(62, 20, 'Fran'),
	(63, 21, '¯ywet'),
	(64, 21, 'Eifel'),
	(65, 22, 'Ems'),
	(66, 22, 'Prag'),
	(67, 22, 'Lochkow'),
	(68, 22, 'Przydol');

CREATE TABLE Dziesiec (cyfra INT PRIMARY KEY, bit INT);
INSERT INTO Dziesiec (cyfra, bit) VALUES
	(0, 0), (1, 1), (2, 0), (3, 1), (4, 0), (5, 1), (6, 0), (7, 1), (8, 0), (9, 1);

CREATE TABLE Milion(liczba INT, cyfra INT, bit INT);
INSERT INTO Milion 
	SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
	FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;

SELECT * FROM Dziesiec;
SELECT * FROM Milion;
SELECT * FROM GeoEon;
SELECT * FROM GeoEra;
SELECT * FROM GeoOkres;
SELECT * FROM GeoEpoka;
SELECT * FROM GeoPietro;

-- ³¹czenie do GeoTabeli:
CREATE TABLE GeoTabela (
    id_pietro INT PRIMARY KEY,
    nazwa_pietro VARCHAR(50),
    id_epoka INT,
    nazwa_epoka VARCHAR(50),
    id_okres INT,
    nazwa_okres VARCHAR(50),
    id_era INT,
    nazwa_era VARCHAR(50),
    id_eon INT,
    nazwa_eon VARCHAR(50)
);
INSERT INTO GeoTabela (id_pietro, nazwa_pietro, id_epoka, nazwa_epoka, id_okres, nazwa_okres, id_era, nazwa_era, id_eon, nazwa_eon)
SELECT 
    GeoPietro.id_pietro,
    GeoPietro.nazwa_pietro,
    GeoEpoka.id_epoka,
    GeoEpoka.nazwa_epoka,
    GeoOkres.id_okres,
    GeoOkres.nazwa_okres,
    GeoEra.id_era,
    GeoEra.nazwa_era,
    GeoEon.id_eon,
    GeoEon.nazwa_eon
FROM GeoPietro
	INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
	INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	INNER JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
	INNER JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon;

SELECT * FROM GeoTabela;

-- ZAPYTANIA:
-- w³¹czenie statystyk czasu i odczytów
SET STATISTICS IO, TIME ON 

DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO

-- Zapytanie 1 (1 ZL), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci 
-- zdenormalizowanej, przy czym do warunku z³¹czenia dodano operacjê modulo, dopasowuj¹c¹ zakresy wartoœci z³¹czanych kolumn:
SELECT COUNT(*) FROM Milion 
	INNER JOIN GeoTabela ON (Milion.liczba % 68 = GeoTabela.id_pietro);

DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO

-- Zapytanie 2 (2 ZL), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci 
-- znormalizowanej, reprezentowan¹ przez z³¹czenia piêciu tabel:
SELECT COUNT(*) FROM Milion 
	INNER JOIN GeoPietro ON(Milion.liczba % 68 = GeoPietro.id_pietro) 
	INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
	INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	INNER JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
	INNER JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon;

DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO

-- Zapytanie 3 (3 ZG), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci 
-- zdenormalizowanej, przy czym z³¹czenie jest wykonywane poprzez zagnie¿d¿enie skorelowane:
SELECT COUNT(*) FROM Milion 
	WHERE Milion.liczba % 68 = (SELECT id_pietro FROM GeoTabela 
								WHERE Milion.liczba % 68 = id_pietro);

DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS; 
CHECKPOINT
GO

-- Zapytanie 4 (4 ZG), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci
-- znormalizowanej, przy czym z³¹czenie jest wykonywane poprzez zagnie¿d¿enie skorelowane, a zapytanie wewnêtrzne jest z³¹czeniem
-- tabel poszczególnych jednostek geochronologicznych:
SELECT COUNT(*) FROM Milion 
	WHERE Milion.liczba % 68 IN (SELECT GeoPietro.id_pietro FROM GeoPietro 
								INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
								INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
								INNER JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era
								INNER JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon);

SET STATISTICS TIME OFF

-- indeksowanie
CREATE INDEX iEon ON GeoEon(id_eon);
CREATE INDEX iEra ON GeoEra(id_era, id_eon);
CREATE INDEX iOkres ON GeoOkres(id_okres, id_era);
CREATE INDEX iEpoka ON GeoEpoka(id_epoka, id_okres);
CREATE INDEX iPietro ON GeoPietro(id_pietro, id_epoka);
CREATE INDEX iLiczba ON Milion(liczba);
CREATE INDEX iGeoTabela ON GeoTabela(id_pietro, id_epoka, id_era, id_okres,id_eon);

DROP INDEX iEon ON GeoEon;
DROP INDEX iEra ON GeoEra;
DROP INDEX iOkres ON GeoOkres;
DROP INDEX iEpoka ON GeoEpoka;
DROP INDEX iPietro ON GeoPietro;
DROP INDEX iLiczba ON Milion;
DROP INDEX iGeoTabela ON GeoTabela;