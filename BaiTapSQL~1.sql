-- faculty (Khoa trong tr??ng)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);
-- subject (M�n h?c)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- t?ng s? ti?t h?c
);
-- student (Sinh vi�n)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- gi?i t�nh
	birthday date not null,
	hometown nvarchar2(100) not null, -- qu� qu�n
	scholarship number, -- h?c b?ng
	faculty_id number not null constraint faculty_id references faculty(id) -- m� khoa
);
-- exam management (B?ng ?i?m)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- s? l?n thi (thi tr�n 1 l?n ???c g?i l� thi l?i) 
	mark number(4,2) not null -- ?i?m
);

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'C? s? d? li?u', 45);
insert into subject values (2, n'Tr� tu? nh�n t?o', 45);
insert into subject values (3, n'Truy?n tin', 45);
insert into subject values (4, n'?? h?a', 60);
insert into subject values (5, n'V?n ph?m', 45);

-- faculty
insert into faculty values (1, n'Anh - V?n');
insert into faculty values (2, n'Tin h?c');
insert into faculty values (3, n'Tri?t h?c');
insert into faculty values (4, n'V?t l�');

-- student
insert into student values (1, n'Nguy?n Th? H?i', n'N?', to_date('19900223', 'YYYYMMDD'), 'H� N?i', 130000, 2);
insert into student values (2, n'Tr?n V?n Ch�nh', n'Nam', to_date('19921224', 'YYYYMMDD'), 'B�nh ??nh', 150000, 4);
insert into student values (3, n'L� Thu Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'L� H?i Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Tr?n Anh Tu?n', n'Nam', to_date('19901220', 'YYYYMMDD'), 'H� N?i', 180000, 1);
insert into student values (6, n'Tr?n Thanh Mai', n'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Ph�ng', null, 3);
insert into student values (7, n'Tr?n Th? Thu Th?y', n'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Ph�ng', 10000, 1);

-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);


--A BASIC QUERY
-- Cau 1a Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t? id t?ng d?n:
SELECT * FROM student ORDER BY student.id;

-- Cau 1b Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t? gi?i t�nh:
SELECT * FROM student ORDER BY student.gender;

-- Cau 1c Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t? ng�y sinh T?NG D?N v� h?c b?ng GI?M D?N:
SELECT * FROM student ORDER BY student.birthday ASC , student.scholarship DESC;

-- Cau 2 M�n h?c c� t�n b?t ??u b?ng ch? 'T'
SELECT subject.name FROM subject WHERE subject.name LIKE 'T%';

-- Cau 3 Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'
SELECT student.name FROM student WHERE student.name LIKE '%i';

-- Cau 4 Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'
SELECT faculty.name  FROM faculty where faculty.name like '_n%';

-- Cau 5 Sinh vi�n trong t�n c� t? 'Th?'
SELECT student.name FROM student WHERE student.name LIKE '%Th?%';

-- Cau 6 Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n
SELECT student.name FROM student WHERE student.name BETWEEN 'A' and 'M' GROUP BY student.name;

-- Csu 7 Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n
select student.name, student.scholarship , student.faculty_id from student where student.scholarship > 100000 order by faculty_id desc;

-- Cau 8 Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i
select student.name, student.scholarship,student.hometown from student where student.scholarship > 150000 and student.hometown = 'H� N?i';

-- Cau 9 Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992
select student.name , student.birthday from student WHERE student.birthday BETWEEN TO_DATE('01/01/1991','DD/MM/YYYY') and TO_DATE('05/06/1992','DD/MM/YYYY');

-- Cau 10 Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000
select * from student where student.scholarship between 80000 and 150000;

-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45
select subject.name , subject.lesson_quantity from Subject WHERE subject.lesson_quantity BETWEEN 30 and 45;


-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
		-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr? 
		-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.
		
-- 2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng
select count(id)as SUM_Student from Student ;

