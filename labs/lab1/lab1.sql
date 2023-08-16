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
