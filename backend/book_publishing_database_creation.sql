-- creating database
CREATE DATABASE bookpublishing;

USE DATABASE bookpublishing;

-- creating tables with constraints
CREATE TABLE author(
    A_ID varchar(10) NOT NULL,
    firstname varchar(20) NOT NULL,
    middlename varchar(20) DEFAULT NULL,
    lastname varchar(20) DEFAULT NULL,
    phone_no bigint,
    age int,
    DOB DATE,
    PRIMARY KEY(A_ID)
);

ALTER TABLE author
ADD CONSTRAINT check_age CHECK (age > 0 AND age < 200);

CREATE TABLE subjects(
    S_ID varchar(10) NOT NULL,
    subject_name varchar(30) NOT NULL,
    PRIMARY KEY(S_ID)
);

CREATE TABLE book(
    B_ID varchar(10) NOT NULL,
    title varchar(50) NOT NULL,
    S_ID varchar(100) NOT NULL,
    A_ID varchar(10) NOT NULL,
    PRIMARY KEY(B_ID),
    FOREIGN KEY(A_ID) REFERENCES author(A_ID) ON DELETE CASCADE,
    FOREIGN KEY(S_ID) REFERENCES subjects(S_ID) ON DELETE CASCADE
);

CREATE TABLE editor(
    E_ID varchar(20) NOT NULL,
    firstname varchar(30) NOT NULL,
    lastname varchar(30) DEFAULT NULL,
    B_ID varchar(10) DEFAULT NULL,
    PRIMARY KEY(E_ID),
    FOREIGN KEY(B_ID) REFERENCES book(B_ID) ON DELETE CASCADE
);

-- CREATE TABLE company(
--     C_ID varchar(10) NOT NULL,
--     company varchar(10) NOT NULL,
--     A_ID varchar(10) DEFAULT NULL,
--     B_ID varchar(10) DEFAULT NULL,
--     S_ID varchar(10) DEFAULT NULL,
--     E_ID varchar(10) DEFAULT NULL,
--     FOREIGN KEY(A_ID) REFERENCES author(A_ID) ON DELETE CASCADE,
--     FOREIGN KEY(B_ID) REFERENCES book(B_ID) ON DELETE CASCADE,
--     FOREIGN KEY(S_ID) REFERENCES subjects(S_ID) ON DELETE CASCADE,
--     FOREIGN KEY(E_ID) REFERENCES editor(E_ID) ON DELETE CASCADE
-- );

show tables;

-- inserting values into the tables using 3 methods.

-- 1 - using insert into statement
INSERT INTO subjects(S_ID, subject_name) VALUES
("S_001","Drama"),
("S_002","Fantasy"),
("S_003","Thriller"),
("S_004","Young Adult Fiction"),
("S_005","Romance"),
("S_006","Horror"),
("S_007","Comedy"),
("S_008","Sci-fi"),
("S_009","Mystery"),
("S_010","Fiction"),
("S_011","Autobiography"),
("S_012","Self-help"),
("S_013","Physics"),
("S_014","Children's literature"),
("S_015","Biography");

SELECT * FROM subjects;

-- 2 - using load data infile statement
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/AUTHOR.csv" 
INTO TABLE author 
FIELDS TERMINATED BY ',' 
ENCLOSED BY ""
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(A_ID, firstname, @vthree, @vfour, @vfive, @vsix, @vseven)
SET
middlename = NULLIF(@vthree,''),
lastname = NULLIF(@vfour,''),
phone_no = NULLIF(@vfive,''),
age = NULLIF(@vsix,''),
DOB = NULLIF(@vseven,'')
;

SELECT * FROM author;

ALTER TABLE book
MODIFY S_ID longtext;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/BOOK.csv" 
INTO TABLE book 
FIELDS TERMINATED BY ',' 
ENCLOSED BY ""
ESCAPED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(B_ID, title, S_ID, A_ID);

UPDATE book b SET A_ID = REPLACE(A_ID, CHAR(13 USING ascii), '');

SELECT * FROM book;

