use mallika;
create table CUSTOMER(custno int, cname varchar(30), city varchar(30), primary key(custno));
create table ORDERS(orderno int,odate date,custno int,ordamt int, primary key(orderno), foreign key(custno) references CUSTOMER(custno));
create table ITEM(itemno int,unitprice int, primary key(itemno));
create table ORDERITEM(orderno int,itemno int, qty int, foreign key(orderno) references ORDERS(orderno) ON DELETE SET NULL ON UPDATE CASCADE, foreign key(itemno) references ITEM(itemno) ON DELETE SET NULL ON UPDATE CASCADE);
create table WAREHOUSE(warehouseno int,city varchar(30), primary key(warehouseno));
create table SHIPMENT(orderno int,warehouseno int,shipdate date, foreign key(orderno) references ORDERS(orderno), foreign key(warehouseno) references WAREHOUSE(warehouseno));


INSERT INTO CUSTOMER VALUES(771,'PUSHPA K','BANGALORE');
INSERT INTO CUSTOMER VALUES(772,'SUMAN','MUMBAI');
INSERT INTO CUSTOMER VALUES(773,'SOURAV','CALICUT');
INSERT INTO CUSTOMER VALUES(774,'LAILA','HYDERABAD');
INSERT INTO CUSTOMER VALUES(775,'FAIZAL','BANGALORE');

INSERT INTO ORDERS VALUES(111,'2002-01-22',771,18000);
INSERT INTO ORDERS VALUES(112,'2002-07-30',774,6000);
INSERT INTO ORDERS VALUES(113,'2003-04-03',775,9000);
INSERT INTO ORDERS VALUES(114,'2003-11-03',775,29000);
INSERT INTO ORDERS VALUES(115,'2003-12-10',773,29000);
INSERT INTO ORDERS VALUES(116,'2004-08-19',772,56000);
INSERT INTO ORDERS VALUES(117,'2004-09-10',771,20000);
INSERT INTO ORDERS VALUES(118,'2004-11-20',775,29000);
INSERT INTO ORDERS VALUES(119,'2005-02-13',774,29000);
INSERT INTO ORDERS VALUES(120,'2005-10-13',775,29000);

INSERT INTO ITEM VALUES(5001,503);
INSERT INTO ITEM VALUES(5002,750);
INSERT INTO ITEM VALUES(5003,150);
INSERT INTO ITEM VALUES(5004,600);
INSERT INTO ITEM VALUES(5005,890);

INSERT INTO ORDERITEM VALUES(111,5001,50);
INSERT INTO ORDERITEM VALUES(112,5003,20);
INSERT INTO ORDERITEM VALUES(113,5002,50);
INSERT INTO ORDERITEM VALUES(114,5005,60);
INSERT INTO ORDERITEM VALUES(115,5004,90);
INSERT INTO ORDERITEM VALUES(116,5001,10);
INSERT INTO ORDERITEM VALUES(117,5003,80);
INSERT INTO ORDERITEM VALUES(118,5005,50);
INSERT INTO ORDERITEM VALUES(119,5002,10);
INSERT INTO ORDERITEM VALUES(120,5004,45);

INSERT INTO WAREHOUSE VALUES(1,'DELHI');
INSERT INTO WAREHOUSE VALUES(2,'BOMBAY');
INSERT INTO WAREHOUSE VALUES(3,'CHENNAI');
INSERT INTO WAREHOUSE VALUES(4,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(5,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(6,'DELHI');
INSERT INTO WAREHOUSE VALUES(7,'BOMBAY');
INSERT INTO WAREHOUSE VALUES(8,'CHENNAI');
INSERT INTO WAREHOUSE VALUES(9,'DELHI');
INSERT INTO WAREHOUSE VALUES(10,'BANGALORE');

INSERT INTO SHIPMENT VALUES(111,1,'2002-02-10');
INSERT INTO SHIPMENT VALUES(112,5,'2002-09-10');
INSERT INTO SHIPMENT VALUES(113,8,'2003-02-10');
INSERT INTO SHIPMENT VALUES(114,3,'2003-12-10');
INSERT INTO SHIPMENT VALUES(115,9,'2004-01-19');
INSERT INTO SHIPMENT VALUES(116,1,'2004-09-20');
INSERT INTO SHIPMENT VALUES(117,5,'2004-09-10');
INSERT INTO SHIPMENT VALUES(118,7,'2004-11-30');
INSERT INTO SHIPMENT VALUES(119,7,'2005-04-30');
INSERT INTO SHIPMENT VALUES(120,6,'2005-12-21');   

select c.cname,count(o.orderno),avg(o.ordamt) from CUSTOMER c, ORDERS o where c.custno=o.custno group by o.custno;
select s.orderno from SHIPMENT s, WAREHOUSE w where s.warehouseno=w.warehouseno and w.city='bangalore';
delete from ITEM i where i.itemno=5001;
select * from ITEM;
