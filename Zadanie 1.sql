-- 1
create database s414302;

-- 2

create schema firma;

-- 3

create role Ksiegowosc;
grant connect on database s414302 to Ksiegowosc;
grant usage on schema firma to Ksiegowosc;
grant select on all tables to Ksiegowosc;

-- 4, 4a, 4c, 4f

create table firma.pracownicy 
(
	id_pracownika serial,
	imie varchar(30) not null,
	nazwisko varchar(100) not null,
	adres varchar(300),
	telefon varchar(12)
);

create table firma.godziny
(
	id_godziny serial,
	data date not null,
	liczba_godzin int not null,
	id_pracownika int references firma.pracownicy(id_pracownika)
);

create table firma.pensja_stanowisko
(
	id_pensji serial,
	stanowisko varchar(100) not null,
	kwota decimal(10,2) not null check (kwota >= 0)
);

create table firma.premia
(
	id_premii serial,
	rodzaj varchar(50) not null,
	kwota decimal(10,2) not null check (kwota >= 0)
);

create table firma.wynagrodzenie
(
	id_wynagrodzenia serial,
	data date not null,
	id_pracownika int references firma.pracownicy(id_pracownika) on delete no action,
	id_godziny int references firma.godziny(id_godziny),
    id_pensji int references firma.pensja_stanowisko(id_pensji),
    id_premii int references firma.premia(id_premii)
);

-- 4b

alter table firma.pracownicy
add constraint PK_pracownicy primary key (id_pracownika);

alter table firma.godziny
add constraint PK_godziny primary key (id_godziny);

alter table firma.pensja_stanowisko
add constraint PK_pensja primary key (id_pensji);

alter table firma.premia
add constraint PK_premia primary key (id_premii);

alter table firma.wynagrodzenie
add constraint PK_wynagrodzenie primary key (id_wynagrodzenia);

-- 4d

create index index_pensja on firma.pensja_stanowisko
using btree(stanowisko);

-- 4e

comment on table firma.pracownicy is 'dane pracowników';
comment on table firma.godziny is 'godziny pracy pracowników';
comment on table firma.pensja_stanowisko is 'pensje na poszczególnych stanowiskach';
comment on table firma.premia is 'premie oraz rodzaje premii';
comment on table firma.wynagrodzenie is 'wynagrodzenia pracowników';

-- 5

insert into firma.pracownicy(id_pracownika, imie, nazwisko, adres, telefon) values
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

insert into firma.godziny(id_godziny, data, liczba_godzin, id_pracownika) values
(1, '2023-03-14', 45, 1),
(2, '2024-05-31', 123, 2),
(3, '2024-03-12', 87, 3),
(4, '2022-09-29', 42, 4),
(5, '2023-05-17', 1987, 5),
(6, '2024-12-19', 44, 6),
(7, '2023-03-23', 76, 7),
(8, '2014-11-05', 51, 8),
(9, '2024-12-07', 12, 9),
(10, '2004-02-04', 42, 10);

insert into firma.pensja_stanowisko(id_pensji, stanowisko, kwota) values
(1, 'Analityk silnikow wysokoprezynch volskwagen', 3000),
(2, 'Tester smaku olejow silnikowych', 15000),
(3, 'Programista nawigacji samochodowej', 14500),
(4, 'Mechanik volkwagen', 7000),
(5, 'Tynkarz murarz', 6000),
(6, 'Akrobata', 1200),
(7, 'Kierowca volkswagen', 6500),
(8, 'Ulotkarz', 120),
(9, 'Wymieniacz opon volkwagen', 4500),
(10, 'Operator wozka widlowego', 25000);

insert into firma.premia(id_premii, rodzaj, kwota) values
(1, 'brak', 0),
(2, 'frekwencyjna', 150),
(3, 'uznaniowa', 200),
(4, 'brak', 0),
(5, 'regulaminowa', 700),
(6, 'bonusowa', 550),
(7, 'uznaniowa', 504),
(8, 'frekwencyjna', 800),
(9, 'umowna', 120),
(10, 'frekwencyjna', 666);

insert into firma.wynagrodzenie(id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) values
(1, '2023-03-14', 1, 1, 1, 1),
(2, '2024-05-31', 2, 2, 2, 2),
(3, '2024-03-12', 3, 3, 3, 3),
(4, '2022-09-29', 4, 4, 4, 4),
(5, '2023-05-17', 5, 5, 5, 5),
(6, '2024-12-19', 6, 6, 6, 6),
(7, '2023-03-23', 7, 7, 7, 7),
(8, '2014-11-05', 8, 8, 8, 8),
(9, '2024-12-07', 9, 9, 9, 9),
(10, '2004-02-04', 10, 10, 10, 10);

-- 5a

alter table firma.godziny
add column miesiac DATE,
add column numer_tygodnia DATE;

-- 5b

alter table firma.wynagrodzenie
alter column data type text using data::text;