-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.
select student.gender, count(id)as sumGender from student GROUP BY student.gender;

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa
select faculty.name , count(student.id)  from student , faculty where faculty.id = student.id group by faculty.name;
-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c
select subject.name, count(exam_management.student_id) from exam_management, subject where subject.id = exam_management.subject_id group by subject.name;
-- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c
select student_id, count(subject_id) from exam_management group by student_id;
-- 7. T?ng s? h?c b?ng c?a m?i khoa	
select faculty.name , count(student.scholarship) from faculty , student where student.faculty_id = faculty.id GROUP by faculty.name;
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty.name , max(student.scholarship) from faculty , student  where student.faculty_id = faculty.id GROUP by faculty.name;
-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa
select faculty.name, gender, count(student.id) total from student, faculty where gender = 'Nam' and faculty.id = student.faculty_id group by faculty.name, gender
union
select faculty.name, gender, count(student.id) total from student, faculty where gender = 'N?' and faculty.id = student.faculty_id group by faculty.name, gender;
-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i
select student.birthday , count (student.id) from student group by student.birthday;
-- 11. Cho bi?t nh?ng n?i n�o c� �t nh?t 2 sinh vi�n ?ang theo h?c t?i tr??ng
select student.hometown , count (student.id) from student GROUP by student.hometown having count(student.id)>2;
-- 12. Cho bi?t nh?ng sinh vi�n thi l?i �t nh?t 2 l?n
select student.name , exam_management.subject_id , count (exam_management.number_of_exam_taking)
from student , exam_management
where student.id = exam_management.student_id
GROUP by student.name, exam_management.subject_id
having count (exam_management.number_of_exam_taking)>=2;
-- 13. Cho bi?t nh?ng sinh vi�n nam c� ?i?m trung b�nh l?n 1 tr�n 7.0 
select student.name , avg(exam_management.mark) 
from student , exam_management
where student.id = exam_management.id and exam_management.number_of_exam_taking = 1 and student.gender ='Nam'
group by student.name
having avg(exam_management.mark) >7;
-- 14. Cho bi?t danh s�ch c�c sinh vi�n r?t �t nh?t 2 m�n ? l?n thi 1 (r?t m�n l� ?i?m thi c?a m�n kh�ng qu� 4 ?i?m)
select student.name 
from student , exam_management
where student.id = exam_management.id and exam_management.number_of_exam_taking = 1 and exam_management.mark <=4
group by student.name;

-- 15. Cho bi?t danh s�ch nh?ng khoa c� nhi?u h?n 2 sinh vi�n nam
select faculty.name , count(student.gender)
from student , faculty
where student.faculty_id = faculty.id and student.gender ='Nam'
group by faculty.name
having count(student.gender) >2;

-- 16. Cho bi?t nh?ng khoa c� 2 sinh vi�n ??t h?c b?ng t? 200000 ??n 300000
select faculty.name , count(student.id)
from student , faculty
where  student.scholarship BETWEEN 200000 and 300000
group by faculty.name
having count(student.id) > 2;

-- 17. Cho bi?t sinh vi�n n�o c� h?c b?ng cao nh?t
select student.name , max(student.scholarship)
from student 
where student.scholarship = (select max(student.scholarship) from student)
GROUP by student.name;

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh vi�n c� n?i sinh ? H� N?i v� sinh v�o th�ng 02

-- 2. Sinh vi�n c� tu?i l?n h?n 20

-- 3. Sinh vi�n sinh v�o m�a xu�n n?m 1990



-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh s�ch c�c sinh vi�n c?a khoa ANH V?N v� khoa V?T L�

-- 2. Nh?ng sinh vi�n nam c?a khoa ANH V?N v� khoa TIN H?C

-- 3. Cho bi?t sinh vi�n n�o c� ?i?m thi l?n 1 m�n c? s? d? li?u cao nh?t

-- 4. Cho bi?t sinh vi�n khoa anh v?n c� tu?i l?n nh?t.

-- 5. Cho bi?t khoa n�o c� ?�ng sinh vi�n nh?t

-- 6. Cho bi?t khoa n�o c� ?�ng n? nh?t

-- 7. Cho bi?t nh?ng sinh vi�n ??t ?i?m cao nh?t trong t?ng m�n

-- 8. Cho bi?t nh?ng khoa kh�ng c� sinh vi�n h?c

-- 9. Cho bi?t sinh vi�n ch?a thi m�n c? s? d? li?u

-- 10. Cho bi?t sinh vi�n n�o kh�ng thi l?n 1 m� c� d? thi l?n 2