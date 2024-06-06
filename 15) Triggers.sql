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
