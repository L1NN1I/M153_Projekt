--Testfall 1: Gültige Kunden-ID mit Vermietungen vorhanden

DECLARE @KundeID INT = 1;

SELECT dbo.GetTotalVermietungenForKunde(@KundeID) AS Gesamtvermietungen;
GO

--Testfall 2: Gültige Kunden-ID ohne Vermietungen

DECLARE @KundeID INT = 2; -- Beispiel-Kunden-ID

SELECT dbo.GetTotalVermietungenForKunde(@KundeID) AS Gesamtvermietungen;
GO

--Testfall 3: Leere Kunden-ID
DECLARE @KundeID INT = NULL;

SELECT dbo.GetTotalVermietungenForKunde(@KundeID) AS Gesamtvermietungen;
GO