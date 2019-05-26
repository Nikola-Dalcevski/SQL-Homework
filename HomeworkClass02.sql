use [master]
GO

use SEDCHome
GO


-- find all students whit first name Antonio
select * 
	from Student
	where FirstName = 'Antonio'
	go


-- find all students with date of bird greater than 01.01.1999
select *
	from Student
	where DateOfBirth > '1999-01-01'
	go


-- find all male students
select *
	from Student
	where Gender = 'M'
    go

-- find all students whit LastName  starting with T
select *
	from Student
	where LastName like 'T%'
	go

-- find all students that enrolled in january/1998
select * 
	from Student
	where EnrolledDate > '1998-01-01' and EnrolledDate < '1998-01-31'
	go

-- find all students with LastName starting With J enrolled in januery 1998
select *
	from Student
	where (LastName like 'T%') and (EnrolledDate > '1998-01-01' and EnrolledDate < '1998-01-31')
	go

-- find all students with first name Antonio ordered by last name
select * 
	from Student
	where FirstName = 'Antonio'
	order by LastName
	go

-- list all students by first name
select *
	from Student
	order by FirstName
	go

-- find all Male students ordered by Enrolled date, starting from the last enrolled
select *
	from Student
	where Gender = 'M'
	order by EnrolledDate desc
	go


-- list all Teacher First name and student first names in single result set whit duplicates
select FirstName
	from Teacher
	union all
select FirstName
	from Student
	go

	
-- list all Teacher Last names nas student last names in single result . remuve duplicates
select LastName
	from Teacher
	union
select LastName
	from Student
	go


-- list all common first names for techers and students
select FirstName
	from Teacher
	intersect
select FirstName
	from Student
	go



-- Chande DradeDetaild table always to insert vqalur 100 in AchibementMacPoints column if no value is provided on insert
alter table GradeDetails with check
add constraint DF_GradeDetails_AchievementMaxPoints Default 100 for AchievementMaxPoints
go

--Change GradeDetails table to prevent inserting AchievementPoints that will more than achibementMaxPoints
alter table GradeDetails with check
add constraint CH_GradeDetails_AchieventPoints check (AchievementPoints <= AchievementMaxPoints)
go

--Change AchivementType table to guarantee unique names axross the achiuevement types
alter table AchievementType 
add constraint UN_AchievementType unique (name)
go


-- make foreign key
alter table Grade add constraint FK_Grade_Student foreign key (StudentId) references Student(Id)
alter table Grade add constraint FK_Grade_Couse foreign key (CourseId) references Course(Id)
alter table Grade add constraint FK_Grade_Teacher foreign key (TeacherId) references Student(ID)
alter table GradeDetails add constraint FK_GradeDetails_Grade foreign key (GradeId) references  Grade(Id)
alter table GradeDetails add constraint FK_GradeDetails_AchievementType foreign key (AchievementTypeId) references AchievementType(Id)
go

-- list all possible combinations of courses names and achievementType names that can be passed by student
select c.[Name], ach.[Name]
	from course as c
	cross join AchievementType as Ach
	go
	

-- list all Teachers that has any exam Grade
select distinct  
	te.FirstName,
	te.LastName
from Teacher as te
inner join Grade as gr on te.id = gr.TeacherId
order by FirstName
go


--List teachers without exem grade
select *
	from Teacher as te
	left join Grade as gr on gr.teacherId = te.Id
	where gr.TeacherId is null
	go


--list all students without exem Grade (right join)
select st.*
	from Grade as gr
	right join Student as st on gr.studentId = st.id
	where gr.studentId is null 
	go

