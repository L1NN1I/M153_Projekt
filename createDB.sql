IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'Autoverleih_db')
	BEGIN
		CREATE DATABASE [Autoverleih_db]
	END
GO

USE [Autoverleih_db]
GO

DROP TABLE IF EXISTS dbo.Zahlungen;
DROP TABLE IF EXISTS dbo.Vermietungen;
DROP TABLE IF EXISTS dbo.Kunden;
DROP TABLE IF EXISTS dbo.Fahrzeuge;
GO

CREATE TABLE dbo.Fahrzeuge (
    FahrzeugID INT PRIMARY KEY IDENTITY,
    Marke NVARCHAR(50) NOT NULL,
    Modell NVARCHAR(50) NOT NULL,
    Baujahr INT NOT NULL,
    Preis_pro_Tag DECIMAL(10, 2) NOT NULL
)
GO

CREATE TABLE dbo.Kunden (
    KundenID INT PRIMARY KEY IDENTITY,
    Vorname NVARCHAR(50) NOT NULL,
    Nachname NVARCHAR(50) NOT NULL,
    Telefon NVARCHAR(20) NOT NULL,
    [E-Mail] NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE dbo.Vermietungen (
    VermietungsID INT PRIMARY KEY IDENTITY,
    KundenID INT FOREIGN KEY REFERENCES Kunden(KundenID),
    FahrzeugID INT FOREIGN KEY REFERENCES Fahrzeuge(FahrzeugID),
    Mietbeginn DATE NOT NULL,
    Mietende DATE NOT NULL
)
GO

CREATE TABLE dbo.Zahlungen (
    ZahlungsID INT PRIMARY KEY IDENTITY,
    VermietungsID INT FOREIGN KEY REFERENCES Vermietungen(VermietungsID),
    Betrag DECIMAL(10, 2) NOT NULL,
    Zahlungsdatum DATE NOT NULL,
    Zahlungsmethode NVARCHAR(50) NOT NULL
)
GO
