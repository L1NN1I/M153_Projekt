--Testfall 1: Gültige Fahrzeug-ID mit Preis pro Tag vorhanden

DECLARE @FahrzeugID INT = 1; -- Beispiel-Fahrzeug-ID

SELECT dbo.GetFahrzeugPricePerTag(@FahrzeugID) AS PreisProTag;
GO

--Testfall 2: Leere Fahrzeug-ID

DECLARE @FahrzeugID INT = NULL; -- Leere Fahrzeug-ID

SELECT dbo.GetFahrzeugPricePerTag(@FahrzeugID) AS PreisProTag;
GO