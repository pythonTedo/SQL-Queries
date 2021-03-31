Select FirstName, LastName
From Employees
Where FirstName LIKE 'SA%'

Select FirstName, LastName
From Employees
Where LastName LIKE '%ei%'

Select FirstName 
From Employees
Where DepartmentID in (3,10) and YEAR(HireDate) Between 1995 and 2005

Select FirstName, LastName
From Employees
Where Not JobTitle = '%engineer%'

Select [Name]
From Towns
Where Len(Name) in (5,6)
Order by Name

Select [Name]
From Towns
Where [Name] Like '[M,k,B,E]%'
Order by [Name]


Create View V_EmployeesHiredAfter2000 As
Select FirstName, LastName
From Employees
Where YEAR(HireDate) > 2000

Select * From V_EmployeesHiredAfter2000


Select FirstName, LastName
From Employees
Where LEN(LastName) = 5


Select EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (Partition by Salary ORDER BY EmployeeID)
From Employees
Where Salary BETWEEN 10000 and 50000 
Order by Salary desc

Select RankBY2.EmployeeID,RankBY2.FirstName, RankBY2.LastName, RankBY2.Salary, RankBY2.ranking
From
(Select EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (Partition by Salary ORDER BY EmployeeID) AS ranking
From Employees
Where Salary BETWEEN 10000 and 50000 
) AS RankBY2
Where RankBY2.ranking = 2
Order by Salary desc

-- Geography

Select CountryName, IsoCode
From Countries
Where CountryName LIKE '%a%a%a%'
Order by IsoCode

Select PeakName, RiverName, LOWER(PeakName + Substring(RiverName,2,LEN(RiverName))) AS MIX
From Peaks, Rivers
Where Lower(RIGHT(PeakName,1)) = Lower(LEFT(RiverName, 1))
ORDER BY MIX

-- DIABLO

Select TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') as [datetime]
From Games
Where YEAR([Start]) IN (2011,2012)
Order by [datetime] 

Select Username, SUBSTRING(Email,CHARINDEX('@',Email), LEN(Email))
From Users


Select Name, 
CASE
    WHEN DATEPART(HOUR,Start) >= 0 AND DATEPART(HOUR,Start) <12 THEN 'Morning'
	WHEN DATEPART(HOUR,Start) >= 12 AND DATEPART(HOUR,Start) <18 THEN 'Afternoon'
	WHEN DATEPART(HOUR,Start) >= 18 AND DATEPART(HOUR,Start) < 24 THEN 'Evening'
END AS 'Part of day'
Case 
    When Duration =< 3 THEN 'Extra short'
	When Duration >3  AND Duration =< 6 THEN 'Short'
	When Duration >6  THEN 'Long'
	When Duration IS NULL  THEN 'Extra Long'
End as 'Duration'

From Games
Order by Name, Duration, [Part of the day]