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

### Problem 1.3

> Display number of courses for each topic name

```sql
select t.Top_Name as topic_name, count(c.Crs_Id) as num_of_courses
from Topic t left join  Course c
on t.Top_Id = c.Top_Id
group by t.Top_Name
```

**_[&uarr; top](#table-of-content)_**
