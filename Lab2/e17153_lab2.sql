select first_name
from employees
order by first_name ASC ;


CREATE INDEX  fname_index
ON employees (first_name);

select first_name
from employees
order by first_name ASC;


create unique index uni_idx
on employees(emp_no,first_name,last_name);

select emp_no,first_name,last_name
from employees;


create index dept_no_idx 
on dept_manager (dept_no);


explain select distinct emp_no from dept_manager
where from_date>='1985-01-01' and dept_no>= 'd005';

explain select distinct emp_no from dept_manager
where from_date>='1996-01-03' and dept_no>= 'd005';

explain select distinct emp_no from dept_manager 
where from_date>='1985-01-01' and dept_no<= 'd009'; 