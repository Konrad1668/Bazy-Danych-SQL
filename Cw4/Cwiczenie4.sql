create database firma; --1
use firma;

CREATE SCHEMA rozliczenia; --2

CREATE TABLE rozliczenia.pracownicy
(
    id_pracownika INT PRIMARY KEY, --3A 3B 3C
    imie VARCHAR(100) NOT NULL,
    nazwisko VARCHAR(100) NOT NULL,
    adres VARCHAR(300) NOT NULL,
    telefon VARCHAR(12) NOT NULL
);

CREATE TABLE rozliczenia.godziny
(
    id_godziny INT PRIMARY KEY,
    data DATE,
    liczba_godzin DECIMAL(10, 2) NOT NULL,
    id_pracownika INT
);

CREATE TABLE rozliczenia.pensje
(
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(100) NOT NULL,
    kwota DECIMAL(20, 2) NOT NULL,
    id_premii INT
);

CREATE TABLE rozliczenia.premie
(
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(100) NOT NULL,
    kwota DECIMAL(20, 2) NOT NULL
);


ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika); --3D
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

--4

insert into rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
values
(1, 'Maciej', 'Stolarz','Laczna 1, Katowice','519123235'),
(2, 'Tomasz', 'Władca', 'Wspólna 12, Bielsko-Biała','612123532'),
(3, 'Wiktoria', 'Jacek', 'Ryzyka deszczowego 2, Opole','450213723'),
(4, 'Wojtek', 'Pruchnica', 'Kasztanowa 70, Żywiec','631123532'),
(5, 'Mikolaj', 'Skrzatowski', 'Orna 49, Rybarzowice','794124653'),
(6, 'Tymek', 'Szefuncio', 'Aleja Wojska polskiego, Oświecim','540235124'),
(7, 'Olaf', 'Tytaniczna-Hydra', 'Baron pit 12d, Summoners Rift','450123512'),
(8, 'Marek', 'Marucha', 'Wyscigowa 40, Służewiec','124523123'),
(9, 'Szymon', 'Margaryna', 'Stefanii Sempołowskiej 63, Bielsko-Biała','338198200'),
(10, 'Jacek', 'Skibicki', 'Almestadbakken 45, Brandal','125523234');

insert into rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
values
(1, '2023-14-03', 45, 1),
(2, '2024-31-05', 123, 2),
(3, '2024-03-12', 87, 3),
(4, '2022-09-29', 42, 4),
(5, '2023-17-05', 1987, 5),
(6, '2024-19-12', 44, 6),
(7, '2023-23-03', 76, 7),
(8, '2014-45-05', 51, 8),
(9, '2024-12-07', 12, 9),
(10, '2004-02-04', 42, 10);

insert into rozliczenia.premie (id_premii, rodzaj, kwota)
values
(1, 'uznaniowa', 700),
(2, 'frekwencyjna', 150),
(3, 'uznaniowa', 200),
(4, 'uznaniowa', 500),
(5, 'regulaminowa', 700),
(6, 'bonusowa', 550),
(7, 'uznaniowa', 504),
(8, 'frekwencyjna', 800),
(9, 'umowna', 120),
(10, 'frekwencyjna', 666);

insert into rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
values
(1, 'Analityk silnikow wysokoprezynch volskwagen', 3000, 1),
(2, 'Tester smaku olejow silnikowych', 15000, 2),
(3, 'Programista nawigacji samochodowej', 14500, 3),
(4, 'Mechanik volkwagen', 7000, 4),
(5, 'Tynkarz murarz', 6000, 5),
(6, 'Akrobata', 1200, 6),
(7, 'Kierowca volkswagen', 6500, 7),
(8, 'Ulotkarz', 120, 8),
(9, 'Wymieniacz opon volkwagen', 4500, 9),
(10, 'Operator wozka widlowego', 25000, 10);

--5

SELECT nazwisko, adres
FROM rozliczenia.pracownicy;

-- 6

SELECT id_godziny, 
       DATA, 
       DATEPART (DAY, DATA) AS dzien_tygodnia,
       DATEPART(MONTH, DATA) AS miesiac
FROM rozliczenia.godziny;

-- 7

EXEC sp_rename 'rozliczenia.pensje.kwota',  'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje 
ADD kwota_netto DECIMAL(20, 2) NOT NULL;

UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto*0.77;








