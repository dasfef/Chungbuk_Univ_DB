create user c##RESTAURANT identified by madang;
grant connect, resource to c##RESTAURANT;
alter user c##restaurant default tablespace users quota unlimited on users;

create table RESTAURANT(
restid int not null primary key,
restname varchar(50),
address varchar(100),
phone varchar(20),
openhours varchar(50),
restrating int);

create table MENU (
menuid int primary key,
restid int not null,
menuname varchar(50),
describe varchar(255),
price int, 

foreign key(restid) references restaurant(restid));

create table REVIEW (
reviewid int primary key,
restid int not null,
menuid int,
orderer varchar(50), 
r_text varchar(255),
reviewrating int,
wrottendate date,

foreign key(restid) references restaurant(restid),
foreign key(menuid) references menu(menuid)
--foreign key(orderer) references menu(orderer)
);

/*drop table menu;
drop table restaurant;
drop table review; */


INSERT INTO Restaurant (restId, restName, address, phone, openHours, restRating)
select 1, '�Ե�����', '����Ư���� ������ ������ 95�� 20', '02-1234-5678', '10:00 - 22:00', 5 from dual union all
select 2, '�Ƶ�����', '�λ걤���� �ؿ�뱸 �ؿ���غ��� 280', '051-9876-5432', '11:00 - 23:00', 3 from dual union all
select 3, '����ŷ', '�뱸������ ������ ������ 45�� 8', '053-4567-1234', '09:00 - 21:00', 4 from dual union all
select 4, '������ġ', '��õ������ ������ �����þƴ�� 123', '032-7890-1234', '11:00 - 23:00', 4 from dual;

INSERT INTO Menu (menuId, restId, menuName, describe, price)
select 1, 1, '�Ұ�����', '�ѱ� ������ �Ұ�� �� �ܹ���.', 4500 from dual union all
select 2, 1, '�������', '��ŵ��� ���� ���� �ƴ°�.', 4500 from dual union all
select 3, 2, '���', '��������� �� ���.', 5200 from dual union all
select 4, 2, '��ġŲ', '��ġŲ������ ��� �ܹ��Ŵ�.', 3500 from dual union all
select 5, 3, '����', '�Ҹ����� �ܹ���.', 6900 from dual union all
select 6, 3, 'ŷġŲ����', '����ŷ �־�ü.', 3600 from dual union all
select 7, 4, '���̹���', '���彺Ÿ ���̿� ���� ����.', 4300 from dual union all
select 8, 4, 'ȭ��Ʈ��������', '���� ���� �ܹ���.', 4600 from dual;

/*alter table menu drop column orderer;*/

INSERT INTO Review (reviewId, restId, menuid, orderer, r_text, reviewRating, wrottendate)
select 1, 1, 1, '�̵���', '�� �ܹ����� ������ ��ġ��, �ҽ��� �Ϻ��ϰ� ��췯�� �־��!', 1, '2023-02-15' from dual union all
select 2, 1, 2, '�ֿ���', '�ܹ��Ű� ũ�� ����ؼ� ��θ��� ���� �� �־� ���ҽ��ϴ�.', 3, '2023-01-28' from dual union all
select 3, 4, 7, '����ä', '�ܹ��Ű� ¥��.', 1, '2023-02-20' from dual union all
select 4, 4, 8, '�� ���̽�', '�ż��� ��ä�� �ٻ��� Ƣ���� ��췯�� �ܹ��Ű� �λ����̾����ϴ�.', 2, '2023-03-05' from dual union all
select 5, 3, 5, '���ε� Ʈ����', '�ܹ��� ���� �ε巴�� ����� ���� ���Ҿ��.', 4, '2023-01-10' from dual union all
select 6, 3, 5, '�̵���', '�����̽��� �ҽ��� �� �ܹ��ŷ�, ������ ���� �����ϴ� ����鿡�� ��õ�մϴ�.', 1, '2023-03-12' from dual union all
select 7, 2, 4, '�̵���', '���İ�Ƽ�� �� ���־�� ���޴޴��ؼ� ���������� �����մϴ�.', 4,'2023-03-21' from dual union all
select 8, 4, 7, '����ä', '������ ��������', 2,'2023-02-20' from dual union all
select 9, 4, 7, '����ä', '�˹ٰ� �������', 1,'2023-01-20' from dual union all
select 10, 4, 7, '�ֿ���', '���� ��������� �𸣰ھ��', 1,'2023-03-11' from dual union all
select 11, 2, 4, '�ֿ���', '�� �ܹ��Ŵ� ���� ��ä�� ������ �� �¾�, ����� ���� ��� �� �־����ϴ�.', 1, '2023-02-05' from dual;


--1 ��ϵ� ������ ���������� ��� ���
SELECT *
FROM Restaurant
ORDER BY restRating;

--2 �޴� �����̼ǿ��� ������ 4500�̻� 5500�̸��� �޴��� ���
SELECT *
FROM Menu
WHERE price >= 4500 and price <5500;

--3 ���並 ��¥������ ��ü ���
SELECT *
FROM Review
ORDER BY wrottendate;

--4 ����4�� �̻��� ��������� ������ ���
SELECT restName, restRating
FROM Restaurant
WHERE restRating >= 4;


--5 �޴� �̸��� 'ġŲ'�� �� �޴��� ��ǰ�̸�, ��ǰ������ ��� 
SELECT menuName, price
FROM Menu
WHERE Menuname LIKE '%ġŲ%'
ORDER BY price;

--6 �Һ��� ���� 3�� �̻��� ���� ������ ���������� ���
SELECT reviewRating, r_text
FROM Review
WHERE reviewRating >= 3
ORDER BY reviewRating;

--7 ���������� �ƴ� ��������� �����ð��� ���
SELECT restName, openHours 
FROM Restaurant
WHERE address not like '����%';