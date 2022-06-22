show databases;
use company;
show tables;
show index from employees;
drop index uni_idx on employees;
drop index fname_index on employees;
show index from dept_manager;

EXPLAIN SELECT * FROM departments WHERE dept_name = "Finance";

EXPLAIN SELECT * FROM departments WHERE dept_no ="d002";

create table emplist select emp_no, first_name from employees;
create table titleperiod select emp_no, title, datediff(to_date, from_date) as period FROM titles;

EXPLAIN SELECT first_name, period from emplist inner join titleperiod
on titleperiod.emp_no = emplist.emp_no
where period>4000;

 ALTER TABLE `company`.`emplist`
ADD PRIMARY KEY (`emp_no`);

ALTER TABLE `company`.`titleperiod`
ADD INDEX `empNoidx` (`emp_no` ASC);

EXPLAIN SELECT first_name , period from emplist inner join titleperiod
on titleperiod.emp_no = emplist.emp_no
where period>4000;



