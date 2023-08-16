/*--------------------------------((Part1))----------------------------------*/
use master
go

use ITI
go

/*
	Display instructor Name and Department Name
	Note: display all the instructors if they are attached to a department or not
*/
select i.Ins_Name as instructor_name, d.Dept_Name as department_name
from Instructor i left join Department d
on i.Dept_Id = d.Dept_Id

/*
	Display student full name and the name of the course he is taking
	For only courses which have a grade 
*/
select CONCAT(s.St_Fname, ' ', s.St_Lname) as student_fullname, 
		c.Crs_Name as course_name
from Student s inner join Stud_Course sc
on  s.St_Id = sc.St_Id
inner join Course c
on sc.Crs_Id = c.Crs_Id
where sc.Grade is not null

/*
	Display number of courses for each topic name
*/
select t.Top_Name as topic_name, count(c.Crs_Id) as num_of_courses
from Topic t left join  Course c
on t.Top_Id = c.Top_Id
group by t.Top_Name


/*
	fill salaries
*/
with tmp_instructor as(
	select *, NTILE(5) over(partition by dept_id order by Ins_id) as nt
	from Instructor where Salary is null
)

--select * from tmp_instructor

update tmp_instructor
	set salary =
		case
			when nt = 1 then 2500
			when nt = 2 then 4000
			when nt = 3 then 6000
			when nt = 4 then 7000
			else 10000
		end

select * from Instructor

--update Instructor set Salary = null

/*
	Display max and min salary for instructors
*/
select min(Salary) as min_salary, max(Salary) as max_salary
from Instructor

/*
	Display instructors who have salaries less than the average salary of all 
	instructors.
*/
select *
from Instructor
where Salary < (
	select avg(Salary) from Instructor
)

/*
	 Display the Department name that contains the instructor who receives the 
	 minimum salary.
*/
select d.Dept_Name as department_name
from Department d inner join(select top(1) with ties *
from Instructor
order by Salary) as nw
on d.Dept_Id = nw.Dept_Id
order by d.Dept_Id

/*--------------------------------((Part2))----------------------------------*/
use master
go

use AdventureWorks2012
go

/*
 Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema)
 to designate SalesOrders that occurred within the period ‘7/28/2008’ and ‘7/29/2014’
*/
select SalesOrderID, ShipDate
from sales.SalesOrderHeader
where OrderDate between '7/28/2008' and '7/29/2014'

/*
	Display only Products with a StandardCost below $110.00 (show ProductID, Name only)
*/
select ProductID, Name
from Production.Product
where StandardCost < 110.00

/*
	Display ProductID, Name if its weight is unknown
*/
select ProductID, Name
from Production.Product
where Weight is null

/*
	Display all Products with a Silver, Black, or Red Color
*/
select *
from Production.Product
where Color in ('Silver', 'Black', 'Red')

/*
	Display any Product with a Name starting with the letter B
*/
select *
from Production.Product
where Name like 'B%'
