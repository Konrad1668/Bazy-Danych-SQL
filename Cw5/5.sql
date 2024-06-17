-- 1

CREATE DATABASE firma;

-- 2

CREATE SCHEMA ksiegowosc;

-- 4

-- ksiegowosc.pracownicy
CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    adres VARCHAR(150),
    telefon VARCHAR(30)
);

-- ksiegowosc.godziny
CREATE TABLE ksiegowosc.godziny (
    id_godziny INT PRIMARY KEY,
    data TEXT,
    liczba_godzin INT,
    id_pracownika INT FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika),
);

-- ksiegowosc.pensja
CREATE TABLE ksiegowosc.pensja (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50),
    kwota DECIMAL(10, 2)
);

-- ksiegowosc.premia
CREATE TABLE ksiegowosc.premia (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(25),
    kwota DECIMAL(10, 2)
);

-- ksiegowosc.wynagrodzenia
CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE,
    id_pracownika INT FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika),
    id_godziny INT FOREIGN KEY REFERENCES ksiegowosc.godziny(id_godziny),
    id_pensji INT FOREIGN KEY REFERENCES ksiegowosc.pensja(id_pensji),
    id_premii INT FOREIGN KEY REFERENCES ksiegowosc.premia(id_premii)
);


-- komentarze do tabel (postgres)

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela z danymi pracownikow';
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela z iloscia prepracowanych godzin dla poszczegolnego pracownika';
COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela z pensjami pracownikow';
COMMENT ON TABLE ksiegowosc.premia IS 'Tabela z premiami pracownikow';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela przechowująca dane o wynagrodzeniach';


-- MSSQL

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela z danymi pracownikow', 
    @level0type = N'Schema', @level0name = N'ksiegowosc', 
    @level1type = N'Table',  @level1name = N'pracownicy';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela z iloscia prepracowanych godzin dla poszczegolnego pracownika', 
    @level0type = N'Schema', @level0name = N'ksiegowosc', 
    @level1type = N'Table',  @level1name = N'godziny';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela z pensjami pracownikow', 
    @level0type = N'Schema', @level0name = N'ksiegowosc', 
    @level1type = N'Table',  @level1name = N'pensja';
   
EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela z premiami pracownikow', 
    @level0type = N'Schema', @level0name = N'ksiegowosc', 
    @level1type = N'Table',  @level1name = N'premia';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabela przechowująca dane o wynagrodzeniach', 
    @level0type = N'Schema', @level0name = N'ksiegowosc', 
    @level1type = N'Table',  @level1name = N'wynagrodzenie';



-- 5

-- Wypełnienie tabeli pracownicy
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) VALUES
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

-- Wypełnienie tabeli godziny
INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika) VALUES
(1, '2023-14-03', 265, 1),
(2, '2024-31-05', 165, 2),
(3, '2024-03-12', 158, 3),
(4, '2022-09-29', 123, 4),
(5, '2023-17-05', 1987, 5),
(6, '2024-19-12', 230, 6),
(7, '2023-23-03', 112, 7),
(8, '2014-45-05', 193, 8),
(9, '2024-12-07', 214, 9),
(10, '2024-02-04', 521, 10);

-- Wypełnienie tabeli pensja
INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota) VALUES
(1, 'Kierownik', 5000),
(2, 'Asystent', 2500),
(3, 'Specjalista', 3500),
(4, 'Technik', 2000),
(5, 'Inżynier', 4000),
(6, 'Analityk', 3000),
(7, 'Sekretarz', 2200),
(8, 'Menadżer', 4500),
(9, 'Konsultant', 3200),
(10, 'Praktykant', 1500);

-- Wypełnienie tabeli premia
INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota) VALUES
(1, 'Roczna', 1000),
(2, 'Półroczna', 500),
(3, 'Kwartalna', 300),
(4, 'Miesięczna', 200),
(5, 'Specjalna', 800),
(6, 'Dodatkowa', 150),
(7, 'Świąteczna', 700),
(8, 'Uznaniowa', 400),
(9, 'Projektowa', 600),
(10, 'Frekwencyjna', 350);

-- Wypełnienie tabeli wynagrodzenie
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES
(1, '2023-06-01', 1, 1, 1, 1),
(2, '2023-06-01', 2, 2, 2, 2),
(3, '2023-06-01', 3, 3, 3, 3),
(4, '2023-06-01', 4, 4, 4, 4),
(5, '2023-06-01', 5, 5, 5, 5),
(6, '2023-06-01', 6, 6, 6, 6),
(7, '2023-06-01', 7, 7, 7, 7),
(8, '2023-06-01', 8, 8, 8, 8),
(9, '2023-06-01', 9, 9, 9, 9),
(10, '2023-06-01', 10, 10, 10, 10);

-- 5a

SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- 5b

SELECT pr.id_pracownika FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji
WHERE p.kwota > 1000;

-- 5c

SELECT pr.id_pracownika FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji
WHERE p.kwota > 2000 AND w.id_premii IS NULL;

-- 5d

SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

-- 5e

SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- 5f
	
SELECT p.imie, p.nazwisko, SUM(g.liczba_godzin) - 160 AS Nadgodziny FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
GROUP BY p.imie, p.nazwisko
HAVING SUM(g.liczba_godzin) > 160;

-- 5g

SELECT pr.imie, pr.nazwisko FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji 
WHERE p.kwota BETWEEN 1500 AND 3000;

-- 5h

SELECT pr.imie, pr.nazwisko FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika 
JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny 
WHERE g.liczba_godzin > 160 AND w.id_premii IS NULL;

-- 5i

SELECT pr.* FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika 
JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji 
ORDER BY p.kwota;

-- 5j

SELECT pr.* FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja ps ON w.id_pensji = ps.id_pensji 
JOIN ksiegowosc.premia p ON w.id_premii = p.id_premii 
ORDER BY ps.kwota DESC, p.kwota DESC;