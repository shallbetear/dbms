--1) pl/sql fibo
set serveroutput on;
declare
first int := 0; 
second int := 1; 
temp int; 
n int := 10; 
i int; 
begin
	dbms_output.put_line('Series:'); 
	dbms_output.put_line(first); 
	dbms_output.put_line(second); 
	for i in 2..n 
	loop 
		temp:=first+second; 
        first := second; 
        second := temp; 
        dbms_output.put_line(temp); 
    end loop; 
end;

------------------------------------------------------------------------------------------------------------------------------------
--2) pl/sql add two numbers
set serveroutput on;
declare
x int:=10;             
y int:=20;            
z int;        
begin                
  z:=x+y;                 
  dbms_output.put_line('Sum is '||z); 
end;

------------------------------------------------------------------------------------------------------------------------------------
--3) pl/sql swap 2 numbers
set serveroutput on;
declare
	n1 int:=1000; 
	n2 int:=2000; 
	temp int; 
begin
	dbms_output.put_line('before'); 
	dbms_output.put_line('num1 = '|| n1 ||' num2 = '|| n2); 
	temp := n1; 
	n1 := n2; 
	n2 := temp; 
	dbms_output.put_line('after'); 
	dbms_output.put_line('num1 = '|| n1 ||' num2 = '|| n2); 
end;

------------------------------------------------------------------------------------------------------------------------------------
--4) pl/sql max of numbers
set serveroutput on;
declare
    a int := 46;
    b int := 67;
begin
    if a > b then
        dbms_output.put_line('Greatest number is ' || a);
    else
        dbms_output.put_line('Greatest number is ' || b);
    end if;
end;

------------------------------------------------------------------------------------------------------------------------------------
--table creation:
create table student (
    reg_no int primary key,
    name varchar(50),
    dept varchar(20),
    city varchar(20),
    ph_no int
);
insert into student values (1, 'saara', 'AI', 'tirupur', 456789);
insert into student values (2, 'laara', 'EEE', 'coimbatore', 123456);
insert into student values (3, 'caara', 'ECE', 'coimbatore', 345789);
insert into student values (4, 'meera', 'BME', 'erode', 124566);
select * from student;

--5) drop ddl command
drop table student;

--6) truncate ddl command
truncate table student;
select * from student;

--7) alter ddl command
alter table student add salary varchar(20);
alter table student modify salary int;
alter table student drop dolumn salary;
alter table student add constraint con_ph_no unique(ph_no);
select * from student;

--8) delete dml command
delete from student where dept='AI';
select * from student;

--9) select dml command
select name,ph_no from student;

--10) update dml command
update student set city='tirupur' where reg_no=2;
select * from student;

--11) & 13) nested queries (retrieve, select)
select * from student where dept in ( select dept from student where city = 'coimbatore' );

--12) left join right join
create table course (
    c_id int primary key,
    c_name varchar(50),
    reg_no int,
    constraint fk_reg_no foreign key (reg_no) references student (reg_no)
);
insert into course values (101, 'physics', 2);
insert into course values (102, 'chemistry', 1);
insert into course values (103, 'biology', 4);
insert into course values (104, 'computer science', 3);

select s.reg_no, s.name, s.dept, s.city, s.ph_no, c.c_name, c.c_id
from student s
left join course c
on s.reg_no = c.reg_no;

select s.reg_no, s.name, s.dept, s.city, s.ph_no, c.c_name, c.c_id
from student s
right join course c
on s.reg_no = c.reg_no;

--14) views select drop
create view coimbatore_students as select * from student where city='coimbatore';
select * from coimbatore_students;
drop view coimbatore_students;

------------------------------------------------------------------------------------------------------------------------------------
--15) Triggers 
create table student (
    reg_no int primary key,
    name varchar(50),
    dept varchar(20),
    city varchar(20),
    ph_no int
);
--before insert
create or replace trigger capitalize_name
before insert on student
for each row
begin
    :new.name := upper(:new.name);
end;

insert into student values (1, 'saara', 'AI', 'tirupur', 456789);
insert into student values (2, 'laara', 'EEE', 'coimbatore', 123456);
insert into student values (3, 'caara', 'ECE', 'coimbatore', 345789);
insert into student values (4, 'meera', 'BME', 'erode', 124566);
select * from student;

--after delete 
create table deleted_students (
    reg_no int,
    name varchar(50),
    dept varchar(20),
    city varchar(20),
    ph_no int
);
create or replace trigger log_deleted_student
after delete on student
for each row
begin
    insert into deleted_students values (:old.reg_no, :old.name, :old.dept, :old.city, :old.ph_no );
end;

delete from student where city='coimbatore';
select * from deleted_students;

------------------------------------------------------------------------------------------------------------------------------------
--17) cursor salary increment 
create table employee (
    id int primary key,
    name varchar(20),
    salary int
);
insert into employee values (1, 'saara', 10000);
insert into employee values (2, 'laara', 20000);
insert into employee values (3, 'caara', 30000);
insert into employee values (4, 'meera', 40000);
select * from employee;

declare
    emp_id employee.id%type;
    emp_name employee.name%type;
    emp_salary employee.salary%type;
    cursor c_emp is select id, name, salary from employee;
begin
    open c_emp;
    loop
        fetch c_emp into emp_id, emp_name, emp_salary;
        exit when c_emp%notfound;
        update employee set salary = salary + 500 where id = emp_id;
        dbms_output.put_line('Salary of employee ' || emp_name || ' (ID: ' || emp_id || ') adjusted to ' || (emp_salary + 500));
    end loop;
    close c_emp;
end;

select * from employee;

------------------------------------------------------------------------------------------------------------------------------------
--Product probm
create table Products (
    ProductID int primary key,
    ProductName varchar(20), 
    Price int, 
    StockQuantity int
    );

-- Task 1: Create the view
create view ProductDetails as
select ProductID, ProductName, Price, StockQuantity
from Products;

-- Task 2: Drop the view if it exists
begin
   execute immediate 'drop view ProductDetails';
exception
   when others then
      if sqlcode != -942 then
         raise;
      end if;
end;
/
drop view ProductDetails;

-- Task 3: Verify if the view exists
select view_name
from user_views
where view_name = 'PRODUCTDETAILS';
