SELECT 
    dept_name, COUNT(*)
FROM
    titles,departments,employees,dept_emp
WHERE employees.emp_no = titles.emp_no  and dept_emp.dept_no=departments.dept_no and
  dept_emp.emp_no=employees.emp_no and titles.title="Engineer"
GROUP BY dept_name; 


select * from departments;
select * from titles where title = "Engineer";
SELECT COUNT(*) FROM titles where title="Engineer";

select dept_name,title from departments,employees,titles,dept_emp where
employees.emp_no = titles.emp_no  and dept_emp.dept_no=departments.dept_no and  dept_emp.emp_no=employees.emp_no and titles.title="Engineer" ;


select employees.emp_no as ID,concat(first_name," ",last_name) as emp_name
from employees,dept_manager,titles
where employees.emp_no = dept_manager.emp_no
and employees.emp_no = titles.emp_no 
and employees.sex="F" and titles.title = "Senior Engineer" ;

select dept_name,title,Count(*) as total_employees
from salaries,dept_emp,departments,titles
where salaries.emp_no = dept_emp.emp_no and departments.dept_no = dept_emp.dept_no
and titles.emp_no = salaries.emp_no and salaries.salary > 115000 and dept_emp.to_date = "9999-01-01"
group by departments.dept_name,titles.title;

select first_name,last_name,TIMESTAMPDIFF(YEAR,birth_date,CURDATE()) AS age,hire_date
from employees;

select first_name,last_name,TIMESTAMPDIFF(YEAR,birth_date,CURDATE())  AS age,
hire_date,TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) AS years_of_service
from employees  where TIMESTAMPDIFF(YEAR,birth_date,CURDATE())>50 and
 TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) >10 ;

select first_name,last_name 
from employees,dept_emp,departments
where employees.emp_no = dept_emp.emp_no and departments.dept_no = dept_emp.dept_no and
dept_name!='Human Resources';

select first_name,last_name 
from employees,dept_emp,departments
where employees.emp_no = dept_emp.emp_no and departments.dept_no = dept_emp.dept_no and
dept_name!='Human Resources'
group by first_name,last_name;



select distinct first_name,last_name
from employees,salaries,departments,dept_emp
where employees.emp_no = dept_emp.emp_no and employees.emp_no = salaries.emp_no and
departments.dept_no = dept_emp.dept_no and
salary > (select max(salary) from employees,salaries,departments,dept_emp
 where employees.emp_no = dept_emp.emp_no and employees.emp_no = salaries.emp_no and
departments.dept_no = dept_emp.dept_no and dept_name = 'Finance');

select distinct first_name,last_name
from employees,salaries
where employees.emp_no = salaries.emp_no and
salary > (select avg(salary) from salaries );

select 
(select avg(salary) from employees,salaries,titles where titles.emp_no = salaries.emp_no and
employees.emp_no = titles.emp_no and titles.title= 'Senior Engineer') -
(select avg(salary) from salaries)as difference;

create view  Current_dept_emp as
select dept_emp.emp_no, dept_emp.from_date,dept_emp.to_date
from dept_emp
where (dept_emp.to_date>curdate());

select * from Current_dept_emp;

create or replace view Current_dept as
select Current_dept_emp.emp_no,Departments.dept_name
from Current_dept_emp,departments,dept_emp
where Current_dept_emp.emp_no = dept_emp.emp_no
and dept_emp.dept_no = departments.dept_no
and year(dept_emp.to_date > curdate());
select * from Current_dept;

drop view current_dept_emp;

select emp_no,from_date,to_date
from dept_emp
where year(to_date > curdate());

create view current_dept_emp as
select dept_emp.emp_no, dept_emp.from_date, dept_emp.to_date
from dept_emp
where dept_emp.to_date = '9999-01-01';
select * from current_dept_emp;

SELECT dept_emp.emp_no, dept_emp.from_date, dept_emp.to_date
FROM dept_emp
WHERE dept_emp.to_date = '9999-01-01';

CREATE TABLE salary_change(
sc_emp_no int,
old_salary int,
new_salary int,
salary_diff int,
PRIMARY KEY (sc_emp_no),
FOREIGN KEY (sc_emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE
);
DELIMITER $$
CREATE OR REPLACE TRIGGER print_salary
AFTER UPDATE ON salaries
FOR EACH ROW
BEGIN
IF New.salaries.salary <> old.salaries.salary THEN
insert into salary_change(sc_emp_no,old_salary,new_salary,salary_diff) Values
(salaries.emp_no,:old..salary,new.salary,((new.salary)-(old.salary)));
END IF
END;
DELIMITER;
SELECT *
FROM salary_changes



DELIMITER $$
CREATE TRIGGER salary_increase BEFORE UPDATE ON salaries FOR EACH ROW BEGIN
IF NEW.salary - OLD.salary > 0.1 * OLD.salary THEN
SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Salary increment is greater than 10% of current salary!';
END IF;
END$$
DELIMITER ;





