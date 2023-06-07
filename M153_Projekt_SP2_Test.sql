--Testfall 1: Gültige Kunden-ID
DECLARE @ReturnValue INT;

EXEC sp_DeleteKunde
    @KundeID = 6,
    @ReturnValue = @ReturnValue OUTPUT;

SELECT @ReturnValue AS AnzahlGeloeschterDatensaetze;
GO

--Testfall 2: Fehlende Kunden-ID
DECLARE @ReturnValue INT;

EXEC sp_DeleteKunde
    @KundeID = NULL,
    @ReturnValue = @ReturnValue OUTPUT;

SELECT @ReturnValue AS AnzahlGeloeschterDatensaetze;
GO

--Testfall 3: Nicht vorhandene Kunden-ID
DECLARE @ReturnValue INT;

EXEC sp_DeleteKunde
    @KundeID = 9999, -- Eine Kunden-ID, die nicht in der Tabelle existiert
    @ReturnValue = @ReturnValue OUTPUT;

SELECT @ReturnValue AS AnzahlGeloeschterDatensaetze;
GO