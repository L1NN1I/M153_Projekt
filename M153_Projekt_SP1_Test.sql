-- Testfall 1: Gültige Eingabewerte
DECLARE @ReturnValue INT;

EXEC sp_InsertFahrzeug
    @Marke = 'Audi',
    @Modell = 'A4',
    @Baujahr = 2020,
    @PreisProTag = 100.00,
    @ReturnValue = @ReturnValue OUTPUT;

SELECT @ReturnValue AS AnzahlEingefuegteDatensaetze;
GO
-- Testfall 2: Fehlende Eingabewerte
DECLARE @ReturnValue INT;

EXEC sp_InsertFahrzeug
    @Marke = 'BMW',
    @Modell = NULL,
    @Baujahr = 2021,
    @PreisProTag = 150.00,
    @ReturnValue = @ReturnValue OUTPUT;

SELECT @ReturnValue AS AnzahlEingefuegteDatensaetze;
GO

-- Testfall 3: Fehler beim Einfügen in die Tabelle
DECLARE @ReturnValue INT;

EXEC sp_InsertFahrzeug
    @Marke = 'Mercedes',
    @Modell = 'C-Class',
    @Baujahr = 2019,
    @PreisProTag = 'abc',
    @ReturnValue = @ReturnValue OUTPUT;

SELECT @ReturnValue AS AnzahlEingefuegteDatensaetze;
GO