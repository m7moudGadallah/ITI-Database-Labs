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
