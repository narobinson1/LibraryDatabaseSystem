-- View of everyone who has outstanding loans 

CREATE VIEW OUTSTANDINGLOANS AS 
SELECT LIBRARYCARDID FROM LOAN; 

-- View of library members who are students 

CREATE VIEW STU AS 
SELECT * FROM MEMBER 
WHERE LIBRARYCARDID IN (SELECT LIBRARYCARDID FROM STUDENT); 

-- View of library members who are staff 

CREATE VIEW STA AS 
SELECT * FROM MEMBER 
WHERE LIBRARYCARDID IN (SELECT LIBRARYCARDID FROM STAFF); 

-- View of students who have outstanding fines 

CREATE VIEW OUTSTANDINGFINES AS 
SELECT * FROM STU 
WHERE OUTSTANDINGDEBT > 0; 

-- View of staff who have outstanding reservations 
 
CREATE VIEW OUTSTANDINGRESERVATIONS AS 
SELECT * FROM RESERVATION WHERE LIBRARYCARDID IN (SELECT LIBRARYCARDID FROM STA); 
 
-- View of resources borrowed between 2 Nov 2019 and 9 Nov 2019 

CREATE VIEW WEEK AS 
SELECT * FROM LOAN  
WHERE LOANDATE BETWEEN '2-NOV-2019' AND '9-NOV-2019';

/* Please check apostrophes when copying into Live SQL, it sometimes does not copy the correct syntax and instead copies a different unicode character (curly apostrophe) */