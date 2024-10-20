SELECT * FROM parks_and_recreation.employee_demographics;

SELECT* FROM parks_and_recreation.employee_salary;

#PEMDAS --> Parentheses,exponent,multiplication , division,addition,substraction

SELECT first_name, last_name,age, (age+10) AS ageplus10 FROM parks_and_recreation.employee_demographics;

#Clause WHERE

SELECT first_name, last_name  
FROM parks_and_recreation.employee_demographics
WHERE first_name like 'Hachim';

SELECT * FROM parks_and_recreation.employee_salary 
WHERE salary>1000;


SELECT * FROM parks_and_recreation.employee_demographics
WHERE gender != 'Male';


SELECT * FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1980-01-01';

-- AND OR NOT -- Logical operator :

SELECT * FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1980-01-01'AND age>35;


SELECT * FROM parks_and_recreation.employee_demographics
WHERE birth_date BETWEEN  '1980-01-01' AND '1987-01-01';


SELECT * FROM parks_and_recreation.employee_demographics
WHERE age not BETWEEN 20 AND 43;

#Statment LIKE

SELECT first_name, last_name  
FROM parks_and_recreation.employee_demographics
WHERE first_name like 'H%';

#Group By + Order By in MySQL
#Group By Use With SUM, AVG, MIN, MAX, COUNT

SELECT es.gender,count(es.gender) AS Nombre_DE_Chaque_Type
FROM parks_and_recreation.employee_demographics AS es
group by es.gender;


#Order by for sort salary :
# Option > asc and desc 

SELECT *
FROM parks_and_recreation.employee_salary AS es
order by salary ;

# Having vs Where

SELECT occupation,avg(salary) salary_Moyenne
FROM parks_and_recreation.employee_salary 
Where occupation like 'D%'
group by occupation
having avg(salary) > 65000;


# Limit & Aliasing

select * 
from parks_and_recreation.employee_salary ES
limit 3;


select ES.occupation,sum(ES.salary) as La_Somme_des_salaire
from parks_and_recreation.employee_salary ES
group by ES.occupation;





