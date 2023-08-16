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

<!-- /TOC -->

## Part-1

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
