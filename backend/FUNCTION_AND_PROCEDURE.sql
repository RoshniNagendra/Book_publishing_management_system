-- FUNCTION AND PROCEDURE

-- FUNCTION : Write a function to display author id, firstname, middlename, lastname, and whether or not the author has written a trilogy.
DELIMITER $$
CREATE FUNCTION trilogy(c int)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
DECLARE msg varchar(10);
IF c = 3 THEN SET msg = 'Yes';
ELSE SET msg = 'No';
END IF;
RETURN msg;
END $$

DELIMITER ;
SELECT b.A_ID, firstname, middlename, lastname, COUNT(B_ID) as book_count, trilogy(COUNT(B_ID))
FROM author a INNER JOIN book b
ON a.A_ID = b.A_ID
GROUP BY A_ID;

-- PROCEDURE : Currently the ages in the database are wrong. Write a procedure to update the correct author ages into the table.
DELIMITER $$
CREATE PROCEDURE correct_age()
BEGIN
UPDATE author a SET age = FLOOR(DATEDIFF(CURRENT_DATE, a.DOB)/365);
END $$

DELIMITER ;
CALL correct_age();
SELECT * FROM author;