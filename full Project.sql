use world_layoffs;

## Remove duplicate 
## Standrize The data
## Null Values and blank value 
## Remove Any Rows or COLUMNS

select * from layoffs;


create table layoffs_staging 
like layoffs;

select * from layoffs_staging;

	select *,
	row_number() 
	over(partition by company,industry,total_laid_off,percentage_laid_off, date) as Row_num
	from layoffs_staging;
    
    
	select * from layoffs;
    


with duplicate_CTE AS 
(
select *,
	row_number() 
	over(partition by company,location,industry,total_laid_off,percentage_laid_off, date,stage,country,funds_raised_millions) as Row_num
	from layoffs_staging
)
select * from duplicate_CTE
where Row_num >1;


select * from layoffs_staging
where company like "Casper";

CREATE TABLE  layoffs_staging2 
like layoffs_staging;



ALTER TABLE layoffs_staging2 ADD COLUMN Row_num INT;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
select *,
	row_number() 
	over(partition by company,location,industry,total_laid_off,percentage_laid_off, date,stage,country,funds_raised_millions) as Row_num
	from layoffs_staging;
    
SELECT * FROM layoffs_staging2
WHERE Row_num>1;

SET SQL_SAFE_UPDATES = 0;


DELETE 
FROM  layoffs_staging2
WHERE Row_num = 2;

##Standrizing the Data

update layoffs_staging2
SET company = Trim(company);

SELECT DISTINCT company FROM layoffs_staging2;

SELECT * from layoffs_staging2 
where industry like "Crypto%";

update layoffs_staging2
set industry= "Crypto"
where industry like "Crypto%";

select distinct location 
from layoffs_staging2
order by 1;


select * 
from layoffs_staging2
Where country like 'United states%' 
order by 1;


select distinct country,trim(trailing '.' from country)
from layoffs_staging2
order by 1;


SET SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set country= "United states"
where country like "United states%";
##############  OR 
update layoffs_staging2
set country=trim(trailing '.' from country)
where country like "United states%";

#Convert type string to date using str_to_date() functions

select date,str_to_date(date,'%m/%d/%Y') from layoffs_staging2;

#Convert date string to date using str_to_date() functions

update layoffs_staging2
set DATE=str_to_date(date,'%m/%d/%Y');

##changer type text to date 

Alter Table layoffs_staging2
modify column date Date;

select * from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;


select * from layoffs_staging2
where industry is null
or industry = '';

select * from layoffs_staging2
where company like "Airbnb" ;

select st1.industry,st2.industry 
from layoffs_staging2 st1
JOIN layoffs_staging2 st2 
	ON st1.company=st2.company
	And st1.location=st2.location
where (st1.industry is null or st1.industry='' )
and st2.industry is not null;

update layoffs_staging2 st1
join layoffs_staging2 st2
on st1.company=st2.company
set st1.industry= st2.industry
where st1.industry is null
and st2.industry is not null;

update layoffs_staging2
set industry = null
WHERE industry ='';

select * from layoffs_staging2
where company like "Bally%" ;


select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;


DELETE FROM layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

## POUR SUPPRIMER UN COLLNE DE LA TABLE : 


ALTER TABLE layoffs_staging2
DROP column row_num ;