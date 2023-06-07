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

DROP PROCEDURE IF EXISTS dbo.GetRentalsByCustomer;
DROP PROCEDURE IF EXISTS dbo.GetTotalRentalsByCustomer;
DROP FUNCTION IF EXISTS dbo.CalculateRentalPrice;
DROP FUNCTION IF EXISTS dbo.GetAverageRentalDuration;
GO

-- Stored Procedure 1: Add new vehicle to table
CREATE PROCEDURE InsertFahrzeug
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


-- Stored Procedure 2: Get the total number of rentals for each customer
CREATE PROCEDURE dbo.GetTotalRentalsByCustomer
AS
BEGIN
    SELECT k.KundeID, k.Vorname, k.Nachname, COUNT(*) AS TotalRentals
    FROM dbo.Kunde k
    LEFT JOIN dbo.Vermietung v ON k.KundeID = v.fk_KundeID
    GROUP BY k.KundeID, k.Vorname, k.Nachname
END
GO

-- Stored Function 1: Calculate the total price for a rental
CREATE FUNCTION dbo.CalculateRentalPrice
(
    @RentalID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Price DECIMAL(10, 2)
    SELECT @Price = SUM(f.PreisProTag)
    FROM dbo.Vermietung v
    INNER JOIN dbo.Fahrzeug f ON v.fk_FahrzeugID = f.FahrzeugID
    WHERE v.VermietungID = @RentalID
    RETURN @Price
END
GO

-- Stored Function 2: Get the average rental duration in days
CREATE FUNCTION dbo.GetAverageRentalDuration
(
    @CustomerID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AverageDuration DECIMAL(10, 2)
    SELECT @AverageDuration = AVG(DATEDIFF(DAY, Mietbeginn, Mietende))
    FROM dbo.Vermietung
    WHERE fk_KundeID = @CustomerID
    RETURN @AverageDuration
END
GO