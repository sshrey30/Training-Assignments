CREATE TABLE Member (
    Member_Id NUMBER(5) PRIMARY KEY,
    Member_Name VARCHAR2(30),
    Member_Address VARCHAR2(50),
    Acc_Open_Date DATE,
    Membership_Type VARCHAR2(20),
    Fees_Paid NUMBER(4),
    Max_Books_Allowed NUMBER(2),
    Penalty_Amount NUMBER(7,2)
);

CREATE TABLE Books (
    Book_No NUMBER(6) PRIMARY KEY,
    Book_Name VARCHAR2(30),
    Author_Name VARCHAR2(30),
    Cost NUMBER(7,2),
    Category CHAR(10)
);

CREATE TABLE Issue (
    Lib_Issue_Id NUMBER(10) PRIMARY KEY,
    Book_No NUMBER(6),
    Member_Id NUMBER(5),
    Issue_Date DATE,
    Return_Date DATE,
    FOREIGN KEY (Book_No) REFERENCES Books(Book_No),
    FOREIGN KEY (Member_Id) REFERENCES Member(Member_Id)
);

INSERT INTO Member VALUES (101, 'Rishi Kumar', 'Delhi',   DATE '2006-07-10', 'Lifetime',   2000, 5, 150.50);
INSERT INTO Member VALUES (102, 'Geeta Iyer', 'Mumbai',  DATE '2006-11-15', 'Annual',     1200, 4,  75.00);
INSERT INTO Member VALUES (103, 'Loni Patel', 'Pune',    DATE '2007-02-20', 'Half Yearly',800,  3,   0.00);
INSERT INTO Member VALUES (104, 'Ravi Singh', 'Kolkata', DATE '2005-05-01', 'Quarterly',  500,  2, 300.00);
INSERT INTO Member VALUES (105, 'Girish Nair', 'Chennai',DATE '2008-01-12', 'Annual',     1500, 6,  50.00);
INSERT INTO Member VALUES (106, 'Manoj Das', 'Hyderabad',DATE '2006-03-21', 'Lifetime',   2500, 8,  25.00);

INSERT INTO Books VALUES (2001, 'Learn SQL Basics',      'Loni',        550.00, 'Database');
INSERT INTO Books VALUES (2002, 'Advanced Database SQL', 'John Doe',    700.00, 'Database');
INSERT INTO Books VALUES (2003, 'Quantum Science',       'Albert',      650.00, 'Science');
INSERT INTO Books VALUES (2004, 'Fictional Tales',       'George',      400.00, 'Fiction');
INSERT INTO Books VALUES (2005, 'Management 101',        'Peter',       800.00, 'Management');
INSERT INTO Books VALUES (2006, 'Database Systems',      'Korth',       600.00, 'Database');
INSERT INTO Books VALUES (2007, 'RDBMS Concepts',        'Elmasri',     950.00, 'RDBMS');
INSERT INTO Books VALUES (2008, 'Science Experiments',   'Newton',      500.00, 'Science');
INSERT INTO Books VALUES (2009, 'Operating Systems',     'Tanenbaum',   1200.00,'Others');
INSERT INTO Books VALUES (2010, 'SQL for Beginners',     'Sharma',      300.00, 'Database');

INSERT INTO Issue VALUES (7001, 2001, 101, DATE '2006-07-10', DATE '2006-07-20');
INSERT INTO Issue VALUES (7002, 2002, 101, DATE '2006-07-15', NULL);
INSERT INTO Issue VALUES (7003, 2003, 101, DATE '2006-08-01', DATE '2006-09-10');
INSERT INTO Issue VALUES (7004, 2004, 102, DATE '2006-11-20', DATE '2006-12-01');
INSERT INTO Issue VALUES (7005, 2005, 103, DATE '2007-03-01', NULL); 
INSERT INTO Issue VALUES (7006, 2006, 104, DATE '2007-04-05', NULL); 
INSERT INTO Issue VALUES (7007, 2007, 105, DATE '2008-02-01', DATE '2008-02-20');
INSERT INTO Issue VALUES (7008, 2008, 106, DATE '2006-03-22', DATE '2006-04-25');
INSERT INTO Issue VALUES (7009, 2009, 102, DATE '2007-05-10', NULL); 
INSERT INTO Issue VALUES (7010, 2010, 104, DATE '2005-05-02', DATE '2005-05-20');

--1)	List all the books that are written by Author Loni and has price less then 600.
SELECT * FROM BOOKS WHERE AUTHOR_NAME = 'Loni' AND COST < 600;

--2)	List the Issue details for the books that are not returned yet.
SELECT * FROM ISSUE WHERE RETURN_DATE IS NULL;

