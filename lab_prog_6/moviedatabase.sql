use mallika;
create table ACTOR(actid int, actname varchar(30), actgender varchar(30), primary key(actid));
create table DIRECTOR(dirid int,dirname varchar(30),dirphone int,primary key(dirid));
alter table DIRECTOR modify column dirphone varchar(30);
create table MOVIES(movid int,movtitle varchar(50),movyear int,movlang varchar(30),dirid int, primary key(movid),foreign key(dirid) references DIRECTOR(dirid));
create table MOVIECAST(actid int,movid int, role varchar(30), foreign key(actid) references ACTOR(actid),foreign key(movid) references MOVIES(movid));
create table RATING(movid int,revstars int,foreign key(movid) references MOVIES(movid));

insert into ACTOR values(1001,'tom cruise','male');
insert into ACTOR values(1002,'chris evans','male');
insert into ACTOR values(1003,'rdj','male');
insert into ACTOR values(1004,'jennifer lawrence','female');
insert into ACTOR values(1005,'emma stone','female');
insert into ACTOR values(1006,'ingrid bergman','female');
insert into ACTOR values(1007,'tom holland','male');

insert into DIRECTOR values(101,'steven speilberg',4112578654);
insert into DIRECTOR values(102,'hitchcock',4587236632);
insert into DIRECTOR values(103,'francis lawrence',2158874230);
insert into DIRECTOR values(104,'joe russo',5223645874);
insert into DIRECTOR values(105,'damien chazelle',4112256325);

insert into MOVIES values(1,'hunger games',2013,'english',103);
insert into MOVIES values(2,'end game',2019,'english',104);
insert into MOVIES values(9,'infinity war',2018,'english',104);
insert into MOVIES values(3,'the minority report',2002,'english',101);
insert into MOVIES values(4,'la la land',2016,'english',105);
insert into MOVIES values(5,'to catch a thief',1955,'english',102);
insert into MOVIES values(6,'notorious',1946,'english',102);
insert into MOVIES values(7,'e.t',1982,'english',101);
insert into MOVIES values(8,'cherry',2021,'english',104);
insert into MOVIES values(10,'chaplin',1992,'english',101);


insert into MOVIECAST values(1001,3,'lead');
insert into MOVIECAST values(1001,9,'lead');
insert into MOVIECAST values(1002,2,'lead');
insert into MOVIECAST values(1002,9,'lead');
insert into MOVIECAST values(1003,2,'lead');
insert into MOVIECAST values(1004,1,'lead');
insert into MOVIECAST values(1005,4,'lead');
insert into MOVIECAST values(1006,5,'lead');
insert into MOVIECAST values(1007,8,'lead');
insert into MOVIECAST values(1007,2,'lead');
insert into MOVIECAST values(1007,9,'lead');
insert into MOVIECAST values(1003,10,'lead');

insert into RATING values(1,5);
insert into RATING values(2,5);
insert into RATING values(3,3);
insert into RATING values(4,4);
insert into RATING values(5,3);
insert into RATING values(6,2);
insert into RATING values(7,5);
insert into RATING values(8,4);
insert into RATING values(9,5);
insert into RATING values(10,2);

select m.movtitle from MOVIES m, DIRECTOR d where m.dirid=d.dirid and d.dirname='hitchcock';

select m.movtitle from MOVIES m, MOVIECAST c where m.movid=c.movid and actid in (select actid from MOVIECAST group by actid having count(actid)>1) group by movtitle having count(movtitle)>1; 

select a.actname, m.movtitle,m.movyear from ACTOR a join MOVIECAST c on a.actid=c.actid join MOVIES m on c.movid=m.movid where m.movyear and m.movyear not between 2000 and 2015;

select m.movtitle , r.revstars, max(r.revstars) from MOVIES m, RATING r where m.movid=r.movid and count(r.revstars)>=1 order by m.movtitle;

select movtitle, max(revstars) from MOVIES inner join RATING using (movid) group by movtitle having max(revstars)>0 order by movtitle;

update RATING set revstars=5 where movid=3 or movid=7 or movid=10;
select * from RATING;
