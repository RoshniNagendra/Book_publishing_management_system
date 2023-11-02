-- SET OPERATIONS

-- 1. UNION : Display all the authors who have written 3 books or the ones who have written 5 books.
(SELECT b.A_ID, firstname, middlename, lastname, COUNT(b.A_ID) AS number_of_books_written
FROM author a INNER JOIN book b
ON a.A_ID = b.A_ID
GROUP BY A_ID
HAVING number_of_books_written = 3)
UNION
(SELECT b.A_ID, firstname, middlename, lastname, COUNT(b.A_ID) AS number_of_books_written
FROM author a INNER JOIN book b
ON a.A_ID = b.A_ID
GROUP BY A_ID
HAVING number_of_books_written = 5); 

-- 2. INTERSECTION : Display all the authors who have written both in the "Thriller" and "Romance" genre.
SELECT DISTINCT b.A_ID, firstname, middlename, lastname
FROM author a1 INNER JOIN book b INNER JOIN subjects s
ON a1.A_ID = b.A_ID AND b.S_ID = s.S_ID
WHERE subject_name = 'Thriller'
AND EXISTS 
(SELECT b.A_ID firstname, middlename, lastname
FROM author a2 INNER JOIN book b INNER JOIN subjects s
ON a2.A_ID = b.A_ID AND b.S_ID = s.S_ID
WHERE subject_name = 'Romance'
AND a1.A_ID = a2.A_ID);

-- 3. DIFFERENCE : Display all genres except "Horror"
SELECT S_ID, subject_name
FROM subjects
EXCEPT 
(SELECT S_ID, subject_name
FROM subjects
WHERE subject_name = "Horror");

-- 4. UNIONALL : Display all the authors who have written in the "Self-help" genre or the "Biography" genre.
(SELECT b.A_ID, firstname, middlename, lastname
FROM author a INNER JOIN book b INNER JOIN subjects s
ON a.A_ID = b.A_ID AND b.S_ID = s.S_ID
WHERE subject_name = 'Self-help')
UNION ALL 
(SELECT b.A_ID, firstname, middlename, lastname
FROM author a INNER JOIN book b INNER JOIN subjects s
ON a.A_ID = b.A_ID AND b.S_ID = s.S_ID
WHERE subject_name = 'Biography'); 