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
select * from course;

select s.reg_no, s.name, s.dept, s.city, s.ph_no, c.c_name, c.c_id
from student s
left join course c
on s.reg_no = c.reg_no;

select s.reg_no, s.name, s.dept, s.city, s.ph_no, c.c_name, c.c_id
from student s
right join course c
on s.reg_no = c.reg_no;
