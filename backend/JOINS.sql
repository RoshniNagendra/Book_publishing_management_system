-- JOINS

-- 1. Inner join : Retrieve all information about each author and the respective books each author has written.
SELECT * FROM author a
INNER JOIN book b ON a.A_ID = b.A_ID; 

-- 2. Left outer join : List E_ID, firstname, lastname, B_ID, title where the book titles are City of Bones,
--    The Lightning Thief, Prisoner of Azkaban, Allegiant, It Ends With Us, and also if an editor is not associated with any book.

SELECT E_ID, firstname, lastname, e.B_ID, title FROM editor e
LEFT OUTER JOIN book b
ON e.B_ID = b.B_ID
WHERE (b.title IN ("City of Bones","The Lightning Thief", "Prisoner of Azkaban", "Allegiant", "It Ends With Us")
OR e.B_ID IS NULL);

-- 3. Right outer join : List E_ID and firstname, lastname, C_ID, company of the editors who work in "Macmillan" and "Simon and Schuster".

SELECT c.E_ID, firstname, lastname, C_ID, company FROM editor e
RIGHT OUTER JOIN company c 
ON c.E_ID = e.E_ID
WHERE c.company IN ("Macmillan", "Simon and Schuster");

-- 4. Natural join : Retrieve all information about subjects and books if an author has written only one book. 

SELECT * FROM subjects s
NATURAL JOIN book b
WHERE s.S_ID = b.S_ID
AND b.A_ID IN (SELECT A_ID FROM(SELECT COUNT(A_ID) as c,A_ID FROM book GROUP BY A_ID HAVING c = 1) as a);
