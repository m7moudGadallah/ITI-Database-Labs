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