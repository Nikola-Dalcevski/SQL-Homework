use [master]
go

use SEDCHome
go

-- calculate the count of all grades in the sistem
select count(*) 
	from Grade
	go


-- calculate count of all grades per Teacher
select count(*) as [Count],
	te.FirstName,
	te.LastName
	from Grade as gr
	inner join Teacher as te on te.Id = gr.TeacherId 
	group by TeacherId, te.FirstName, te.LastName	
	go


	---- calculate count of all grades per Teacher for first 100 students
	select count(*) as [Count],
	te.FirstName,
	te.LastName
	from Grade as gr
	inner join Teacher as te on te.Id = gr.TeacherId 
	where StudentId <= 100
	group by TeacherId, te.FirstName, te.LastName	
	go


	--find the max and min grade per student
	select max(gr.grade) as MaxGrade,
		min(gr.grade) as MinGrade,
		st.FirstName,
		st.LastName
		from Grade as gr
		inner join Student as st on st.id = gr.StudentId
		group by st.FirstName, st.LastName
		go

	--calculate the count of all grades per teacher in the system and filter only grade count grater then 200
	select count(*) as [Count],
		te.FirstName,
		te.LastName
		from Grade as gr
		inner join Teacher as te on te.Id = gr.TeacherId 
		group by TeacherId, te.FirstName, te.LastName	
		Having count(*) > 200
		go


-- calcultae the count of all grades per techer for the first 100 students and filter teachers with mre than 50 grade count

	select count(*) as [Count],
		te.FirstName,
		te.LastName
		from Grade as gr
		inner join Teacher as te on te.Id = gr.TeacherId 
		where StudentId <= 100
		group by TeacherId, te.FirstName, te.LastName	
		Having count(*) > 50
		go


--Find the grade count, maximal grade and the average grade per student on all grades in the system. Filter only records where maximal grade is equal to average grade 
select count(*) as [count],
	max(Grade) as MaxGrade,
	avg(Grade) as AvgGrade,
	st.FirstName,
	st.LastName
	from Grade as gr
	right  join student as st on gr.studentId = st.id
	group by st.FirstName, st.LastName
	having max(Grade) = avg(Grade)
	go


	--create new view StudentGrades that will all studentsIds and count of Grades per student

create view vv_StudentsGrades
as
select StudentID,
	count(Grade) as studentGrade
	from Grade
	group by StudentID
	go

--change the view to show student first and last name instead of studentId

alter view vv_StudentsGrades
as
select 
	st.FirstName,
	st.LastName,
	count(Grade) as studentGradeCount

	from Grade as gr
	inner join Student as st on st.id = gr.StudentID
	group by st.FirstName,st.LastName
	go


-- list all rows from view ordered by biggest grade count

select * from vv_StudentsGrades
order by studentGradeCount desc
go


--create new view vv_studentGradeDetails that will list all students first and last name and count the coutses he passed through the exem


create view vv_StudentGradeDetails
as

select st.FirstName ,
	st.LastName,
	count(Grade) as CountOfGrades
	from Student as st
	inner join Grade as gr on st.ID = gr.StudentID
	inner join GradeDetails as gd on gr.ID = gd.GradeID
	where gd.AchievementTypeID = 5
	group by st.FirstName, st.LastName
	go
	




	