CREATE DATABASE projekt;

-- TWORZENIE TABEL:
CREATE TABLE GeoEon (
    id_eon SERIAL PRIMARY KEY,
    nazwa_eon VARCHAR(50)
);
CREATE TABLE GeoEra (
    id_era SERIAL PRIMARY KEY,
    id_eon INT,
    nazwa_era VARCHAR(50),
    FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon)
);
CREATE TABLE GeoOkres (
    id_okres SERIAL PRIMARY KEY,
    id_era INT,
    nazwa_okres VARCHAR(50),
    FOREIGN KEY (id_era) REFERENCES GeoEra(id_era)
);
CREATE TABLE GeoEpoka (
    id_epoka SERIAL PRIMARY KEY,
    id_okres INT,
    nazwa_epoka VARCHAR(50),
    FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres)
);
CREATE TABLE GeoPietro (
    id_pietro SERIAL PRIMARY KEY,
    id_epoka INT,
    nazwa_pietro VARCHAR(50),
    FOREIGN KEY (id_epoka) REFERENCES GeoEpoka(id_epoka)
);

INSERT INTO GeoEon (nazwa_eon) VALUES
	('FANEROZOIK');
INSERT INTO GeoEra (id_eon, nazwa_era) VALUES
	(1, 'Kenozoik'),
	(1, 'Mezozoik'),
	(1, 'Paleozoik');
INSERT INTO GeoOkres (id_era, nazwa_okres) VALUES
	(1, 'Czwartorzęd'),
	(1, 'Neogen'),
	(1, 'Paleogen'),
	(2, 'Kreda'),
	(2, 'Jura'),
	(2, 'Trias'),
	(3, 'Perm'),
	(3, 'Karbon'),
	(3, 'Dewon');
INSERT INTO GeoEpoka (id_okres, nazwa_epoka) VALUES
	(1, 'Holocen'),
	(1, 'Plejstocen'),
	(2, 'Pliocen'),
	(2, 'Miocen'),
	(3, 'Oligocen'),
	(3, 'Eocen'),
	(3, 'Paleocen'),
	(4, 'Kreda Górna'),
	(4, 'Kreda Dolna'),
	(5, 'Jura Górna'),
	(5, 'Jura Środkowa'),
	(5, 'Jura Dolna'),
	(6, 'Trias Górny'),
	(6, 'Trias Środkowy'),
	(6, 'Trias Dolny'),
	(7, 'Perm Górny'),
	(7, 'Perm Dolny'),
	(8, 'Karbon Górny'),
	(8, 'Karbon Dolny'),
	(9, 'Dewon Górny'),
	(9, 'Dewon Środkowy'),
	(9, 'Dewon Dolny');
INSERT INTO GeoPietro (id_epoka, nazwa_pietro) VALUES
	(3, 'Gelas'),
	(3, 'Piacent'),
	(3, 'Zankl'),
	(4, 'Mesyn'),
	(4, 'Torton'),
	(4, 'Serrawal'),
	(4, 'Lang'),
	(4, 'Burdygał'),
	(4, 'Akwitan'),
	(5, 'Szat'),
	(5, 'Rupel'),
	(6, 'Priabon'),
	(6, 'Barton'),
	(6, 'Lutet'),
	(6, 'Iprez'),
	(7, 'Tanet'),
	(7, 'Zeland'),
	(7, 'Dan'),
	(8, 'Mastrycht'),
	(8, 'Kampan'),
	(8, 'Santon'),
	(8, 'Koniak'),
	(8, 'Turon'),
	(8, 'Cenoman'),
	(9, 'Alb'),
	(9, 'Apt'),
	(9, 'Barrem'),
	(9, 'Hoteryw'),
	(9, 'Walażyn'),
	(9, 'Berias'),
	(10, 'Tyton'),
	(10, 'Kimeryd'),
	(10, 'Oksford'),
	(11, 'Kellowej'),
	(11, 'Baton'),
	(11, 'Bajos'),
	(11, 'Aalen'),
	(12, 'Toark'),
	(12, 'Pliensbach'),
	(12, 'Synemur'),
	(12, 'Hetang'),
	(13, 'Retyk'),
	(13, 'Noryk'),
	(13, 'Karnik'),
	(14, 'Ladyn'),
	(14, 'Anizyk'),
	(15, 'Olenek'),
	(15, 'Ind'),
	(16, 'Tatar'),
	(16, 'Kazań'),
	(16, 'Ufa'),
	(17, 'Kungur'),
	(17, 'Artinsk'),
	(17, 'Sakmar'),
	(17, 'Assel'),
	(18, 'Stefan'),
	(18, 'Westfal'),
	(18, 'Namur'),
	(19, 'Wizen'),
	(19, 'Turnej'),
	(20, 'Famen'),
	(20, 'Fran'),
	(21, 'Żywet'),
	(21, 'Eifel'),
	(22, 'Ems'),
	(22, 'Prag'),
	(22, 'Lochkow'),
	(22, 'Przydol');

