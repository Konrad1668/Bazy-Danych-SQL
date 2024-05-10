CREATE OR REPLACE FUNCTION Fibonacci (n INT)
RETURNS INT AS $$
-- zmienne
DECLARE
    a INT := 0;
    elPierwszy INT := 0;
    elDrugi INT := 1;
    i INT := 2;

--pętla obliczeniowa
BEGIN
    IF n = 0 THEN
        RETURN elPierwszy;
    ELSEIF n = 1 THEN
        RETURN elDrugi;
    ELSE
        WHILE i <= n LOOP
            a := elPierwszy + elDrugi;
            elPierwszy := elDrugi;
            elDrugi := a;
            i := i + 1;
        END LOOP;
        RETURN a;
    END IF;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

-- wyniki
CREATE OR REPLACE PROCEDURE WypiszFibonacci(n INT) AS $$
DECLARE
    i INT := 0;
BEGIN
    RAISE NOTICE 'Liczba elementów: %', n;
   	RAISE NOTICE 'Ciąg Fibonacciego: ';
   	
   -- wypisywanie liczb
    WHILE i < n LOOP
        RAISE NOTICE '% ', Fibonacci(i);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- wypisanie wyniku w outpucie

CALL WypiszFibonacci(9);