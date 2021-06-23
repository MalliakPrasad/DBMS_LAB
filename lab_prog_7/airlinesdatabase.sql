use mallika;
create table FLIGHTS(flno int,fromm varchar(30),too varchar(30),distance int,departs time,arrives time, price int,primary key(flno));
create table AIRCRAFT(aid int,aname varchar(30),cruisingrange int, primary key(aid));
create table CERTIFIED(eid int,aid int,foreign key(eid) references EMPLOYEE(eid), foreign key(aid) references AIRCRAFT(aid));
create table EMPLOYEE(eid int, ename varchar(30),salary int, primary key(eid));

INSERT INTO FLIGHTS (flno,fromm,too,distance,departs,arrives,price) VALUES 
(1,'Bangalore','Chennai',360,'08:45','10:00',10000),
(2,'Bangalore','Delhi',1700,'12:15','15:00',37000),
(3,'Bangalore','Kolkata',1500,'15:15','05:25',30000),
(4,'Mumbai','Delhi',1200,'10:30','12:30',28000),
(5,'Bangalore','New york',14000,'05:45','02:30',90000),
(6,'Delhi','Chicago',12000,'10:00','05:45',95000),
(7,'Bangalore','Frankfurt',15000,'12:00','06:30',98000), 
(8,'Madison','New york',1500,'10:15','14:25',30000);


INSERT INTO AIRCRAFT (aid,aname,cruisingrange) values 
        (1,'Airbus 380',1000),
        (2,'Boeing 737',4000),
        (3,'Lockheed',5500),
        (4,'Airbus A220',9500), 
        (5,'Boeing 747',800),
        (6,'Douglas DC3',900);


INSERT INTO EMPLOYEE (eid,ename,salary) VALUES
(1,'Zoya',95000),
(2,'Akshay',65000),
(3,'Niveditha',70000),
(4,'Safan',45000),
(5,'Peter',95000),
(6,'Nayan',100000), 
(7,'Ajay',50000);


INSERT INTO CERTIFIED (eid,aid) VALUES
(1,1),
(1,3),
(1,4),
(5,4),
(5,3),
(1,2),
 (2,6),
(2,5),
(4,5),
(6,4),
(6,3),
(3,6),
(3,2);

SELECT DISTINCT A.aname FROM AIRCRAFT A WHERE A.aid IN (SELECT C.aid FROM CERTIFIED C, EMPLOYEE E WHERE C.eid = E.eid AND NOT EXISTS ( SELECT * FROM EMPLOYEE E1 WHERE E1.eid = E.eid AND E1.salary < 80000 ));
SELECT C.eid, MAX(A.cruisingrange) FROM CERTIFIED C, AIRCRAFT A WHERE C.aid = A.aid GROUP BY C.eid HAVING COUNT(*) > 3;
SELECT DISTINCT e.ename FROM EMPLOYEE e WHERE e.salary< (SELECT MIN(f.price) FROM FLIGHTS f WHERE f.fromm='Bangalore' AND f.too='Frankfurt');
SELECT a.aid,a.aname,AVG(e.salary) FROM AIRCRAFT a,CERTIFIED c,EMPLOYEE e WHERE a.aid=c.aid AND c.eid=e.eid AND a.cruisingrange>1000 GROUP BY a.aid,a.aname;
SELECT distinct e.ename FROM EMPLOYEE e,AIRCRAFT a,CERTIFIED c WHERE e.eid=c.eid AND c.aid=a.aid AND a.aname like 'Boeing%';
SELECT a.aid FROM AIRCRAFT a WHERE a.cruisingrange> (SELECT MIN(f.distance) FROM FLIGHTS f WHERE f.fromm='Bangalore' AND f.too='Delhi');
SELECT F.departs FROM FLIGHTS F WHERE F.flno IN (  SELECT F0.flno FROM FLIGHTS F0 WHERE F0.fromm = 'Madison' AND F0.too = 'New york' AND F0.arrives < '18:00' );
SELECT E.ename, E.salary FROM EMPLOYEE E WHERE E.eid NOT IN ( SELECT DISTINCT C.eid FROM CERTIFIED C ) AND E.salary > ( SELECT AVG (E1.salary) FROM EMPLOYEE E1 WHERE E1.eid IN ( SELECT DISTINCT C1.eid FROM CERTIFIED C1 ) );