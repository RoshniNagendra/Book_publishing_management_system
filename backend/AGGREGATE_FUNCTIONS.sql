-- AGGREGATE FUNCTIONS

-- 1. COUNT : Display the copmany name, number of employees in the respective companies.
SELECT company, COUNT(E_ID) as number_of_employees FROM company GROUP BY company;

-- 2. AVG : Display the average number of authors that each publishing company has published books of.
SELECT AVG(a.author_number) as avg_author_number
FROM (SELECT COUNT(DISTINCT A_ID) as author_number FROM company GROUP BY C_ID) as a;

-- 3. MAX : Display the author with maximum number of books published.
SELECT t2.A_ID,firstname, middlename, lastname, COUNT(*) as c 
FROM author t1 INNER JOIN book t2 ON t1.A_ID = t2.A_ID
GROUP by A_ID
HAVING c = (SELECT MAX(c2) from (SELECT COUNT(B_ID) c2 from book GROUP BY A_ID) c1);

-- 4. SUM : Display the total number of books that have been published by all present companies in the DB.
SELECT SUM(a.count) as total 
FROM (SELECT COUNT(*) as count from book GROUP BY B_ID) a;
