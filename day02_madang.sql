select * from customer where name = '�迬��';
select bookname, price from Book;
select price, bookname from book;
select distinct publisher from book;

select * from book where price between 10000 and 20000;

select * from book where price >= 10000 and price <= 20000;

select bookname from book where publisher in ('�½�����', '���ѹ̵��');

select * from book where publisher not in ('�½�����', '���ѹ̵��');

select bookname, publisher from book where bookname like '�౸�� ����';

select bookname, publisher from book where bookname like '�౸';

select bookname, publisher from book where bookname like '%�౸%';

select * from book where bookname like '_��%';

select * from book where bookname like '%�౸%' and price >= 20000;

select * from book where publisher='�½�����' or publisher = '�̻�̵��';

select * from book order by bookname desc;

select * from book order by price, bookname;

select * from book order by price desc, publisher asc;

select sum(saleprice) from orders;

select sum(saleprice) as �Ѹ��� from orders;

select sum(saleprice) as �Ѹ��� from orders where custid=2;

select 
    sum(saleprice) as Total,
    avg(saleprice) as Average,
    min(saleprice) as Minimum,
    max(saleprice) as Maximum

from orders;    

select count(*) from orders;

select custid, count(*) as ��������, sum(saleprice) as �Ѿ� 
from orders group by custid order by sum(saleprice) desc;

/* ������ 8000�� �̻��� ������ ������ ���� ���� ���� �ֹ� ������ �� ����, �� �α� �̻� ������ ����� */
select custid, count(*) as �������� from orders 
where saleprice >= 8000 group by custid
having count(*) >= 2;

/* ������ȣ�� 1�� ������ �̸� */
select bookname from book where bookid=1;

/* ������ 20,000�� �̻��� ������ �̸� */
select bookname from book where price >= 20000;

/* �������� �� ���ž�(�������� ����ȣ�� 1������ ���� �ۼ� */
select sum(saleprice) from orders where custid=1;

/* �������� ������ ������ ��(�������� ����ȣ : 1) */
select count(*) from orders where custid=1;

/* ���缭�� ������ �� ���� */


/* ========== 2023.03.14 =========== */
select bookname, price from book;