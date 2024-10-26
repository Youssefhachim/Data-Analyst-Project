use Parks_and_Recreation;

#CTEs :


WITH CTE_EXEMPLE AS
(
select ed.gender, avg(es.salary) as "Salaire_Moyenne",
avg(ed.age) "Age Moyenne",max(ed.age) "Age maximum",min(ed.age) "Age minimum",Count(ed.age) "Nombre Personne"
from parks_and_recreation.employee_demographics ed
join parks_and_recreation.employee_salary es
on ed.employee_id=es.employee_id
GROUP BY ed.gender
)


SELECT avg(Salaire_Moyenne) FROM CTE_EXEMPLE;


WITH  CTE_EXEMPLE1 AS 
(
SELECT ed.employee_id,ed.gender,ed.birth_date
 FROM  parks_and_recreation.employee_demographics ed
 where ed.birth_date >'1985-01-01'
)
,
CTE_EXEMPLE2 AS (
SELECT es.employee_id,es.occupation,es.salary
 FROM  parks_and_recreation.employee_salary es
 where es.salary>50000
)

SELECT * FROM CTE_EXEMPLE1 JOIN CTE_EXEMPLE2 
ON CTE_EXEMPLE1.employee_id=CTE_EXEMPLE2.employee_id;


#Temprary Tables :

Create temporary table temp_tables
(
first_name varchar(50),
last_name varchar(50),
Favortie_movie varchar(100)
);


SELECT * FROM temp_tables;

INSERT INTO temp_tables VALUES ('Assia','Ait Ali','inside out');


select * from employee_salary;

create temporary table Salary_over_50K
SELECT * FROM employee_salary
WHERE salary>=50000;

select * from Salary_over_50K;

#Stored Procedures 

create procedure Large_salaire()
select *
from employee_salary
where salary>=50000;

call Large_salaire();


create procedure MIN_age()
select  min(ed.age) as "min_age"
from employee_demographics AS ed;

call MIN_age();


DELIMITER $$
create procedure Large_salaire_3()
BEGIN
	select *
	from employee_salary
	where salary>=50000;
	select *
	from employee_salary
	where salary>=10000;
END $$
DELIMITER ;


call Large_salaire_3();



DELIMITER $$
create procedure Large_salaire_4(employe_id_input INT)
BEGIN
	select es.salary
	from employee_salary es
	where es.employee_id=employe_id_input;
END $$
DELIMITER ;


call Large_salaire_4 (1);


DELIMITER $$
CREATE TRIGGER employee_insert
after insert on employee_salary
for each row 
begin
	insert into employee_demographics(employee_id,first_name,last_name) 
    values(new.employee_id,new.first_name,new.last_name);
end  $$
DELIMITER ;


insert into employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id) 
values(14,'Lahcen','Hachim','Courssier',10000,null);

SELECT * FROM employee_salary;

SELECT * FROM employee_demographics;


## EVENTS :


DELIMITER $$
CREATE EVENT Delete_RETIREES1
ON schedule EVERY 30 second
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age>= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE "event%";


