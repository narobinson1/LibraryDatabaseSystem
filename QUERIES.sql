-- 1. Find members by librarycardid who are suspended 

SELECT * FROM MEMBER WHERE OUTSTANDINGDEBT > 10; 

/*

Output:

LIBRARYCARDID	OUTSTANDINGDEBT
6	            12

*/

-- 2. Find person who has borrowed most resources between 2 Nov 2019 and 9 Nov 2019; 

SELECT LIBRARYCARDID FROM WEEK 
ORDER BY LIBRARYCARDID DESC 
FETCH FIRST 1 ROW ONLY; 

/*
Output:

LIBRARYCARDID
6
*/


-- 3. Find everyone who has never borrowed anything.

SELECT LIBRARYCARDID FROM MEMBER  
WHERE (LIBRARYCARDID NOT IN (SELECT LIBRARYCARDID FROM LOANARCHIVE))  
AND (LIBRARYCARDID NOT IN (SELECT LIBRARYCARDID FROM LOAN))
ORDER BY LIBRARYCARDID; 

/*

Output:

LIBRARYCARDID
4
5
7
8
9
10
11

 */

-- 4. List all resources that each student currently is loaning out 

SELECT FULLNAME, RESOURCEID  
FROM STUDENT  
INNER JOIN MEMBER ON STUDENT.LIBRARYCARDID = MEMBER.LIBRARYCARDID  
INNER JOIN LOAN ON MEMBER.LIBRARYCARDID = LOAN.LIBRARYCARDID; 


/*

Output:

FULLNAME	RESOURCEID
STUDENT A	1
STUDENT B	2

*/

-- 5. Find reservation list for all books on floor 1 

SELECT RESERVATIONID, RESERVATIONDATE, RESOURCES.RESOURCEID FROM RESERVATION INNER JOIN RESOURCES ON reservation.resourceID = resources.resourceID INNER JOIN BOOK on reservation.resourceID = book.resourceID 
WHERE resources.floornumber = 1; 

/*

Output:


RESERVATIONID	RESERVATIONDATE	RESOURCEID
1	            01-NOV-19	    1
2	            02-NOV-19	    1
3	            02-DEC-19	    1
4	            02-JAN-20	    1

*/

-- 6. List all payments made by students 

SELECT * FROM FINEPAYMENT WHERE LIBRARYCARDID IN (SELECT LIBRARYCARDID FROM STU); 

/*

Output:


FINEPAYMENTID	LIBRARYCARDID	PAYMENTDATE	PAYMENTAMOUNT
1	            1	            01-MAY-19	10
2	            3	            01-DEC-19	15


*/

-- 7. List of all books that can be borrowed

SELECT TITLE, AUTHORNAME FROM BOOK JOIN RESOURCES ON book.RESOURCEID = resources.RESOURCEID  
WHERE resources.MAXLOANLENGTH > 0 and resources.ISAVAILABLE = 1; 

/*

Output:

TITLE	                    AUTHORNAME
INTRODUCTION TO MICROECON	DEPARTMENT OF ECON
INTRODUCTION TO MICROECON	DEPARTMENT OF ECON
INTRODUCTION TO MICROECON	DEPARTMENT OF ECON
INTRODUCTION TO PROGRAMMING	FABRIZIO
INTRODUCTION TO PROGRAMMING	FABRIZIO
INTRODUCTION TO PROGRAMMING	FABRIZIO

*/


-- 8. List of all people who have failed to take up any reservations more than 1 time 

SELECT * FROM RESERVATION R, MEMBER M 
WHERE M.LIBRARYCARDID = R.LIBRARYCARDID 
AND RESERVATIONATTEMPTS > 1; 

/*

Output:


RESERVATIONID	LIBRARYCARDID	RESOURCEID	RESERVATIONDATE	RESERVATIONATTEMPTS	LIBRARYCARDID	OUTSTANDINGDEBT
4	            1	            1	        02-JAN-20	    2	                1	            0

*/

-- 9. List of all resources on floor 0

SELECT * FROM RESOURCES 
WHERE FLOORNUMBER = 0; 

/*

Output:


RESOURCEID	ISAVAILABLE	MAXLOANLENGTH	FLOORNUMBER	SHELFMARK
1000000	    1	        14	            0	        6
1000001	    1	        14	            0	        6
1000002	    1	        14	            0	        6
1000010	    1	        2	            0	        6
1000011	    1	        2	            0	        6
1000012	    1	        2	            0	        6
1000020	    1	        14	            0	        6
1000021	    1	        14	            0	        6
1000022	    1	        14	            0	        6
2000000	    1	        0	            0	        6
2000001	    1	        0	            0	        6
2000002	    1	        0	            0	        6
2000003	    1	        0	            0	        6
2000004	    1	        0	            0	        6
2000005	    1	        0	            0	        6


*/

-- 10. List of the most popular books loaned with loan count sorted by count

SELECT TITLE, COUNT(RESOURCES.RESOURCEID) 
FROM BOOK  
INNER JOIN RESOURCES ON BOOK.RESOURCEID = RESOURCES.RESOURCEID  
INNER JOIN LOANARCHIVE ON RESOURCES.RESOURCEID = LOANARCHIVE.RESOURCEID 
GROUP BY TITLE ORDER BY COUNT(RESOURCES.RESOURCEID) DESC; 

/*

Output:

TITLE	                    COUNT(RESOURCES.RESOURCEID)
INTRODUCTION TO MICROECON	2
INTRODUCTION TO PROGRAMMING	1
*/


-- 11. List of all overdue resources 

SELECT LOAN.RESOURCEID FROM LOAN INNER JOIN RESOURCES ON LOAN.RESOURCEID = RESOURCES.RESOURCEID WHERE CURRENT_DATE > LOANDATE; 

/*

Output:

RESOURCEID
1
2
12
11
10

*/




-- 12. List of all members who have outstanding fines less than $2 

SELECT * FROM MEMBER WHERE OUTSTANDINGDEBT < 2; 

/*

Output:

LIBRARYCARDID	OUTSTANDINGDEBT
1	            0
2	            0
3	            0
4	            0
5	            0
7	            0
8	            0
9	            0
10	            0
11              0


*/



