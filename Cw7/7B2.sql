-- wstawienie rekordów do tabeli

INSERT INTO Person.businessentity (businessentityid)
values ('1')

-- wywolanie funkcji

INSERT INTO Person.Person (FirstName, LastName, BusinessEntityID, PersonType)
VALUES ('Maciej', 'Stolarz', 1, 'EM');

-- funkcja

CREATE OR REPLACE FUNCTION Switch_to_uppercase()
RETURNS TRIGGER AS $$

BEGIN
    NEW.lastname := UPPER(NEW.lastname); -- konwersja stringu do uppercase'a 
    RETURN NEW;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER Switch_to_uppercase_TRIGGER

BEFORE INSERT OR UPDATE ON Person.Person
FOR EACH ROW
EXECUTE FUNCTION Switch_to_uppercase();