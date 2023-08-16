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

/*
	Transfer the rowguid ,FirstName, SalesPerson from Customer table in a 
	newly created table named [customer_Archive] updated
*/
select c.rowguid, p.FirstName into customer_Archive
from Sales.Customer c inner join Person.Person p
on c.PersonID = p.BusinessEntityID

/*--------------------------------((Part3))----------------------------------*/
use master
go

use Company_SD
go

/*
	Display the Department id, name and SSN and the name of its manager.
*/
select d.Dnum as department_id, d.Dname as department_name, 
		d.MGRSSN as manager_ssn, CONCAT(e.Fname, ' ', e.Lname) as manager_fullname
from Departments d inner join Employee e
on d.MGRSSN = e.SSN

/*
	Display the name of the departments and the name of the projects under 
	its control.
*/
select p.Pname as project_name, d.Dname as department_name
from Project p inner join Departments d
on p.Dnum = d.Dnum
order by department_name

/*
	display all the employees in department 30 whose salary from 1000 to 2000 
	LE monthly.
*/
select *
from Employee
where Dno = 30 and (Salary between 1000 and 2000)
order by Salary

/*
	Retrieve the names of all employees in department 10 
	who works more than or equal 10 hours per week on "AL Rabwah" project.
*/
select CONCAT(e.Fname, ' ', e.Lname) as employee_fullname
from Employee e inner join Works_for w
on e.SSN = w.ESSn
inner join Project p
on w.Pno = p.Pnumber
where e.Dno = 10 and w.Hours >= 10 and p.Pname = 'AL Rabwah'

/*
	Find the names of the employees who directly supervised
	with Kamel Mohamed.
*/
select CONCAT(Fname, ' ', Lname) as employee_fullname
from Employee
where Superssn = (
	select SSN
	from Employee
	where CONCAT(Fname, ' ', Lname) = 'Kamel Mohamed'
)

/*
	Retrieve the names of all employees and the names of the projects
	they are working on, sorted by the project name.
*/
select CONCAT(e.Fname, ' ', e.Lname) as employee_fullname, p.Pname project_name
from Employee e, Works_for w, Project p
where e.SSN = w.ESSn and w.Pno = p.Pnumber
order by project_name

/*
	For each project located in Cairo City , find the project number, the 
	controlling department name ,the department manager last name ,address 
	and birthdate
*/
select p.Pname as project_name, p.Pnumber as project_number,
		d.Dname as department_name, e.Lname as department_manager_lastname,
		e.Address as manager_address, e.Bdate as manager_birthdate
from Project p inner join Departments d
on p.Dnum = d.Dnum
inner join Employee e
on d.MGRSSN = e.SSN
where p.City = 'Cairo'

/*
  Display All Data of the mangers*/select e.*from Departments d inner join Employee eon d.MGRSSN = e.SSN/*	Display All Employees data and the data of their dependents even
	if they have no dependents*/select e.*, d.*from Employee e left join Dependent don e.SSN = d.ESSN