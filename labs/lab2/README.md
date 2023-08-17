# Lab2

> Access lab problems from _[here](./lab2.pdf)_

## Table of Content

<!-- TOC -->

- [Lab2](#lab2)
  - [Table of Content](#table-of-content)
  - [Part-0](#part-0)

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
