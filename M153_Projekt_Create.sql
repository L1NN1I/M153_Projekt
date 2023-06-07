IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'AutoverleihDB')
BEGIN
    CREATE DATABASE [AutoverleihDB]
END
GO

USE [AutoverleihDB]
GO

DROP TABLE IF EXISTS dbo.Vermietung;
DROP TABLE IF EXISTS dbo.FahrzeugKategorieZuordnung;
DROP TABLE IF EXISTS dbo.Kunde;
DROP TABLE IF EXISTS dbo.Fahrzeug;
DROP TABLE IF EXISTS dbo.FahrzeugKategorie;
GO

CREATE TABLE dbo.Fahrzeug (
    FahrzeugID INT PRIMARY KEY IDENTITY,
    Marke NVARCHAR(50) NOT NULL,
    Modell NVARCHAR(50) NOT NULL,
    Baujahr INT NOT NULL,
    PreisProTag DECIMAL(10, 2) NOT NULL
)
GO

CREATE TABLE dbo.Kunde (
    KundeID INT PRIMARY KEY IDENTITY,
    Vorname NVARCHAR(50) NOT NULL,
    Nachname NVARCHAR(50) NOT NULL,
    Telefon NVARCHAR(20) NOT NULL,
    EMail NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE dbo.Vermietung (
    VermietungID INT PRIMARY KEY IDENTITY,
    fk_KundeID INT FOREIGN KEY REFERENCES Kunde(KundeID),
    fk_FahrzeugID INT FOREIGN KEY REFERENCES Fahrzeug(FahrzeugID),
    Mietbeginn DATE NOT NULL,
    Mietende DATE NOT NULL
)
GO

CREATE TABLE dbo.FahrzeugKategorie (
    KategorieID INT PRIMARY KEY IDENTITY,
    KategorieName NVARCHAR(50) NOT NULL,
    KategorieBeschreibung NVARCHAR(255) NULL
)
GO

CREATE TABLE dbo.FahrzeugKategorieZuordnung (
    fk_FahrzeugID INT FOREIGN KEY REFERENCES Fahrzeug(FahrzeugID),
    fk_KategorieID INT FOREIGN KEY REFERENCES FahrzeugKategorie(KategorieID),
    PRIMARY KEY (fk_FahrzeugID, fk_KategorieID)
)
GO

--------------------------------------------------------------
------------- Create Stored Procedures/Functions -------------
--------------------------------------------------------------

DROP PROCEDURE IF EXISTS dbo.sp_InsertFahrzeug;
DROP PROCEDURE IF EXISTS dbo.sp_DeleteKunde;
DROP FUNCTION IF EXISTS dbo.GetTotalVermietungenForKunde;
DROP FUNCTION IF EXISTS dbo.GetFahrzeugPricePerTag;
GO

-- Stored Procedure 1: Add new vehicle to table
CREATE PROCEDURE sp_InsertFahrzeug
    @Marke NVARCHAR(50),
    @Modell NVARCHAR(50),
    @Baujahr INT,
    @PreisProTag DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Fehlerbehandlung für leere oder falsche Argumente
    IF (@Marke IS NULL OR @Modell IS NULL OR @Baujahr IS NULL OR @PreisProTag IS NULL)
    BEGIN
        RAISERROR('Alle Argumente müssen angegeben werden.', 11, 1);
        RETURN -1;
    END

    BEGIN TRY
        INSERT INTO dbo.Fahrzeug (Marke, Modell, Baujahr, PreisProTag)
        VALUES (@Marke, @Modell, @Baujahr, @PreisProTag);

        -- Rückgabe der Anzahl der eingefügten Datensätze
        RETURN @@ROWCOUNT;
    END TRY
    BEGIN CATCH
        -- Fehlermeldung generieren
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN -1;
    END CATCH
END
GO

-- Stored Procedure 2: Delete a customer/rental with id
CREATE PROCEDURE sp_DeleteKunde
    @KundeID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Fehlerbehandlung für leere oder falsche Argumente
    IF (@KundeID IS NULL)
    BEGIN
        RAISERROR('Die Kunden-ID muss angegeben werden.', 16, 1);
        RETURN -1;
    END

    BEGIN TRY
        DELETE FROM dbo.Kunde
        WHERE KundeID = @KundeID;

        -- Rückgabe der Anzahl der gelöschten Datensätze
        RETURN @@ROWCOUNT;
    END TRY
    BEGIN CATCH
        -- Fehlermeldung generieren
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN -1;
    END CATCH
END
GO

-- Stored Function 1:  
CREATE FUNCTION GetTotalVermietungenForKunde
    (@KundeID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalVermietungen INT;

    -- Fehlerbehandlung für leere oder falsche Argumente
    IF (@KundeID IS NULL)
    BEGIN
        RETURN -1; -- Fehlercode für leere Argumente
    END

    SELECT @TotalVermietungen = COUNT(*)
    FROM dbo.Vermietung
    WHERE fk_KundeID = @KundeID;

    IF (@TotalVermietungen = 0)
    BEGIN
        RETURN NULL; -- Fehlercode für leere Ergebnisse
    END

    RETURN @TotalVermietungen;
END
GO


-- Stored Function 2:
CREATE FUNCTION GetFahrzeugPricePerTag
    (@FahrzeugID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @PricePerTag DECIMAL(10, 2);

    -- Fehlerbehandlung für leere oder falsche Argumente
    IF (@FahrzeugID IS NULL)
    BEGIN
        RETURN -1; -- Wert für leere Argumente
    END

    SELECT @PricePerTag = PreisProTag
    FROM dbo.Fahrzeug
    WHERE FahrzeugID = @FahrzeugID;

    IF (@PricePerTag IS NULL)
    BEGIN
        RETURN NULL; -- Wert für leere Ergebnisse
    END

    RETURN @PricePerTag;
END
GO