INSERT INTO editor(E_ID, firstname, lastname, B_ID) VALUES
("C1_001","Alfred","V","B_001"),
("C1_002","Alice","I","B_002"),
("C1_003","Annabelle","K","B_003"),
("C1_004","Anthony","S","B_004"),
("C1_005","Archie","K","B_005"),
("C1_006","Augustine","O","B_006"),
("C1_007","Beatrice","M","B_007"),
("C1_008","Beatrice","J","B_008"),
("C1_009","Benedict","I","B_009"),
("C1_010","Bernard","B","B_010"),
("C1_011","Bert","Z","B_011"),
("C1_012","Betsy","S","B_012"),
("C1_013","Bruno","K","B_013"),
("C1_014","Burke","Y","B_014"),
("C1_015","Calvin","Q","B_015"),
("C1_016","Cecil","M","B_016"),
("C1_017","Celia","V","B_017"),
("C1_018","Charlie","A","B_018"),
("C1_019","Chester","U","B_019"),
("C1_020","Clarence","W","B_020"),
("C1_021","Claude","B","B_021"),
("C1_022","Cleo","U","B_022"),
("C1_023","Clifford","W","B_023"),
("C1_024","Clive","H","B_024"),
("C1_025","Darlene","H","B_025"),
("C2_001","Diana","J","B_026"),
("C2_002","Earl","A","B_027"),
("C2_003","Eddie","Y","B_028"),
("C2_004","Edgar","D","B_029"),
("C2_005","Edith","L","B_030"),
("C2_006","Edward","T","B_031"),
("C2_007","Eileen","F","B_032"),
("C2_008","Eleanor","N","B_033"),
("C2_009","Elijah","R","B_034"),
("C2_010","Emmett","A","B_035"),
("C2_011","Enoch","S","B_036"),
("C2_012","Eugene","Q","B_037"),
("C2_013","Eve","G","B_038"),
("C2_014","Everett","K","B_039"),
("C2_015","Floyd","V","B_040"),
("C2_016","Frank","P","B_041"),
("C2_017","Franklin","O","B_042"),
("C2_018","Frederick","M","B_043"),
("C2_019","George","M","B_044"),
("C2_020","Gideon","C","B_045"),
("C2_021","Gilbert","E","B_046"),
("C2_022","Gladys","E","B_047"),
("C2_023","Glenda","P","B_048"),
("C2_024","Greta","Q","B_049"),
("C2_025","Grover","Z","B_050"),
("C3_001","Hall","J","B_051"),
("C3_002","Hank","I","B_052"),
("C3_003","Harold","I","B_053"),
("C3_004","Harriet","O","B_054"),
("C3_005","Harriet","F","B_055"),
("C3_006","Helen","R","B_056"),
("C3_007","Henry","F","B_057"),
("C3_008","Herschel","G","B_058"),
("C3_009","Howard","X","B_059"),
("C3_010","Hugo","N","B_060"),
("C3_011","Idabel","R","B_061"),
("C3_012","Irene","E","B_062"),
("C3_013","James","E","B_063"),
("C3_014","Jane","L","B_064"),
("C3_015","Jasper","I","B_065"),
("C3_016","Jeremiah","J","B_066"),
("C3_017","Jesse","O","B_067"),
("C3_018","John","F","B_068"),
("C3_019","Josiah","L","B_069"),
("C3_020","Judith","T","B_070"),
("C3_021","June","V","B_071"),
("C3_022","Leo","G","B_072"),
("C3_023","Leon","L","B_073"),
("C3_024","Leona","U","B_074"),
("C3_025","Leonard","A","B_075"),
("C4_001","Lorraine","X","B_076"),
("C4_002","Louis","Y","B_077"),
("C4_003","Luther","D","B_078"),
("C4_004","Margaret","D","B_079"),
("C4_005","Marilyn","Z","B_080"),
("C4_006","Marjorie","B","B_081"),
("C4_007","Marvin","S","B_082"),
("C4_008","Morton","B","B_083"),
("C4_009","Nanette","H","B_084"),
("C4_010","Newton","P","B_085"),
("C4_011","Noreen","D","B_086"),
("C4_012","Norma","N","B_087"),
("C4_013","Olive","W","B_088"),
("C4_014","Ophelia","Y","B_089"),
("C4_015","Oscar","K","B_090"),
("C4_016","Otis","T","B_091"),
("C4_017","Owen","D","B_092"),
("C4_018","Penelope","C","B_093"),
("C4_019","Phineas","P","B_094"),
("C4_020","Phoebe","F","B_095"),
("C4_021","Phyllis","A","B_096"),
("C4_022","Ralph","R","B_097"),
("C4_023","Raymond","W","B_098"),
("C4_024","Reuben","N","B_099"),
("C4_025","Richard","C","B_100"),
("C5_001","Robert","C","B_101"),
("C5_002","Roxanne","P","B_102"),
("C5_003","Ruby","H","B_103"),
("C5_004","Ruth","Z","B_104"),
("C5_005","Sadie","T","B_105"),
("C5_006","Saul","S","B_106"),
("C5_007","Sebastian","H","B_107"),
("C5_008","Selma","B","B_108"),
("C5_009","Silas","M","B_109"),
("C5_010","Stanley","E","B_110"),
("C5_011","Thomas","R","B_111"),
("C5_012","Tillie","J","B_112"),
("C5_013","Vernon","N","B_113"),
("C5_014","Vincent","C","B_114"),
("C5_015","Violet","X","B_115"),
("C5_016","Vivian","L","B_116"),
("C5_017","Wallace","O",""),
("C5_018","Wally" ,"X",""),
("C5_019","Walter","U",""),
("C5_020","Warner","G",""),
("C5_021","Warren","T",""),
("C5_022","William","Q",""),
("C5_023","Willie","Q","");

UPDATE
    editor
SET
    B_ID = CASE B_ID WHEN '' THEN NULL ELSE B_ID END;

SELECT * FROM editor;

-- 3 - other method of creating table using work bench screenshot in file.

-- ALTER TABLE company
-- MODIFY company longtext;

-- LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/COMPANY.csv" 
-- INTO TABLE company 
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY ""
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES
-- (C_ID,company,@A,@B,@S,@E)
-- SET
-- A_ID = NULLIF(@A,''),
-- B_ID = NULLIF(@B,''),
-- S_ID = NULLIF(@S,''),
-- E_ID = NULLIF(@E,'')
-- ;

ALTER TABLE company ADD FOREIGN KEY (A_ID) REFERENCES author(A_ID);
ALTER TABLE company ADD FOREIGN KEY (B_ID) REFERENCES book(B_ID);
ALTER TABLE company ADD FOREIGN KEY (S_ID) REFERENCES subjects(S_ID);
ALTER TABLE company ADD FOREIGN KEY (E_ID) REFERENCES editor(E_ID);
UPDATE
    company
SET
    B_ID = CASE B_ID WHEN '' THEN NULL ELSE B_ID END;
UPDATE
    company
SET
    A_ID = CASE A_ID WHEN '' THEN NULL ELSE A_ID END;
UPDATE
    company
SET
    S_ID = CASE S_ID WHEN '' THEN NULL ELSE S_ID END;
UPDATE
    company
SET
    E_ID = CASE E_ID WHEN '' THEN NULL ELSE E_ID END;

-- The entire database, with the initial data is created here. 