-- 6b (a)

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon);

-- 6b (b)

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(
    SUBSTRING(telefon, 1, 9),
    '-',
    SUBSTRING(telefon, 10, 3),
    '-',
    SUBSTRING(telefon, 13, 6)
);

-- 6b (c)

SELECT TOP 1 UPPER(imie), UPPER(nazwisko), UPPER(adres) FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

-- 6b (d)

SELECT imie, nazwisko, HASHBYTES('MD5', CAST(kwota AS VARCHAR(25))) AS enc_pensja
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika 
JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji;

-- 6b (f)

SELECT pr.id_pracownika, pr.imie, pr.nazwisko, p.kwota AS pensja, pm.kwota AS premia
FROM ksiegowosc.pracownicy pr
LEFT JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji
LEFT JOIN ksiegowosc.premia pm ON w.id_premii = pm.id_premii;

-- 6b (g)

SELECT CONCAT('Pracownik ', pr.imie, ' ', pr.nazwisko, ' ', ', w dniu ', w.data, ' otrzymal pensje calkowita na kwote ', p.kwota + pm.kwota + ((g.liczba_godzin - 160) * 12.34), ' zl, gdzie  wynagrodzenie zasadnicze wynosilo: '
, p.kwota, ' zl, premia: ', pm.kwota, ' zl, nadgodziny: ', ((g.liczba_godzin - 160) * 12.34), ' zl') AS raport
FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji 
JOIN ksiegowosc.premia pm ON w.id_premii = pm.id_premii 
JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny;





