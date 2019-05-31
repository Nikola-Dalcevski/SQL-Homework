use SEDCHome
go

--1 Declare scalar variable for storing FirstName variable
Declare @FirstName nvarchar(100)
Set @FirstName = 'Antonio'

select * 
	from Student
	where FirstName = @FirstName
	go

--2 Declare table variable that will contain StudentId, StudentName and DateOfBirth
Declare @StudentInfo table
(Id int, StudentName nvarchar(50),StudentLastName nvarchar(50),DateOfBirth date );

Insert into @StudentInfo
select id, FirstName, LastName, DateOfBirth
	from Student
	where Gender = 'F'
	
select * from @StudentInfo
go


--3 Declare temp table that will contain LastName and Wnrolled Date columns
Create Table #StudentList
(LastName nvarchar(50),EnrollDate date);


Insert into #StudentList
select LastName, EnrolledDate
	from Student
	where Gender = 'M' and FirstName like 'A%'

select * 
	from #StudentList
	where LEN(LastName) = 7
	go


--4 Find all tecehers whose FirstName length is less than 5

select * 
	from Teacher
	where LEN(FirstName) <= 5 AND LEFT(FirstName,3) = RIGHT(FirstName,3)
	go


--5 Declare Scalr function formatStudentName for retriving the student description for specific Student Id
Create Function dbo.fn_FormatStudentName (@StudentId int)
Returns nvarchar(100)
	as
	begin
		declare @output nvarchar(100)
		select @output = SUBSTRING(StudentCardNumber,4,LEN(StudentCardNumber)) + '-' + LEFT(FirstName,1) + '-' + LastName
		from Student
		where @StudentId = Id
		return @output
	end
	go

	select * ,dbo.fn_FormatStudentName(Id) as FormatStName
	from Student
	go

-- Create multi-statement table value function that for spcigic Teacher and course will rreturn list of students whoe passed the exam, together with Grade and CreatedDate

Create Function dbo.fn_PassedExam(@TeacherId int, @CourseId int )
Returns @output Table (FirstName nvarchar(50), LastName nvarchar(50), Grade tinyint, CreatedDate date )
	as
	Begin

	Insert into @output
	select st.FirstName, st.LastName, gr.Grade, gr.CreatedDate
		from Student as st
		inner join Grade as gr on st.Id = gr.StudentID
		where gr.TeacherID = @TeacherId and gr.CourseID = @CourseId
		return
	end
	go


	select * from dbo.fn_PassedExam(81,40)





