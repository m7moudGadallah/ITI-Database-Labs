# Lab2

> Access lab problems from _[here](./lab2.pdf)_

## Table of Content

<!-- TOC -->

- [Lab2](#lab2)
    - [Table of Content](#table-of-content)
    - [Part-0](#part-0)
    - [Part-1](#part-1)
        - [Problme 1.1](#problme-11)
        - [Problme 1.2](#problme-12)
        - [Problme 1.3](#problme-13)
        - [Problme 1.4](#problme-14)

<!-- /TOC -->

## Part-0

> Use Company_SD DB

Create the following schema and transfer the following tables to it

1. Company Schema
   1. Department table (Programmatically)
   2. Project table (visually)
2. Human Resource Schema
   1. Employee table (Programmatically)

```sql
use master
go

use Company_SD
go

create schema company
go

create schema Human_Resource
go

select * into company.Department
from Departments

select * into company.Project
from Project

select * into Human_Resource.Employee
from Employee
```

**_[&uarr; top](#table-of-content)_**

## Part-1

> Use ITI DB

### Problme 1.1

> Create a view that displays student full name, course name if the student has a grade more than 50

```sql
create view StudentsWithGradesOver50View as
select CONCAT(s.St_Fname, ' ', s.St_Lname) StudentName,
	c.Crs_Name as CourseName
from Student s
inner join Stud_Course sc
on s.St_Id = sc.St_Id
inner join Course c
on sc.Crs_Id = c.Crs_Id
where sc.Grade > 50;

select *
from StudentsWithGradesOver50View;
```

**_[&uarr; top](#table-of-content)_**

### Problme 1.2

> Create an Encrypted view that displays manager names and the topics they teach.

```sql
create view MangerTopicsView with encryption as
select i.Ins_Name as ManagerName,
	t.Top_Name TopicName
from Department d
inner join Instructor i
on d.Dept_Manager = i.Ins_Id
inner join Ins_Course ic
on i.Ins_Id = ic.Ins_Id
inner join Course c
on ic.Crs_Id = c.Crs_Id
inner join Topic t
on c.Top_Id = t.Top_Id;

select *
from MangerTopicsView;
```

**_[&uarr; top](#table-of-content)_**

### Problme 1.3

> Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department “use Schema binding” and describe what is the meaning of Schema Binding

```sql
create view InstructorDepartmnetsView with schemabinding as
select i.Ins_Name as InstructorName,
	d.Dept_Name as DepartmentName
from dbo.Instructor i
inner join dbo.Department d
on i.Dept_Id = d.Dept_Id
where d.Dept_Name in ('SD', 'Java');

select *
from InstructorDepartmnetsView;
```

> **Schema Binding**: is used to protect the data in a view. If a view is schema-bound, it can only be accessed by users who have the appropriate permissions to the schema in which the view is created.

**_[&uarr; top](#table-of-content)_**

### Problme 1.4

> Create a view “V1” that displays student data for student who lives in Alex or Cairo. **Note:** Prevent the users to run the following query Update V1 set st_address=’tanta’ Where st_address=’alex’.

```sql
create view V1 as
select *
from Student
where St_Address in ('Cairo', 'Alex');

select *
from V1;
```

**_[&uarr; top](#table-of-content)_**