CREATE TABLE Dziesiec (cyfra INT PRIMARY KEY, bit INT);
INSERT INTO Dziesiec (cyfra, bit) VALUES
	(0, 0), (1, 1), (2, 0), (3, 1), (4, 0), (5, 1), (6, 0), (7, 1), (8, 0), (9, 1);

CREATE TABLE Milion(liczba INT, cyfra INT, bit INT);
INSERT INTO Milion 
	SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
	FROM Dziesiec a1 CROSS JOIN Dziesiec a2 CROSS JOIN Dziesiec a3 CROSS JOIN Dziesiec a4 CROSS JOIN Dziesiec a5 CROSS JOIN Dziesiec a6 ;

SELECT * FROM Dziesiec;
SELECT * FROM Milion;
SELECT * FROM GeoEon;
SELECT * FROM GeoEra;
SELECT * FROM GeoOkres;
SELECT * FROM GeoEpoka;
SELECT * FROM GeoPietro;

-- łączenie z tabelą GeoTabela:
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

EXPLAIN (ANALYZE, BUFFERS)	
	-- Zapytanie 1 (1 ZL), którego celem jest złączenie syntetycznej tablicy miliona wyników z tabelą geochronologiczną w postaci 
	-- zdenormalizowanej, przy czym do warunku złączenia dodano operację modulo, dopasowującą zakresy wartości złączanych kolumn:
	SELECT COUNT(*) FROM Milion 
		INNER JOIN GeoTabela ON (mod(Milion.liczba, 68) = (GeoTabela.id_pietro));
;
CHECKPOINT;

EXPLAIN (ANALYZE, BUFFERS)
	-- Zapytanie 2 (2 ZL), którego celem jest złączenie syntetycznej tablicy miliona wyników z tabelą geochronologiczną w postaci 
	-- znormalizowanej, reprezentowaną przez złączenia pięciu tabel:
	SELECT COUNT(*) FROM Milion 
		INNER JOIN GeoPietro on (mod(Milion.liczba, 68) = GeoPietro.id_pietro) 
		NATURAL JOIN GeoEpoka 
		NATURAL JOIN GeoOkres 
		NATURAL JOIN GeoEra 
		NATURAL JOIN GeoEon;
;
CHECKPOINT;

EXPLAIN (ANALYZE, BUFFERS)
	-- Zapytanie 3 (3 ZG), którego celem jest złączenie syntetycznej tablicy miliona wyników z tabelą geochronologiczną w postaci 
	-- zdenormalizowanej, przy czym złączenie jest wykonywane poprzez zagnieżdżenie skorelowane:
	SELECT COUNT(*) FROM Milion 
		WHERE mod(Milion.liczba, 68) = (SELECT id_pietro FROM GeoTabela
		WHERE mod(Milion.liczba, 68) = (id_pietro));
;
CHECKPOINT;

EXPLAIN (ANALYZE, BUFFERS)
	-- Zapytanie 4 (4 ZG), którego celem jest złączenie syntetycznej tablicy miliona wyników z tabelą geochronologiczną w postaci
	-- znormalizowanej, przy czym złączenie jest wykonywane poprzez zagnieżdżenie skorelowane, a zapytanie wewnętrzne jest złączeniem
	-- tabel poszczególnych jednostek geochronologicznych:
	SELECT COUNT(*) FROM Milion 
		WHERE mod(Milion.liczba, 68) IN (SELECT GeoPietro.id_pietro FROM GeoPietro
		NATURAL JOIN GeoEpoka 
		NATURAL JOIN GeoOkres 
		NATURAL JOIN GeoEra 
		NATURAL JOIN GeoEon);
;
CHECKPOINT;

--indeksowanie
CREATE INDEX iEon ON GeoEon(id_eon);
CREATE INDEX iEra ON GeoEra(id_era, id_eon);
CREATE INDEX iOkres ON GeoOkres(id_okres, id_era);
CREATE INDEX iEpoka ON GeoEpoka(id_epoka, id_okres);
CREATE INDEX iPietro ON GeoPietro(id_pietro, id_epoka);
CREATE INDEX iLiczba ON Milion(liczba);
CREATE INDEX iGeoTabela ON GeoTabela(id_pietro, id_epoka, id_era, id_okres,id_eon);

DROP INDEX iEon;
DROP INDEX iEra;
DROP INDEX iOkres;
DROP INDEX iEpoka;
DROP INDEX iPietro;
DROP INDEX iLiczba;
DROP INDEX iGeoTabela;