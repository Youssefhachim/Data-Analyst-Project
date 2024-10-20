#INNER JOIN

SELECT * FROM parks_and_recreation.employee_demographics ed 
INNER JOIN parks_and_recreation.employee_salary es
WHERE es.employee_id=ed.employee_id;

#INNER JOIN WITH CONDITIONS

SELECT * FROM parks_and_recreation.employee_demographics ed 
INNER JOIN parks_and_recreation.employee_salary es
ON es.employee_id=ed.employee_id and es.dept_id=1;

#RIGHT JOIN

SELECT * FROM parks_and_recreation.employee_demographics ed 
RIGHT JOIN parks_and_recreation.employee_salary es
ON es.employee_id=ed.employee_id;


#LEFT JOIN

SELECT * FROM parks_and_recreation.employee_demographics ed 
LEFT JOIN parks_and_recreation.employee_salary es
ON es.employee_id=ed.employee_id;


#Un self join (ou auto-jointure) est une jointure d'une table avec elle-même.
# Il est utilisé lorsque tu veux comparer ou associer des lignes d'une même table entre elles en fonction de certaines conditions.

SELECT concat(emp1.first_name," ",emp1.last_name) AS EMPLOYEE,concat(emp2.first_name, ' ',emp2.last_name) As MANAGER
from parks_and_recreation.employee_demographics emp1
inner join parks_and_recreation.employee_demographics emp2
on emp1.employee_id+1=emp2.employee_id;

#Joining Multiple tables together

SELECT * FROM parks_and_recreation.employee_demographics ed 
INNER JOIN parks_and_recreation.employee_salary es
ON es.employee_id=ed.employee_id
INNER JOIN parks_and_recreation.parks_departments pd
ON pd.department_id=es.dept_id
where dept_id=1;


#Union


select ed.first_name,ed.last_name from parks_and_recreation.employee_demographics ed
Union All
select first_name,last_name from parks_and_recreation.employee_salary;


#UNION for know highly paid employee AND Old Person :


select ed.first_name,ed.last_name ,'Old' as Label
from parks_and_recreation.employee_demographics ed
where ed.age>50
Union 
select es.first_name,es.last_name ,'highly paid emplyee' as Label
from parks_and_recreation.employee_salary es
where es.salary>70000;



select ed.first_name,ed.last_name ,'Old Man' as Label
from parks_and_recreation.employee_demographics ed
where ed.age>40 and ed.gender='Male'
Union 
select ed.first_name,ed.last_name ,'Old Women' as Label
from parks_and_recreation.employee_demographics ed
where ed.age>40 and ed.gender='Female'
Union 
select es.first_name,es.last_name ,'highly paid emplyee' as Label
from parks_and_recreation.employee_salary es
where es.salary>70000;


#String function in mysql	
#LENGTH

SELECT ed.first_name,length(ed.first_name) As 'Caracter number'
FROM parks_and_recreation.employee_demographics ed;


#UPPER & LOWER

SELECT ed.first_name,Upper(ed.first_name) 
As 'Upper Caracter ',lower(ed.first_name) As 'Lower Caracter '
FROM parks_and_recreation.employee_demographics ed;

#TRIM : Delet  spaces null


SELECT TRIM("           HACHIM           ") as TRIM;

#RIGHT TRIM

SELECT RTRIM("           HACHIM           ") as RIGHTTRIM;

#LEFT TRIM

SELECT LTRIM("           HACHIM           ") as LEFTTRIM;

#RIGHT AND LEFT AND SUBSTRING

SELECT first_name,
LEFT(ed.first_name,4) as 'First 4 caracter',
RIGHT(ed.first_name,4)  as 'Last 4 caracter',
SUBSTRING(ed.first_name,3,2) as 'Les Deux caractere a partir du caractere 3'
FROM parks_and_recreation.employee_demographics ed;

#REPLACE 

SELECT ed.first_name,REPLACE(ed.first_name,'A','O') As 'Changer A To Z'
FROM parks_and_recreation.employee_demographics ed;


#LOCATE 

SELECT ed.first_name,LOCATE('A',ed.first_name) As 'Caracter Position'
FROM parks_and_recreation.employee_demographics ed;

#CONCAT

SELECT CONCAT(ed.first_name," ",ed.last_name) As 'Full Name'
FROM parks_and_recreation.employee_demographics ed;

#Case Statement

SELECT ed.first_name,ed.last_name,ed.age,
CASE 
	WHEN ed.age<30
		THEN 'Young' 
	WHEN age BETWEEN 30 AND 59
		THEN 'old'
	WHEN ed.age>=60
		THEN "On Death's Door"
END as "Test Age"
FROM parks_and_recreation.employee_demographics ed;


#Pay Increase And Bonus 
# < 50000 = 5%
# > 50000 = 7%
#Finance =10%

SELECT es.first_name,es.last_name,es.salary,es.occupation,
CASE 
	WHEN es.salary<50000
		THEN es.salary +(es.salary*0.05)
	WHEN es.salary>50000
		THEN es.salary +(es.salary*0.07)
END as "Bonus By Salary",
CASE
	WHEN es.dept_id = 6

		THEN es.salary +(es.salary*0.10)
END as "Bonus By Departements"
FROM parks_and_recreation.employee_salary es ;

#Subqueries in mysql :

select * from parks_and_recreation.employee_demographics ed 
where employee_id 
NOT in (select employee_id from parks_and_recreation.employee_salary );

select * from parks_and_recreation.employee_demographics ed 
where employee_id 
in (select employee_id from parks_and_recreation.employee_salary WHERE dept_id=1);


select es.first_name,es.salary,(select avg(salary) from employee_salary) as 'Moyenne Salaire'
from parks_and_recreation.employee_salary es;


select ed.gender,avg(ed.age) "Age Moyenne",max(ed.age) "Age maximum",min(ed.age) "Age minimum",Count(ed.age) "Nombre Personne"
from parks_and_recreation.employee_demographics ed
GROUP BY ed.gender;


#Window functions in MySQL

select distinct ed.first_name,ed.last_name,ed.gender, 
AVG(es.salary) over(PARTITION BY gender) 
as "Salaire Moyenne"
from parks_and_recreation.employee_demographics ed 
join parks_and_recreation.employee_salary es
on ed.employee_id=es.employee_id;



select distinct ed.employee_id, ed.first_name,ed.last_name,ed.gender, salary,
row_number() OVER(PARTITION BY gender ORDER BY salary desc) AS "row-number",
RANK() OVER(PARTITION BY gender ORDER BY salary desc) AS "rank",
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary desc) AS "dense-rank" 
as "Salaire Moyenne"
from parks_and_recreation.employee_demographics ed 
join parks_and_recreation.employee_salary es
on ed.employee_id=es.employee_id;
