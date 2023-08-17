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
