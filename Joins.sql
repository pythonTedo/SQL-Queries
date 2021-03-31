Select c.CountryName, MountainRange, PeakName, Elevation From Mountains AS m
JOIN Peaks AS p ON m.Id = p.MountainId  -- обединяват се 
JOIN MountainsCountries AS mc ON m.Id = mc.MountainId  -- междинна таблица за много към много
Join Countries AS c ON mc.CountryCode = c.CountryCode
Where m.MountainRange = 'Rila'
Order by p.Elevation desc

Select TOP(50) FirstName, LastName, t.Name, a.AddressText
From Employees AS e
Join Addresses AS a ON e.AddressID = a.AddressID
Join Towns AS t ON t.TownID = a.TownID
Order by FirstName, LastName


Select EmployeeID,FirstName, LastName, d.[Name] AS DepartmentName 
From Employees AS e
Join Departments AS d ON e.DepartmentID = d.DepartmentID
Where d.[Name] = 'Sales'
Order by EmployeeID

Select MIN(AvgSal.Salary)
From(
Select AVG(Salary) as Salary
From Employees
Group by DepartmentID) As AvgSal

-- Uprajneniq

Select Top(5) EmployeeID, JobTitle, e.AddressID, AddressText
From Employees AS e
Join Addresses AS a ON e.AddressID = a.AddressID
Order by AddressID


Select TOP(50) FirstName, LastName, t.[Name], a.AddressText
From Employees AS e
Join Addresses AS a ON e.AddressID = a.AddressID
Join Towns AS t ON a.TownID = t.TownID
Order by FirstName, LastName



Select EmployeeID, FirstName, LastName, d.[Name]
From Employees AS e
Join Departments AS d ON e.DepartmentID = d.DepartmentID
Where d.[Name] = 'Sales'
Order by EmployeeID



Select TOP(5) EmployeeID, FirstName, Salary, d.[Name]
From Employees AS e
Join Departments AS d ON e.DepartmentID = d.DepartmentID
Where Salary > 15000
Order by e.DepartmentID


Select TOP(3) e.EmployeeID, FirstName
From Employees AS e
Left Join EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
Where ep.EmployeeID IS NULL
Order by e.EmployeeID


Select FirstName, LastName, HireDate, d.[Name]
From Employees AS e
Join Departments AS d ON e.DepartmentID = d.DepartmentID  -- AND d.[Name] = 'Sales' AND d.[Name] = 'Finance'
Where HireDate > '1/1/1999' AND d.[Name] = 'Sales' OR d.[Name] = 'Finance'
Order by HireDate


Select TOP(5) e.EmployeeID, FirstName, p.[Name]
From Employees AS e
 Join EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
 Join Projects AS p ON ep.ProjectID = p.ProjectID
 Where p.StartDate > '08.13.2002' AND p.EndDate IS NULL



 Select e.EmployeeID, FirstName, 
   IIF(Year(StartDate) >= 2005, NULL, p.[Name]) AS ProjectName --- Ако е вярно и ако е грешно
From Employees AS e
     Right Join EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
     Right Join Projects AS p ON ep.ProjectID = p.ProjectID
Where e.EmployeeID = 24 


Select e.EmployeeID, e.FirstName, e.ManagerID, m.[FirstName] -- selfrefff
From Employees AS e 
Join Employees AS m ON m.EmployeeID = e.ManagerID
Where e.ManagerID IN (3,7)


Select TOP(50) e.EmployeeID, CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName, CONCAT_WS(' ', m.FirstName, m.LastName), d.[Name] AS DepartmentName
From Employees AS e
Join Employees AS m ON e.ManagerID = m.EmployeeID
Join Departments AS d ON e.DepartmentID = d.DepartmentID
Order by EmployeeID



Select MIN(TableAvg.avgSall)
From 
(Select AVG(Salary) As avgSall
From Employees
Group by DepartmentID) AS TableAvg

--- Geography

Select Countr.CountryCode, m.MountainRange, p.PeakName, p.Elevation
From Peaks AS p
Join Mountains AS m ON p.MountainId = m.Id
Join MountainsCountries AS mc ON m.Id = mc.MountainId
Join Countries AS Countr ON mc.CountryCode = Countr.CountryCode
Where Countr.CountryName = 'Bulgaria' AND Elevation > 2835
Order by Elevation desc


Select c.CountryCode, Count(MountainRange)
From Countries AS c
Join MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
Join Mountains AS m ON mc.MountainId = m.Id
Where c.CountryCode IN ('BG', 'RU', 'US')
Group by c.CountryCode

-- ИЛИ 

Select CountryCode, COUNT(MountainId)
From MountainsCountries
Where CountryCode IN ('US', 'RU', 'BG')
Group by CountryCode

-- ИЛИ

Select c.CountryCode, Count(MountainId)
From Countries AS c
Join MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
Where c.CountryCode IN ('BG', 'RU', 'US')
Group by c.CountryCode

Select k.ContinentCode, k.CurrencyCode, k.CurrencyUsage
From(
Select ContinentCode, CurrencyCode, Count(CurrencyCode) AS CurrencyUsage, DENSE_RANK() Over (Partition by ContinentCode Order by Count(CurrencyCode) DESC) AS RankingCur
From Countries
Group by ContinentCode, CurrencyCode
Having Count(CurrencyCode) > 1 -- poveche ot 2 durjavi da izpolzvat valutata
) AS k
Where k.RankingCur = 1
Order by ContinentCode, CurrencyCode


Select Count(*)
From Countries AS c
Left Join MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
Where mc.MountainId IS NULL



Select TOP(5) c.CountryName, MAX(p.Elevation) AS HighestPeak, MAX(r.Length) AS LongestRiver
From Countries AS c
LEFT Join MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT Join Mountains AS m ON mc.MountainId = m.Id
LEFT Join Peaks AS p ON m.Id = p.MountainId
LEFT Join CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT Join Rivers AS r ON cr.RiverId = r.Id
Group by c.CountryName
Order by HighestPeak desc, LongestRiver desc, CountryName


