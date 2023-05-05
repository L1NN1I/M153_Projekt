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