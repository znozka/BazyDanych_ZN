-- punkt 3 (a-c):
USE firma;

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
kwota INTEGER NOT NULL,
id_premii INTEGER NOT NULL
);

CREATE TABLE rozliczenia.premie (
id_premii INTEGER NOT NULL PRIMARY KEY,
rodzaj VARCHAR(50),
kwota INTEGER NOT NULL
);

-- punkt 3 (d):
ALTER TABLE rozliczenia.pensje ADD CONSTRAINT fk_premia_id FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);
ALTER TABLE rozliczenia.godziny ADD CONSTRAINT fk_pracownik_id FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);