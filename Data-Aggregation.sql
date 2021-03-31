Select Count(*) as [Count]
From WizzardDeposits


Select Max(MagicWandSize) AS LongestWandSize
From WizzardDeposits


Select DepositGroup, MAX(MagicWandSize) AS MaxWandSize
From WizzardDeposits
Group by DepositGroup


Select TOP(2) DepositGroup, AVG(MagicWandSize) AS AVGWandSize
From WizzardDeposits
Group by DepositGroup     -- nai malkite sredni razmeri
Order by AVGWandSize


Select DepositGroup, Sum(DepositAmount) AS TotalDeposit
From WizzardDeposits
Group by DepositGroup


Select DepositGroup, Sum(DepositAmount) AS TotalDeposit
From WizzardDeposits
Where MagicWandCreator = 'Ollivander family'
Group by DepositGroup


Select DepositGroup, Sum(DepositAmount) AS TotalDeposit
From WizzardDeposits
Where MagicWandCreator = 'Ollivander family' 
Group by DepositGroup
Having Sum(DepositAmount) < 150000
Order by TotalDeposit desc



Select DepositGroup, MagicWandCreator, Min(DepositCharge) AS MinDepositCahrge
From WizzardDeposits
Group by MagicWandCreator, DepositGroup
Order by MagicWandCreator, DepositGroup


Select AgeGroupTable.AgeGroup, Count(AgeGroupTable.AgeGroup)
From(
Select Age , 
Case 
When Age between 0 and 10 THEN '[0-10]'
When Age Between 11 and 20 THEN '[11-20]'
When Age Between 21 and 30 THEN '[21-30]'
When Age Between 31 and 40 THEN '[31-40]'
When Age Between 41 and 50 THEN '[41-50]'
When Age Between 51 and 60 THEN '[51-60]'
Else '[61+]'
END AS AgeGroup
From WizzardDeposits
) AS AgeGroupTable
Group by AgeGroupTable.AgeGroup


Select LEFT(FirstName, 1 )
From WizzardDeposits
Where DepositGroup = 'Troll Chest'
Group by LEFT(FirstName, 1 )


Select DepositGroup, IsDepositExpired, AVG(DepositInterest)
From WizzardDeposits
Where DepositStartDate > '01/01/1985'
Group by DepositGroup, IsDepositExpired
Order by DepositGroup desc , IsDepositExpired 


-- SOFTUNI Database

Select DepartmentID, SUM(Salary)
From Employees
Group by DepartmentID

Select DepartmentID, MIN(Salary)
From Employees
Where DepartmentID IN (2,5,7)  AND HireDate > 01/01/2000
Group by DepartmentID



Select * INTO NewEmployeeTabe
From Employees
Where Salary > 30000 

Select * 
From NewEmployeeTabe

Delete From NewEmployeeTabe
Where ManagerID = 42

Update NewEmployeeTabe 
Set Salary += 5000    
Where DepartmentID = 1

Select DepartmentID, AVG(Salary)
From NewEmployeeTabe
Group by DepartmentID


Select DepartmentID, MAX(Salary) as maxSalary
From Employees
Group by DepartmentID
HAVING NOT MAX(Salary) between 30000 AND 70000

Select COUNT(Salary) AS CountSalary
From Employees
Where ManagerID IS NULL


Select ThirdRank.DepartmentID, ThirdRank.Salary
From(
Select DepartmentID,salary, DENSE_RANK() OVER (Partition by DepartmentID Order by Salary desc) AS RankSalary
From Employees) AS ThirdRank
Where ThirdRank.RankSalary = 3
Group by ThirdRank.DepartmentID, ThirdRank.Salary



