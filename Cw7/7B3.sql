--funkcja

CREATE OR REPLACE FUNCTION TaxRate_change()
RETURNS TRIGGER AS $$

-- zmienne

DECLARE
    podatek_stary NUMERIC;
    podatek_nowy NUMERIC;
   	-- maksymalna wartosc zmiany
    zmianaMAX NUMERIC;
BEGIN
    podatek_stary := OLD.TaxRate;	
    podatek_nowy := NEW.TaxRate;

	-- ustawienie granicy na 30%
    zmianaMAX := podatek_stary * 0.3;

   -- warunek if
   
    IF ABS(podatek_stary - podatek_nowy) > zmianaMAX THEN
        RAISE EXCEPTION 'BŁĄD! Zmiana wartości podatku nie może być większa niż 30%.';
    END if;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger

CREATE TRIGGER taxRateMonitoring
BEFORE UPDATE OF TaxRate ON sales.salestaxrate 
FOR EACH ROW
EXECUTE FUNCTION TaxRate_change();

-- update tabeli

UPDATE Sales.SalesTaxRate
SET TaxRate = TaxRate * 1.5
WHERE TaxRate = '8';

-- to few parameters specified for RAISE (pusta tabela)