-- 6a

select id_pracownika, nazwisko from firma.pracownicy;

-- 6b

select p.id_pracownika
from firma.pracownicy p
join firma.pensja_stanowisko ps on p.id_pracownika = ps.id_pensji 
where kwota > 1000

-- 6c

select p.id_pracownika
from firma.pracownicy p 
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja_stanowisko ps on w.id_pensji = ps.id_pensji 
join firma.premia p2 on w.id_premii = p2.id_premii 
where p2.rodzaj = 'brak' and ps.kwota > 2000;

-- 6d

select imie, nazwisko
from firma.pracownicy
where imie like 'J%';

-- 6e

select imie, nazwisko
from firma.pracownicy
where nazwisko like '%n%' and imie like '%a';

-- 6f

select p.imie, p.nazwisko, sum(g.liczba_godzin - 160) as nadgodziny
from firma.pracownicy p
join firma.godziny g on p.id_pracownika = g.id_pracownika
group by p.imie, p.nazwisko

-- 6g

select p.imie, p.nazwisko
from firma.pracownicy p 
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja_stanowisko ps on w.id_pensji = ps.id_pensji 
where ps.kwota between 1500 and 3000;

-- 6h

select p.imie, p.nazwisko
from firma.pracownicy p 
join firma.godziny g on p.id_pracownika = g.id_pracownika 
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.premia p2 on w.id_premii = p2.id_premii 
where g.liczba_godzin > 160 and p2.rodzaj = 'brak'


-- 7a

select p.imie, p.nazwisko, ps.kwota
from firma.pracownicy p
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja_stanowisko ps on w.id_pensji = ps.id_pensji 
order by ps.kwota

-- 7b

select p.imie, p.nazwisko, ps.kwota
from firma.pracownicy p
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja_stanowisko ps on w.id_pensji = ps.id_pensji 
order by ps.kwota desc;

-- 7c

select ps.stanowisko, count(p.id_pracownika) as liczba_pracownikow
from firma.pracownicy p
join firma.pensja_stanowisko ps on p.id_pracownika = ps.id_pensji 
group by ps.stanowisko;

-- 7d

select avg(p.kwota) as srednia, min(p.kwota) as minimalna_placa, max(p.kwota) as maksymalna_placa
from firma.pensja_stanowisko p
where p.stanowisko = 'kierownik';

-- 7e

select sum(p.kwota) as suma_wynagrodzen
from firma.pensja_stanowisko p;

-- 7f

select p.stanowisko, sum(p.kwota) as suma_wynagrodzen
from firma.pensja_stanowisko p
group by p.stanowisko
order by suma_wynagrodzen desc;

-- 7g

select ps.stanowisko, count(pr.id_premii) as liczba_premii
from firma.pensja_stanowisko ps
join firma.wynagrodzenie w on ps.id_pensji = w.id_pensji
join firma.premia pr on w.id_premii = pr.id_premii 
group by ps.stanowisko;

-- 7h

delete from firma.pracownicy p
using firma.wynagrodzenia w, firma.pensja_stanowisko ps
where p.id_pracownika = w.id_pracownika and w.id_pensji = ps.id_pensji and ps.kwota < 1200;

-- 8a
-- alter table firma.pracownicy alter column telefon type varchar(20) using telefon::varchar(20);
update firma.pracownicy
set telefon = '(+48) ' || telefon;

-- 8b

update firma.pracownicy 
set telefon = regexp_replace(telefon, '(\d{3})(\d{3})(\d{3})', '\1-\2-\3');

-- 8c

select upper(imie), upper(nazwisko)
from firma.pracownicy
order by length(nazwisko) desc limit 1;

-- 8d

select p.imie, p.nazwisko, md5(cast(ps.kwota as text)) as pensja_zakodowana
from firma.pracownicy p 
join firma.wynagrodzenie w on p.id_pracownika = w.id_pracownika 
join firma.pensja_stanowisko ps on w.id_pensji = ps.id_pensji;

-- 9

select 'Pracownik ' || p.imie || ' ' || p.nazwisko || ', w dniu ' || w.data || ' otrzymał pensję całkowitą na kwotę ' ||
(case 
	when g.liczba_godzin >= 160 then (160 * 28.1) + ((g.liczba_godzin - 160) * 45) else g.liczba_godzin * 28.1 
end)
|| ' zł, ' || 'gdzie wynagrodzenie zasadnicze wynosiło: ' || sum(pr.kwota) || ' zł, ' || 'premia: ' || sum(pr.kwota) || ' zł, ' || 'nadgodziny: ' || sum(g.liczba_godzin * 45) || ' zł.' as report
	
from firma.pracownicy p
join firma.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
join firma.premia pr ON w.id_premii = pr.id_premii
join firma.godziny g ON w.id_godziny = g.id_godziny
group by p.imie, p.nazwisko, w.data, g.liczba_godzin;