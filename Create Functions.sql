Create OR ALTER Function udf_AverageSalByDepartment(@DepartmentName nvarchar(50)) -- ako sushtestvura shte go promeni ako ne create
Returns Table 
AS 
Return
(
Select d.DepartmentID, d.[Name] AS Department, AVG(e.Salary) AS average
From Departments AS d
Join Employees AS e ON d.DepartmentID = e.DepartmentID
WHERE [Name] = @DepartmentName
Group by d.DepartmentID, d.[Name]
)
Select *
From dbo.udf_AverageSalByDepartment('Sales')

-------------------------------------------------------------------------------------------------------------------------------------------
Create OR ALTER  FUNCTION udf_EmployeeListByDepartment(@depName nvarchar(20))   -- tablica result koqto e promenliva
Returns @result Table(
        FirstName nvarchar(50) NOT NULL,                              -- izrejdame kolonite v tablicata
		LastName nvarchar(50) NOT NULL,
		DepartmentName nvarchar(50) NOT NULL ) AS
BEGIN
   With Employees_CTE (FirstName, LastName, DepartmentName)
   AS(
      Select e.FirstName, e.LastName, d.[Name]
	  From Employees AS e
	  Left Join Departments AS d ON e.DepartmentID = d.DepartmentID)

   INSERT INTO @result SELECT FirstName, LastName, DepartmentName  
     From Employees_CTE Where DepartmentName = @depName
	Return
END

Select * 
FROM dbo.udf_EmployeeListByDepartment('Production')

----------------------------------------------------------------------------------------------------------------------------------------
Create OR ALTER Function udf_GetSalaryLevel(@Salary MONEY) -- ako sushtestvura shte go promeni ako ne create
Returns varchar(10)
AS 
BEGIN
  DECLARE @result varchar(10);
  IF (@Salary < 30000)
    SET @result = 'Low'
  Else IF (@Salary <= 50000 AND @Salary > 30000) 
    SET @result = 'Average'
  Else 
     SET @result = 'High'
  RETURN @result
END

Select FirstName, LastName, Salary, dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel
From Employees


Create OR Alter PROCEDURE usp_GetSeniorEmpl @YearsOfService INT = 5  -- defaut stoinost
AS
 Select FirstName, LastName, HireDate, DATEDIFF(YEAR, HireDate, GETDATE()) AS YEAS
 From Employees 
 Where DATEDIFF(YEAR, HireDate, GETDATE()) > @YearsOfService
 Order by HireDate

 Exec dbo.usp_GetSeniorEmpl 18  -- stormnati proceduri

 --------------------------------------------------------------------------------------------------------
 Create Proc usp_AddNumbers
      @FirstNumber INT,
	  @SecontNumber INT,
	  @Result INT OUT
AS
  SET @Result = @FirstNumber + @SecontNumber


Declare @res int
EXEC usp_AddNumbers 8, 12, @res OUT
Select @res AS Result