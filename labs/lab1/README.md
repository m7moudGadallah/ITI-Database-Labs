# Lab1

> Access lab problems from _[here](./lab1.pdf)_

## Table of Content

<!-- TOC -->

- [Lab1](#lab1)
    - [Table of Content](#table-of-content)
    - [Part-1](#part-1)
        - [Problem 1.1](#problem-11)
        - [Problem 1.2](#problem-12)
        - [Problem 1.3](#problem-13)
        - [Problem 1.4](#problem-14)
        - [Problem 1.5](#problem-15)
        - [Problem 1.6](#problem-16)
    - [Part-2](#part-2)
        - [Problem 2.1](#problem-21)
        - [Problem 2.2](#problem-22)
        - [Problem 2.3](#problem-23)
        - [Problem 2.4](#problem-24)
        - [Problem 2.5](#problem-25)
        - [Problem 2.6](#problem-26)
    - [Part-3](#part-3)
        - [Problem 3.1](#problem-31)
        - [Problem 3.2](#problem-32)
        - [Problem 3.3](#problem-33)
        - [Problem 3.4](#problem-34)

<!-- /TOC -->

## Part-1

> Use ITI DB

### Problem 1.1

> Display instructor Name and Department Name
> Note: display all the instructors if they are attached to a department or not

```sql
select i.Ins_Name as instructor_name, d.Dept_Name as department_name
from Instructor i left join Department d
on i.Dept_Id = d.Dept_Id
```

**_[&uarr; top](#table-of-content)_**

### Problem 1.2

> Display student full name and the name of the course he is taking For only courses which have a grade

```sql
select CONCAT(s.St_Fname, ' ', s.St_Lname) as student_fullname,
		c.Crs_Name as course_name
from Student s inner join Stud_Course sc
on  s.St_Id = sc.St_Id
inner join Course c
on sc.Crs_Id = c.Crs_Id
where sc.Grade is not null
```

**_[&uarr; top](#table-of-content)_**

### Problem 1.3

> Display number of courses for each topic name

```sql
select t.Top_Name as topic_name, count(c.Crs_Id) as num_of_courses
from Topic t left join  Course c
on t.Top_Id = c.Top_Id
group by t.Top_Name
```

**_[&uarr; top](#table-of-content)_**

### Problem 1.4

> Display max and min salary for instructors

```sql
select min(Salary) as min_salary, max(Salary) as max_salary
from Instructor
```

**_💡Note_**:
All Salaries is null so output will be (null, null) so I filled table with this query

```sql
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
```

**_[&uarr; top](#table-of-content)_**

### Problem 1.5

> Display instructors who have salaries less than the average salary of all instructors

```sql
select *
from Instructor
where Salary < (
	select avg(Salary) from Instructor
)
```

**_[&uarr; top](#table-of-content)_**

### Problem 1.6

> Display the Department name that contains the instructor who receives the minimum salary.

```sql
select d.Dept_Name as department_name
from Department d inner join(select top(1) with ties *
from Instructor
order by Salary) as nw
on d.Dept_Id = nw.Dept_Id
order by d.Dept_Id
```

**_[&uarr; top](#table-of-content)_**

## Part-2

> Use AdventureWorks DB

### Problem 2.1

> Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate SalesOrders that occurred within the period ‘7/28/2008’ and ‘7/29/2014’

```sql
select SalesOrderID, ShipDate
from sales.SalesOrderHeader
where OrderDate between '7/28/2008' and '7/29/2014'
```

**_[&uarr; top](#table-of-content)_**

### Problem 2.2

> Display only Products with a StandardCost below $110.00 (show ProductID, Name only)

```sql
select ProductID, Name
from Production.Product
where StandardCost < 110.00
```

**_[&uarr; top](#table-of-content)_**

### Problem 2.3

> Display ProductID, Name if its weight is unknown

```sql
select ProductID, Name
from Production.Product
where Weight is null
```

**_[&uarr; top](#table-of-content)_**

### Problem 2.4

> Display all Products with a Silver, Black, or Red Color

```sql
select *
from Production.Product
where Color in ('Silver', 'Black', 'Red')
```

**_[&uarr; top](#table-of-content)_**

### Problem 2.5

> Display any Product with a Name starting with the letter B

```sql
select *
from Production.Product
where Name like 'B%'
```

**_[&uarr; top](#table-of-content)_**

### Problem 2.6

> Transfer the rowguid ,FirstName, SalesPerson from Customer table in a newly created table named [customer_Archive] updated

**_💡Note_**

> In this requirement, there is no column called SalesPerson in the customer table and also no relation between them so it may be a mistake so lets negligee this mistake

```sql
select c.rowguid, p.FirstName into customer_Archive
from Sales.Customer c inner join Person.Person p
on c.PersonID = p.BusinessEntityID
```

**_[&uarr; top](#table-of-content)_**

## Part-3

> Use Company_SD DB

### Problem 3.1

> Display the Department id, name and SSN and the name of its manager.

```sql
select d.Dnum as department_id, d.Dname as department_name,
		d.MGRSSN as manager_ssn, CONCAT(e.Fname, ' ', e.Lname) as manager_fullname
from Departments d inner join Employee e
on d.MGRSSN = e.SSN
```

**_[&uarr; top](#table-of-content)_**

### Problem 3.2

> Display the name of the departments and the name of the projects under its control.

```sql
select p.Pname as project_name, d.Dname as department_name
from Project p inner join Departments d
on p.Dnum = d.Dnum
order by department_name
```

**_[&uarr; top](#table-of-content)_**

### Problem 3.3

> display all the employees in department 30 whose salary from 1000 to 2000 LE monthly.

```sql
select *
from Employee
where Dno = 30 and (Salary between 1000 and 2000)
order by Salary
```

**_[&uarr; top](#table-of-content)_**

### Problem 3.4

> Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.

```sql
select CONCAT(e.Fname, ' ', e.Lname) as employee_fullname
from Employee e inner join Works_for w
on e.SSN = w.ESSn
inner join Project p
on w.Pno = p.Pnumber
where e.Dno = 10 and w.Hours >= 10 and p.Pname = 'AL Rabwah'
```

**_[&uarr; top](#table-of-content)_**
