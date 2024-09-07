CREATE TABLE emp1 (
    id INT,
    salary int DEFAULT 250000
);

INSERT INTO emp1 (id) VALUES (105);

SELECT * FROM emp1;


-----


SELECT * FROM employee
where salary BETWEEN 71000 and 100000; 

SELECT * FROM employee
where salary>= 71000;


SELECT * FROM employee
where first_name in ('Jan','Jim'); 

SELECT * FROM employee
where first_name not in ('Jan','Jim')
LIMIT 3; 




SELECT avg(salary) FROM employee;----COUNT(),MAX(),MIN(),SUM()

SELECT SEX,COUNT(sex) FROM employee AS E
GROUP BY SEX;

SELECT first_name,AVG(salary) FROM employee
GROUP BY first_name;

SELECT first_name,AVG(salary) FROM employee
WHERE sex = 'M'
GROUP BY first_name
--ORDER BY first_nam ASC;

-- UPDATE

UPDATE emp1
SET id = 109384
WHERE id = 105;

UPDATE emp1
SET id = id * 12



DELETE FROM COL_NAME
WHERE MARKS < 33;

CREATE TABLE dept(
    id INT primary key,
    name varchar(30)
);

CREATE TABLE teacher (
    id INT primary key,
    name varchar(30),
    dept_id INT,
    FOREIGN KEY(dept_id) REFERENCES dept(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
     );

DROP TABLE teacher;

INSERT into dept  VALUES(101,'Science'),(102,'English'),(103,'Urdu');

SELECT * FROM dept;
UPDATE dept
SET id = 104
WHERE id = 103

--aLTER

ALTER TABLE dept
ADD COLUMN AGE INT NOT NULL DEFAULT 25;

UPDATE TABLE dept
SET AGE = 25
WHERE AGE = NULL;

ALTER TABLE dept
CHANGE AGE TEACH_AGE INT;


ALTER TABLE dept
DROP COLUMN AGE;

TRUNCATE TABLE dept;

-- jOINS

---INNER JOIN

SELECT * FROM employee 
INNER JOIN WORKS_WITH
ON employee.emp_id=works_with.emp_id;


---LEFT JOIN 
SELECT * FROM WORKS_WITH AS W
LEFT JOIN employee AS E
ON W.emp_id=E.emp_id;

--- RIGHT JONS
SELECT * FROM  employee AS E
RIGHT JOIN WORKS_WITH AS W
ON W.emp_id=E.emp_id;

--FULL JOINS
SELECT * FROM employee 
FULL jOIN WORKS_WITH
ON employee.emp_id=works_with.emp_id;


--SELF JOIN
SELECT * FROM employee AS A 
JOIN employee AS B 
ON A.emp_id = B.super_id;

--- Union
SELECT branch_id FROM employee 
Union all
SELECT branch_id from branch;



-- SQL Sub Queries

SELECT avg(salary) from employee;
--92888

SELECT first_name,salary from employee 
where salary>92888;
---1
SELECT first_name,salary 
from employee 
where salary>
           (SELECT avg(salary) 
           from employee);


SELECT  emp_id from employee
where emp_id % 2=0;
---2
SELECT first_name 
from employee
WHERE emp_id in
        (SELECT  emp_id 
        from employee
        where emp_id % 2=0);

--3
SELECT AVG(salary) from
                     (SELECT * FROM employee WHERE branch_id = 3) as tem;

---4 
SELECT (SELECT max(salary) from employee) ,first_name from employee;



----Create view


create view view1 as
SELECT emp_id,first_name,salary from employee;


SELECT * from view1;


COPY Data_Analyst
FROM 'C:\Users\HP\Documents\SQL_COURSE\Data.csv\Data_Analyst.csv'
DELIMITER ',' CSV HEADER;


SELECT job_title_short,job_location FROM abc.job_postings_fact
LIMIT 5;

-- DISTINC
select distinct 
       job_title_short
from 
    abc.job_postings_fact;


-- Where
SELECT 
job_title_short,
job_location,
job_via,
salary_year_avg 
FROM 
   abc.job_postings_fact
where 
    job_title_short = 'Data Analyst'   ---    salary_year_avg >90000
        --- and
        ----- salary_year_avg >9000 and job_title_short = 'Data Analyst'
        --- or
        ----- salary_year_avg >9000 or job_title_short = 'Data Analyst'
        --- BETWEEN
        -- salary between 30000 and 100000
        --- IN
        --- job_title_short  in ('Data Analyst', 'Data Science')
        --- Like
        --  job_title_short like '%Analyst'
order by 
        salary_year_avg desc
x

 ---where
     -- job_location in ('Anywhere','Phoenix, AZ','MA') and
      --(
     -- (job_title_short = 'Data Analyst' and salary_year_avg >5000) or
      --(job_title_short=   'Business Analyst' and salary_year_avg >70000)
      --);


--- AS
SELECT job_title_short as title,
job_location as location,
job_via ,
salary_year_avg as salary 
 FROM abc.job_postings_fact
 where
     job_title_short like '%Analyst%'


-- operter
SELECT rental_rate + 1000 as rate_increase FROM sample_data.rental_info;
--SELECT (rental_rate + 1000 ) * length  as rate_increase FROM sample_data.rental_info;
--length % 8 as Lenth

-- Aggeration
SELECT avg(salary_year_avg) --count(*),sum(),Max(),min()
FROM abc.job_postings_fact


--- Group by
SELECT sum(salary_year_avg),
avg(salary_year_avg),
MIN(salary_year_avg)
 FROM abc.job_postings_fact
 group by 
         job_title_short


--- HAVING
SELECT sum(salary_year_avg),
avg(salary_year_avg) AS SALARY_AVG,
MIN(salary_year_avg)
 FROM abc.job_postings_fact
 group by 
         job_title_short
having
      count(job_title_short) >10
order by 
        SALARY_AVG
 

