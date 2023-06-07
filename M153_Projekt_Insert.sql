-------------------------------------------
------------- Insert Testdata -------------
-------------------------------------------

INSERT INTO dbo.Fahrzeug (Marke, Modell, Baujahr, PreisProTag)
VALUES 
	('Volkswagen', 'Golf', 2018, 50.00),
    ('BMW', 'X5', 2020, 100.00),
    ('Mercedes', 'C-Class', 2019, 80.00),
    ('Audi', 'A4', 2021, 90.00),
    ('Toyota', 'Corolla', 2020, 60.00),
    ('Ford', 'Mustang', 2019, 120.00),
    ('Chevrolet', 'Camaro', 2021, 110.00),
    ('Honda', 'Accord', 2018, 70.00),
    ('Hyundai', 'Tucson', 2022, 85.00),
    ('Nissan', 'Sentra', 2021, 65.00),
    ('Kia', 'Optima', 2020, 75.00),
    ('Mazda', 'CX-5', 2019, 95.00),
    ('Subaru', 'Outback', 2021, 90.00),
    ('Volvo', 'XC60', 2022, 105.00),
    ('Lexus', 'RX', 2020, 110.00),
    ('Land Rover', 'Range Rover', 2021, 150.00),
    ('Tesla', 'Model 3', 2022, 140.00),
    ('Porsche', '911', 2021, 200.00),
    ('Jaguar', 'F-Type', 2020, 180.00),
    ('Acura', 'MDX', 2022, 130.00)
GO

INSERT INTO dbo.Kunde (Vorname, Nachname, Telefon, EMail)
VALUES 
	('Max', 'Mustermann', '123456789', 'max.mustermann@example.com'),
    ('Erika', 'Musterfrau', '987654321', 'erika.musterfrau@example.com'),
    ('Hans', 'Schmidt', '555555555', 'hans.schmidt@example.com'),
    ('Maria', 'Meier', '666666666', 'maria.meier@example.com'),
    ('John', 'Doe', '111111111', 'john.doe@example.com'),
    ('Jane', 'Smith', '222222222', 'jane.smith@example.com'),
    ('Michael', 'Brown', '333333333', 'michael.brown@example.com'),
    ('Emily', 'Johnson', '444444444', 'emily.johnson@example.com'),
    ('David', 'Williams', '555555555', 'david.williams@example.com'),
    ('Sophia', 'Jones', '666666666', 'sophia.jones@example.com'),
    ('Matthew', 'Taylor', '777777777', 'matthew.taylor@example.com'),
    ('Olivia', 'Anderson', '888888888', 'olivia.anderson@example.com'),
    ('Daniel', 'Thomas', '999999999', 'daniel.thomas@example.com'),
    ('Ava', 'Robinson', '101010101', 'ava.robinson@example.com'),
    ('Andrew', 'Clark', '121212121', 'andrew.clark@example.com'),
    ('Sophie', 'Hall', '131313131', 'sophie.hall@example.com'),
    ('James', 'Allen', '141414141', 'james.allen@example.com'),
    ('Emma', 'Young', '151515151', 'emma.young@example.com'),
    ('Benjamin', 'Walker', '161616161', 'benjamin.walker@example.com'),
    ('Mia', 'Lewis', '171717171', 'mia.lewis@example.com')
GO

INSERT INTO dbo.Vermietung (fk_KundeID, fk_FahrzeugID, Mietbeginn, Mietende)
VALUES 
	(1, 1, '2023-05-01', '2023-05-05'),
    (1, 3, '2023-05-02', '2023-05-06'),
    (3, 2, '2023-05-03', '2023-05-07'),
    (4, 4, '2023-05-04', '2023-05-08'),
    (5, 5, '2023-05-05', '2023-05-09'),
    (6, 7, '2023-05-06', '2023-05-10'),
    (7, 6, '2023-05-07', '2023-05-11'),
    (8, 8, '2023-05-08', '2023-05-12'),
    (9, 10, '2023-05-09', '2023-05-13'),
    (10, 9, '2023-05-10', '2023-05-14'),
    (11, 12, '2023-05-11', '2023-05-15'),
    (12, 11, '2023-05-12', '2023-05-16'),
    (13, 13, '2023-05-13', '2023-05-17'),
    (14, 15, '2023-05-14', '2023-05-18'),
    (15, 14, '2023-05-15', '2023-05-19'),
    (16, 16, '2023-05-16', '2023-05-20'),
    (17, 18, '2023-05-17', '2023-05-21'),
    (18, 17, '2023-05-18', '2023-05-22'),
    (19, 19, '2023-05-19', '2023-05-23'),
    (20, 20, '2023-05-20', '2023-05-24')
GO

INSERT INTO dbo.FahrzeugKategorie (KategorieName, KategorieBeschreibung)
VALUES 
	('Limousine', 'Luxury sedan'),
    ('SUV', 'Sport Utility Vehicle'),
    ('Kompaktwagen', 'Compact car'),
    ('Cabrio', 'Convertible'),
    ('Van', 'Minivan'),
    ('Sportwagen', 'Sports car'),
    ('Kombi', 'Station wagon'),
    ('Motorrad', 'Motorcycle'),
    ('Lkw', 'Truck'),
    ('Wohnmobil', 'Motorhome'),
    ('Transporter', 'Van'),
    ('Bus', 'Bus'),
    ('Elektroauto', 'Electric car'),
    ('Hybridauto', 'Hybrid car'),
    ('Oldtimer', 'Vintage car'),
    ('Motorroller', 'Scooter'),
    ('Fahrrad', 'Bicycle'),
    ('Moped', 'Moped'),
    ('Segway', 'Segway'),
    ('Rollstuhl', 'Wheelchair')
GO

INSERT INTO dbo.FahrzeugKategorieZuordnung (fk_FahrzeugID, fk_KategorieID)
VALUES (1, 1),
       (1, 3),
       (2, 2),
       (3, 1)
GO