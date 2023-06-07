---------------------------------------------------------------
------------- Testing Stored Procedures/Functions -------------
---------------------------------------------------------------

-- Test Stored Procedure 1: Get all rentals for a specific customer
EXEC dbo.GetRentalsByCustomer @CustomerID = 1

-- Test Stored Procedure 2: Get the total number of rentals for each customer
EXEC dbo.GetTotalRentalsByCustomer

-- Test Stored Function 1: Calculate the total price for a rental
DECLARE @RentalID INT = 1
SELECT dbo.CalculateRentalPrice(@RentalID) AS TotalPrice

-- Test Stored Function 2: Get the average rental duration in days for a customer
DECLARE @CustomerID INT = 2
SELECT dbo.GetAverageRentalDuration(@CustomerID) AS AverageDuration