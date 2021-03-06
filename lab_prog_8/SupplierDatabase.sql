use mallika;

create table Suppliers
(sid int,
sname varchar(30),
address varchar(30),
primary key(sid));

create table Parts
(pid int,
pname varchar(30),
color varchar(15),
primary key(pid));

create table Catalogs
(sid int,
pid int,
cost float,
primary key(sid,pid),
foreign key(sid) references suppliers(sid),
foreign key(pid) references parts(pid));

insert into Suppliers
values(10001,"Acme Widget","Bangalore"),
	  (10002,"Johns","Kolkata"),
      (10003,"Vimal","Mumbai"),
      (10004,"Reliance","Delhi");
select * from suppliers;

insert into Parts
values(20001,"Book","Red"),
      (20002,"Pen","Red"),
      (20003,"Pencil","Green"),
      (20004,"Mobile","Green"),
      (20005,"Charger","Black");
select * from parts;

insert into Catalogs
values(10001,20001,10),
      (10001,20002,10),
      (10001,20003,30),
      (10001,20004,10),
      (10001,20005,10),
      (10002,20001,10),
      (10002,20002,20),
      (10003,20003,30),
      (10004,20003,40);
select * from catalogs;
/* 1 - FIND THE PNAMES OF PARTS FOR WHICH THERE IS SOME SUPPLIER. */
SELECT DISTINCT P.PNAME
 FROM PARTS P, CATALOGS C
 WHERE P.PID = C.PID;

/* FIND THE SNAMES OF SUPPLIERS WHO SUPPLY EVERY PART */
SELECT S.SNAME FROM SUPPLIERS S WHERE NOT EXISTS (SELECT P.PID FROM
PARTS P WHERE NOT EXISTS (SELECT C.SID FROM CATALOGS C WHERE C.SID =
S.SID AND C.PID = P.PID));

/* FIND THE SNAMES OF SUPPLIERS WHO SUPPLY EVERY RED PART. */
SELECT S.SNAME FROM SUPPLIERS S WHERE NOT EXISTS (SELECT P.PID FROM
PARTS P WHERE P.COLOR = 'RED' AND (NOT EXISTS (SELECT C.SID FROM
CATALOGS C WHERE C.SID = S.SID AND C.PID = P.PID)));

/* FIND THE PNAMES OF PARTS SUPPLIED BY ACME WIDGET SUPPLIERS AND BY NO ONE ELSE */
SELECT P.PNAME FROM PARTS P, CATALOGS C, SUPPLIERS S WHERE P.PID
= C.PID AND C.SID = S.SID AND S.SNAME = 'ACME WIDGET' AND NOT EXISTS
(SELECT * FROM CATALOGS C1, SUPPLIERS S1 WHERE P.PID = C1.PID AND
C1.SID = S1.SID AND S1.SNAME <> 'ACME WIDGET');

/* FIND THE SIDS OF SUPPLIERS WHO CHARGE MORE FOR SOME PART THAN THE AVERAGE COST OF THAT PART (AVERAGED OVER
ALL THE SUPPLIERS WHO SUPPLY THAT PART).
 */
SELECT DISTINCT C.SID FROM CATALOGS C
WHERE C.COST > ( SELECT AVG (C1.COST)
FROM CATALOGS C1
WHERE C1.PID = C.PID );

/* FOR EACH PART, FIND THE SNAME OF THE SUPPLIER WHO CHARGES THE MOST FOR THAT PART.*/
SELECT P.PID, S.SNAME
FROM PARTS P, SUPPLIERS S, CATALOGS C
WHERE C.PID = P.PID
AND C.SID = S.SID
AND C.COST = (SELECT MAX(C1.COST)
FROM CATALOGS C1
WHERE C1.PID = P.PID);

/* FIND THE SIDS OF SUPPLIERS WHO SUPPLY ONLY RED PARTS.*/
SELECT DISTINCT C.SID
FROM CATALOGS C
WHERE NOT EXISTS ( SELECT *
FROM PARTS P
WHERE P.PID = C.PID AND P.COLOR <> 'RED' );