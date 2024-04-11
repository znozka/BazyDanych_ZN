-- punkt 4:
USE firma;

INSERT INTO rozliczenia.pracownicy(id_pracownika, imie, nazwisko, adres, telefon)
VALUES (1, 'Jan', 'Kowalski', 'Magnoliowa 13', 123789456),
(2, 'Anna', 'Nowak', 'Dêbowa 7', 987654321),
(3, 'Piotr', 'Wiœniewski', 'S³oneczna 25', 456123789),
(4, 'Maria', 'D¹browska', 'Brzozowa 11', 789456123),
(5, 'Krzysztof', 'Lewandowski', 'Polna 3', 321654987),
(6, 'Barbara', 'Wójcik', 'Lipowa 9', 654987321),
(7, 'Andrzej', 'Kamiñski', 'Topolowa 15', 987321654),
(8, 'Magdalena', 'Kowalczyk', '¯urawia 21', 741852963),
(9, 'Tomasz', 'Zieliñski', 'Szkolna 8', 852963741),
(10, 'Joanna', 'WoŸniak', 'Rzeczna 17', 369258147);

INSERT INTO rozliczenia.godziny(id_godziny, data, liczba_godzin, id_pracownika)
VALUES (1, '2024-04-01', 8, 1),
(2, '2024-04-02', 7, 2),
(3, '2024-04-03', 6, 3),
(4, '2024-04-04', 8, 1),
(5, '2024-04-05', 9, 2),
(6, '2024-04-06', 7, 3),
(7, '2024-04-07', 8, 1),
(8, '2024-04-08', 6, 2),
(9, '2024-04-09', 7, 3),
(10, '2024-04-10', 8, 1);

INSERT INTO rozliczenia.pensje(id_pensji, stanowisko, kwota, id_premii)
VALUES(1, 'Specjalista ds. Sprzeda¿y', 5000, 1),
(2, 'Ksiêgowy', 4500, 2),
(3, 'Programista', 6000, 3),
(4, 'Doradca Klienta', 4200, 1),
(5, 'Administrator Systemów', 5500, 2),
(6, 'Analityk Finansowy', 5800, 3),
(7, 'Specjalista ds. Marketingu', 4800, 1),
(8, 'Project Manager', 6200, 2),
(9, 'Architekt Systemowy', 6700, 3),
(10, 'Specjalista ds. HR', 4900, 1);

INSERT INTO rozliczenia.premie(id_premii, rodzaj, kwota)
VALUES(1, 'Premia za wyniki sprzeda¿y', 1000),
(2, 'Premia roczna', 1500),
(3, 'Premia za osi¹gniêcie celów', 1200),
(4, 'Premia za sta¿ pracy', 800),
(5, 'Premia za innowacyjne rozwi¹zania', 2000),
(6, 'Premia za zaanga¿owanie', 900),
(7, 'Premia za zdobycie nowego klienta', 1300),
(8, 'Premia za efektywnoœæ', 1100),
(9, 'Premia za d³ugoletni¹ wspó³pracê', 1600),
(10, 'Premia za najlepszy projekt roku', 1800);

-- punkt 5:
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- punkt 6:
SELECT DATEPART(WEEK, data) FROM rozliczenia.godziny;
SELECT DATEPART(MONTH, data) FROM rozliczenia.godziny;