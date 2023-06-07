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

-- Stored Procedure 1: Get all rentals for a specific customer
CREATE PROCEDURE dbo.GetRentalsByCustomer
    @CustomerID INT
AS
BEGIN
    SELECT v.VermietungID, f.Marke, f.Modell, v.Mietbeginn, v.Mietende
    FROM dbo.Vermietung v
    INNER JOIN dbo.Fahrzeug f ON v.fk_FahrzeugID = f.FahrzeugID
    WHERE v.fk_KundeID = @CustomerID
END
GO

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