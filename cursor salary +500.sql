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
