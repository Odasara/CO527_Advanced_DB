show grants for 'user1'@'localhost';

use company_security;
select * from employee;
create view works_on1 as select Fname,Lname,Pno from employee,works_on;
show grants for user1@localhost;