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

create view coimbatore_students as select * from student where city='coimbatore';

select * from coimbatore_students;

drop view coimbatore_students;
