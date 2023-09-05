/*
1. Create the following schema and transfer the following tables to it 
	a. Company Schema 
		i. Department table (Programmatically)
		ii. Project table (visually)
	b. Human Resource Schema
		i. Employee table (Programmatically)
*/
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


/*---------------------------------((Part1))---------------------------------*/
use master
go

use ITI
go

/*
	Create a view that displays student full name, course name if 
	the student has a grade more than 50.
*/
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
go

/*
	Create an Encrypted view that displays manager names and 
	the topics they teach.
*/
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

/*
	Create a view that will display Instructor Name, Department Name for the ‘SD’ 
	or ‘Java’ Department “use Schema binding” 
	and describe what is the meaning of Schema Binding
*/
create view InstructorDepartmnetsView with schemabinding as
select i.Ins_Name as InstructorName,
	d.Dept_Name as DepartmentName
from dbo.Instructor i
inner join dbo.Department d
on i.Dept_Id = d.Dept_Id
where d.Dept_Name in ('SD', 'Java');

select *
from InstructorDepartmnetsView;
