## 175.两表组合
select a.FirstName, a.LastName, b.City, b.State 
from Person a left join Address b 
on b.PersonId=a.PersonId;

## 176.第二高的薪水
## 1 查找薪水小于最大值的数据
select ifnull(
    (select max(distinct salary)  from Employee
    where salary < (select max(distinct salary) from Employee)
    ),null) as SecondHighestSalary;
    
## 176.第二高的薪水
## 2 降序，给出第2个数据
select ifnull(
    (select distinct salary from Employee order by Salary desc limit 1,1)
    ,null) as  SecondHighestSalary;
    
## 177. 第N高的薪水
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  set n = N-1; # 注意变量问题
  RETURN (
      # Write your MySQL query statement below.
      select ifnull(
      (select distinct salary from Employee 
      order by salary desc
      limit n,1),null)
      as getNthHighestSalary
  );
END

## 178. 分数排名

select score, 
    dense_rank() over (order by score desc) as `rank`
from scores;

## 180. 连续出现的数字
select distinct a.num as ConsecutiveNums from logs as a,logs as b,logs as c
where a.id=b.id-1 and b.id = c.id-1
    and a.num = b.num and b.num = c.num
  
## 181. 超过经理收入的员工
## 使用join +on 
select 
    a.name as employee 
from employee a join employee b 
    on a.managerid=b.id 
    and a.salary > b.salary
    
## 使用leftjoin +where
select 
    a.name as employee 
from employee a left join employee b 
    on a.managerid=b.id 
where  a.salary > b.salary
    
## 182. 查找重复的电子邮箱
## group by +where 
select email 
from (select email,count(email) nums  from person group by email ) as c 
where nums >1

## group by +having 
select email 
from person
group by email
having count(email)>1


## 183. 从不订购的客户
## leftjoin  is null
select a.name customers 
from customers a left join orders b 
on a.id=b.customerid 
where b.customerid is null

## not in
select a.name customers 
from customers a
where a.id not in (select customerid from orders)


## 184. 部门工资最高的员工
## 找出每个部门工资最高的员工信息，再和部门连接，找出部门信息
SELECT
	a.NAME AS Department,
	b.NAME AS Employee,
	a.Salary 
FROM
	Employee a,
	Department b
WHERE
	a.DepartmentId = b.Id 
	AND ( a.DepartmentId, a.Salary ) 
    IN (SELECT DepartmentId, max( Salary ) 
        FROM Employee 
        GROUP BY DepartmentId )







    