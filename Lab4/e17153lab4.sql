start transaction;
update salaries set salary = 1.1*salary where emp_no=43624;
select * from salaries where emp_no=43624;

rollback;
select * from salaries where emp_no=43624;productsproducts