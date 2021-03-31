Select *, HP + Attack + Defense + Speed AS Total, 
Case
 When (HP + Attack + Defense + Speed) < 400 Then 'weak'
 When (HP + Attack + Defense + Speed) > 400 Then 'Strong'
 Else 'Need more'
End AS Conditon
From pokemon_data
Where Legendary = 'True'
Order by Conditon

Select [Type 1], Sum(HP) AS SumHP, Sum(Attack) AS SumATT, Sum(Defense) AS SumDeff
From pokemon_data
Group by [Type 1]
Order by SumATT desc

alter table pokemon_data alter column HP int
alter table pokemon_data alter column Attack int
alter table pokemon_data alter column Defense int
alter table pokemon_data alter column Speed int

Select *
From pokemon_data
Where [Name] Like '%saur%'

Select * From pokemon_data
Where [Type 1] = 'Ghost'