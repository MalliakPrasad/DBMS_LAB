use mallika;

create table STUDENT(regno varchar(30),name varchar(30),major varchar(30),bdate date, primary key(regno));
create table COURSE(courseno int,cname varchar(30),dept varchar(30), primary key(courseno));
create table ENROLL(regno varchar(30),courseno int, marks int,sem int, foreign key(regno) references STUDENT(regno) on delete cascade on update cascade, foreign key(courseno) references COURSE(courseno) on delete cascade on update cascade);
create table BOOK_ADOPTION(courseno int,sem int, bookisbn int, foreign key(courseno) references COURSE(courseno) on delete cascade on update cascade, foreign key(bookisbn) references TEXTS(bookisbn));
create table TEXTS(bookisbn int,booktitle varchar(30),publisher varchar(30),author varchar(30), primary key(bookisbn));

insert into STUDENT values('CS01','RAM','DS','1986-03-12');
insert into STUDENT values('IS02','SMITH','USP','1987-12-23');
insert into STUDENT values('EC03','AHMED','SNS','1985-04-17');
insert into STUDENT values('CS03','SNEHA','DBMS','1987-01-01');
insert into STUDENT values('TC05','AKHILA','EC','1986-10-06');

insert into COURSE values(11,'DS','CS');
insert into COURSE values(22,'USP','IS');
insert into COURSE values(33,'SNS','EC');
insert into COURSE values(44,'DBMS','CS');
insert into COURSE values(55,'EC','TC');

insert into ENROLL values('CS01',11,4,85);
insert into ENROLL values('IS02',22,6,80);
insert into ENROLL values('EC03',33,2,80);
insert into ENROLL values('CS03',44,6,75);
insert into ENROLL values('TC05',55,2,8);

insert into TEXTS values(1,'DS AND C','PRINCETON','PADMA REDDY');
insert into TEXTS values(2,'FUNDAMENTALS OF DS','PRINCETON','GODSE');
insert into TEXTS values(3,'FUNDAMENTALS OF DBMS','PRINCETON','NAVATHE');
insert into TEXTS values(4,'SQL','PRINCETON','FOLEY');
insert into TEXTS values(5,'ELECTRONIC CIRCUITS','TMH','ELMASRI');
insert into TEXTS values(6,'ADV UNIX PROG','TMH','STEVENS');

insert into BOOK_ADOPTION values(11,4,1);
insert into BOOK_ADOPTION values(11,4,2);
insert into BOOK_ADOPTION values(44,6,3);
insert into BOOK_ADOPTION values(44,6,4);
insert into BOOK_ADOPTION values(55,2,5);
insert into BOOK_ADOPTION values(22,6,6);

insert into TEXTS values(7,'GET STARTED WITH C','PRINCETON','THOMSON');
insert into BOOK_ADOPTION values(55,4,7);
select * from TEXTS;
select * from BOOK_ADOPTION;

select c.courseno,b.bookisbn,t.booktitle from BOOK_ADOPTION b,TEXTS t,COURSE c
where c.courseno=b.courseno
and b.bookisbn=t.bookisbn
and c.dept='CS'
group by b.courseno having count(b.courseno)>=2 order by t.booktitle;

select distinct c.dept from COURSE c, BOOK_ADOPTION b, TEXTS t
where c.courseno=b.courseno
and b.bookisbn=t.bookisbn
and t.publisher='PRINCETON';