/* NULL �� ó�� */
create table Mybook (
bookid number,
price number);

insert into mybook (bookid, price) values (1, 10000);
insert into mybook (bookid, price) values (2, 20000);
insert into mybook (bookid, price) values (3, NULL);

select sum(price), avg(price), count(*), count(price) from mybook;

select sum(price), avg(price), count(*) from mybook where bookid >= 4;

select * from mybook where price is null;

insert into customer values (5, '�ڼ���', '���ѹα� ����', null);

-- �ڼ��� ����ó NULL �� ��ġ (NVL)
select name "�̸�", nvl(phone, '����ó����') "��ȭ��ȣ" from customer;

-- ROWNUM
select rownum "����", custid, name, phone from customer where rownum <= 2;

/* ��� �ֹ��ݾ� ������ �ֹ��� ���� �ֹ���ȣ�� �ݾ� */
select orderid "�ֹ���ȣ", saleprice "�ݾ�" from orders
where saleprice <= (select avg(saleprice) from orders);

/* �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ �ֹ���ȣ, ����ȣ, �ݾ� */
select orderid "�ֹ���ȣ", custid "����ȣ", saleprice "�ֹ� �ݾ�" from orders md
where saleprice > (select avg(saleprice) from orders so where md.custid=so.custid);

/* ���ѹα��� �����ϴ� ������ �Ǹ��� ������ ���Ǹž� */
select sum(saleprice) from orders inner join customer on orders.custid = customer.custid
where customer.address = (select address from customer);

select sum(saleprice) "total" from orders where custid in
(select custid from customer where address like '%���ѹα�%');

/* 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ� */
select orderid, saleprice from orders where saleprice > 
all(select saleprice from orders where custid='3');

select orderid, saleprice from orders where saleprice > 
(select max(saleprice) from orders where orderid='3');

/* EXISTS �����ڷ� ���ѹα��� �����ϴ� ���� �Ǹ��� ������ �� �Ǹž� */
select sum(saleprice) "total"
from orders od
where exists (select * from customer cs
where address like '%���ѹα�%' and cs.custid = od.custid);

/* INLINE VIEW : FROM ������ ���Ǵ� �μ����� */
select cs.name, sum(od.saleprice) "total"
from (select custid, name from customer where custid <= 2) cs, orders od
where cs.custid = od.custid
group by cs.name;

/* VIEW �ϳ� �̻��� ���̺��� ���Ͽ� ���� ������ ���̺� */
create view vw_customer
as select *from customer
where address like '%���ѹα�%';

select * from vw_customer;