--3)	Update all the blank return_date with 31-Dec-06 excluding 7005 and 7006.
UPDATE ISSUE SET RETURN_DATE = DATE '2006-12-31' WHERE RETURN_DATE IS NULL AND Lib_Issue_Id NOT IN (7005, 7006);
SELECT * FROM ISSUE;

--4)	List all the Issue details that have books issued for more then 30 days.
SELECT * FROM ISSUE WHERE RETURN_DATE IS NOT NULL AND (RETURN_DATE-ISSUE_DATE > 30);

--5)	List all the books that have price in range of 500 to 750 and has category as Database.
SELECT * FROM BOOKS WHERE COST BETWEEN 500 AND 750 AND CATEGORY = 'Database';

--6)	List all the books that belong to any one of the following categories Science, Database, Fiction, Management.
SELECT * FROM BOOKS WHERE CATEGORY IN ('Science', 'Database', 'Fiction', 'Management');

--7)	List all the members in the descending order of Penalty due on them.
SELECT * FROM MEMBER ORDER BY PENALTY_AMOUNT DESC;

--8)	List all the books in ascending order of category and descending order of price.
SELECT * FROM BOOKS ORDER BY CATEGORY ASC, COST DESC;

--9)	List all the books that contain word SQL in the name of the book.
SELECT * FROM BOOKS WHERE BOOK_NAME LIKE '%SQL%';

--10)	List all the members whose name starts with R or G and contains letter I in it.
SELECT * FROM MEMBER WHERE (MEMBER_NAME LIKE 'R%' OR MEMBER_NAME LIKE 'G%') AND MEMBER_NAME LIKE '%I%';

--11)	List the entire book name in Init cap and author in upper case in the descending order of the book name.
SELECT INITCAP(BOOK_NAME), UPPER(AUTHOR_NAME) FROM BOOKS ORDER BY BOOK_NAME DESC;

--12)	List the Issue Details for all the books issue by member 101   with Issue_date and Return Date in following format. ‘Monday,  July, 10, 2006’.
SELECT LIB_ISSUE_ID, BOOK_NO, MEMBER_ID, TO_CHAR(ISSUE_DATE, 'Day, Month, dd, yyyy'), TO_CHAR(RETURN_DATE, 'Day, Month, dd, yyyy') FROM ISSUE WHERE MEMBER_ID = 101;

--13)	List the data in the book table with category data displayed as D for Database, S for Science, R for RDBMS and O for all the others.
SELECT Book_No, Book_Name,
       CASE 
           WHEN Category = 'Database' THEN 'D'
           WHEN Category = 'Science'  THEN 'S'
           WHEN Category = 'RDBMS'    THEN 'R'
           ELSE 'O'
       END AS Category_Code
FROM Books;

--14)	List all the members that became the member in the year 2006.
SELECT * FROM MEMBER WHERE TO_CHAR(ACC_OPEN_DATE, 'yyyy') = '2006';

--15)	List the Lib_Issue_Id, Issue_Date, Return_Date and No of days Book was issued.
SELECT LIB_ISSUE_ID, ISSUE_DATE, RETURN_DATE, (RETURN_DATE-ISSUE_DATE) AS NO_OF_DAYS_ISSUED FROM ISSUE;

--16)	Find the details of the member of the Library in the order of their joining the library.
SELECT * FROM MEMBER ORDER BY ACC_OPEN_DATE ASC;

--17)	Display the count of total no of books issued to Member 101.
SELECT COUNT(BOOK_NO) FROM ISSUE WHERE MEMBER_ID=101;

--18)	Display the total penalty due for all the members.
SELECT SUM(PENALTY_AMOUNT) FROM MEMBER;

--19)	Display the total no of members 
SELECT COUNT(MEMBER_ID) FROM MEMBER;

--20)	Display the total no of books issued 
SELECT COUNT(LIB_ISSUE_ID) FROM ISSUE;

--21)	Display the average membership fees paid by all the members
SELECT AVG(FEES_PAID) FROM MEMBER;

--22)	Display no of months between issue date and return date for all issue
SELECT Lib_Issue_Id,
       FLOOR(MONTHS_BETWEEN(Return_Date, Issue_Date)) AS Months_Between
FROM Issue
WHERE Return_Date IS NOT NULL;


--23)	Display the length of member’s name
SELECT Member_Id, Member_Name, LENGTH(Member_Name) FROM Member;

--24)	Display the first 5 characters of  membership_type for all members
SELECT Member_Id, SUBSTR(Membership_Type, 1, 5) AS FROM Member;

--25)	Display the last day of the month of issue date 
SELECT Lib_Issue_Id, Issue_Date, LAST_DAY(Issue_Date) FROM Issue;
