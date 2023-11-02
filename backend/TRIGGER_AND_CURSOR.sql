-- TRIGGER AND CURSOR

-- TRIGGER : Create a trigger to make sure before inserting that DOB in author table doesn't render author age > 150.
DELIMITER $$
CREATE TRIGGER check_DOB BEFORE INSERT
ON author FOR EACH ROW 
BEGIN
DECLARE error_msg VARCHAR(90);
DECLARE a int;
SET error_msg = ("This is not a valid date of birth for an author who is alive.");
SET a = (FLOOR(DATEDIFF(CURRENT_DATE, NEW.DOB)/365));
IF a > 150 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = error_msg;
END IF;
END $$

DELIMITER ;

-- should get triggered
INSERT INTO author(A_ID, firstname, middlename, lastname, phone_no, age, DOB) VALUES('A_040', 'Roshni', 'Puttu', 'Nagendra', 6363684042, 20, '1823-05-28');

-- should insert peacefully
INSERT INTO author(A_ID, firstname, middlename, lastname, phone_no, age, DOB) VALUES('A_040', 'Roshni', 'Puttu', 'Nagendra', 6363684042, 20, '2002-05-28');
SELECT * FROM AUTHOR;

-- now I'll delete this entry from the author table for demo purposes.
DELETE FROM author WHERE A_ID = 'A_040'; 

-- TRIGGER 2 : using a trigger to assign a free editor to any new book added to the book table. 
DELIMITER $$
CREATE TRIGGER editor_assign AFTER INSERT
ON book FOR EACH ROW
BEGIN
DECLARE new_editor VARCHAR(10);
DECLARE nfname VARCHAR(30);
DECLARE nlname VARCHAR(30); 
SET new_editor = (SELECT E_ID FROM editor WHERE B_ID IS NULL LIMIT 1);
SET nfname = (SELECT firstname FROM editor WHERE E_ID = new_editor);
SET nlname = (SELECT lastname FROM editor WHERE E_ID = new_editor);
DELETE FROM editor WHERE E_ID = new_editor;
INSERT INTO editor VALUES(new_editor,nfname,nlname,NEW.B_ID);
END
$$

DELIMITER ;

-- demo:
-- before inserting into book:
SELECT * FROM book;
SELECT * FROM editor;
INSERT INTO book VALUES('B_117','roshni','S_005','A_039');
-- after:
SELECT * FROM book;
SELECT * FROM editor;

-- CURSOR : Create a cursor and use it to concatenate S_ID and subject_name.
DELIMITER $$
CREATE PROCEDURE concatenating()
BEGIN
DECLARE v_S_ID VARCHAR(10);
DECLARE v_subject_name VARCHAR(30);
DECLARE v_finish INT DEFAULT 0;
DECLARE c1 CURSOR FOR SELECT S_ID, subject_name FROM subjects;
DECLARE continue handler for NOT FOUND SET v_finish = 1;
open c1;
joining : LOOP
FETCH c1 into v_S_ID, v_subject_name;
IF v_finish = 1 THEN LEAVE joining;
END IF;
SELECT concat(v_S_ID, v_subject_name);
END LOOP joining;
close c1;
END $$

DELIMITER ;
CALL concatenating();

-- CURSOR 2 : Find the product of number of books in each genre.
DELIMITER $$
CREATE PROCEDURE product()
BEGIN
DECLARE p bigint DEFAULT 1;
DECLARE vsid VARCHAR(10);
DECLARE c INT;
DECLARE v_finish INT DEFAULT 0;
DECLARE c1 CURSOR FOR SELECT S_ID, COUNT(B_ID) FROM book GROUP BY S_ID;
DECLARE continue handler for NOT FOUND SET v_finish = 1;
open c1;
multi : LOOP
FETCH c1 into vsid, c;
IF v_finish = 1 THEN SELECT p AS final_product;
LEAVE multi;
END IF;
SET p = p * c;
END LOOP multi;
close c1;
END $$

DELIMITER ;
CALL product();