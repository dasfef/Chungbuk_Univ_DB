/* ===== 2023.03.14 ===== */

select bookname, price from book; 

/* �ߺ� ���Ž� DISTINCT Ű���� ��� */
select distinct publisher from book;

/* ���� �˻� : WHERE */
select * from book where price < 20000;

/* IS NULL, IS NOT NULL ��� ���� �ΰ��� �ΰ��� �ƴѰ��� ���� ���� */

/* WHERE ���� between */
select * from book where price between 10000 and 20000;

/* WHERE + IN �������� �˻� */
select * from book where publisher not in ('�½�����', '���ѹ̵��');

/* != (not equal)�� sql���� <> �� ���δ� */
select * from book where (publisher != '�½�����') and (publisher <> '���ѹ̵��');

/* ===== LIKE ===== */
/* LIKE �� '����' ���� ���� ��Ȯ�� ��ġ�ϴ� ���� ���� */
select bookname, publisher from book where bookname like '�౸�� ����';

/* LIKE ���� '%����%' �� ���ڰ� ���Ե� ���� ���� */
select bookname, publisher from book where bookname like '%�౸%';

/* LIKE ���� '_��%' �� �ι�° ��ġ�� '��' �� ���Ե� ���� ���� */
select * from book where bookname like '_��%';

/* �������� : �౸�� ���� ���� �� ������ 20000�� �̻��� ���� �˻� */
select bookname from book where bookname like '%�౸%' and price >= 20000;

/* ===== ORDER BY ���� ===== */
/* �⺻ ���� ��� : ASC �������� */
select * from book order by bookname;

select * from book order by price desc, publisher asc;

/* ���� �Լ� */
select sum(saleprice) �Ѹ��� from orders;
select sum(saleprice) from orders;

select sum(saleprice) �Ѹ��� from orders where custid=2;

/* ���� ���� �Լ� */
select sum(saleprice) Total,
avg(saleprice) Average,
min(saleprice) Minimum, 
max(saleprice) Maximum
from orders;

/* COUNT �Լ� */
select count(*) C from orders;

/* GROUP BY �˻� */
select count(*) ��������, sum(saleprice) �Ѿ� from orders group by custid order by �Ѿ� desc;

/* HAVING �� */
/* ������ 8,000�� �̻��� ������ ������ ��� �� ���� �ֹ� ������ �� ���� ���ϱ�(��, �� �� �̻� ������ ����)*/
select custid, count(*) ��������
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

/* �ڡڡڡڡ� �������� �ڡڡڡڡ� */
/* 1-1) ������ȣ�� 1�� ���� �̸� */
select bookname from book where bookid=1;

/* 1-2) ������ 20,000�� �̻��� ���� �̸� */
select bookname from book where price >= 20000;

/* 1-3) �������� �� ���ž�(����ȣ : 1) */
select sum(saleprice)�ѱ��ž� from orders where custid=1;

/* 1-4) �������� ������ ������ ��(����ȣ : 1) */
select count(*) �������� from orders where custid=1;

/* 2-1) ���缭�� ������ �� ���� */
select count(*) �������Ѱ��� from book;

/* 2-2) ���缭���� ������ ����ϴ� ���ǻ��� �� ���� */
select count(distinct publisher) ���ǻ� from book;

select count(*) "�� ���ǻ� ��" from (select publisher from book group by publisher);

/* 2-3) ��� ���� �̸�, �ּ� */
select name, address from customer;

/* 2-4) 2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ� ���� ������ �ֹ���ȣ */
select orderid from orders where orderdate >= to_date(200704, 'YY/MM/DD') and 
orderdate <= to_date(200707, 'YY/MM/DD');

/* 2-5) 2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ� ���� ������ ������ ������ �ֹ���ȣ */
select orderid from orders where orderdate 
not between '20/07/04' and '20/07/07';

/* 2-6) ���� '��'���� ���� �̸��� �ּ� */
select name, address from customer where name like '��%';

/* 2-7) ���� '��'���̰� �̸��� '��'�� ������ ���� �̸��� �ּ� */
select name, address from customer where name like '%��__' and name like '__��%';

select name, address from customer where name like '��%��';


/* �ڡڡڡڡ� JOIN �ڡڡڡڡ� */
select * from customer, orders where customer.custid = orders.custid;

select * from customer, orders where customer.custid = orders.custid order by customer.custid;

select name, saleprice from customer, orders where customer.custid = orders.custid;

/* 3�� �����̼� ���� */
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid;

/* ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸� */
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid
and book.price = 20000;

/* �ܺ����� */
SELECT customer.name, saleprice
FROM customer LEFT OUTER JOIN orders
    ON customer.custid = orders.custid;

/* �μ����� */
SELECT max(price) FROM book;

SELECT bookname, price FROM book
WHERE price=(SELECT max(price) FROM book);

/* ������ ������ ���� �ִ� ���� �̸� */
SELECT DISTINCT custid FROM orders;
SELECT name FROM customer
WHERE custid in (select distinct custid from orders);

/* ���ѹ̵��� ������ ������ ������ ���� �̸� */
select bookid from book where publisher='���ѹ̵��';

select custid from orders where bookid in 
(select bookid from book where publisher='���ѹ̵��');

select name from customer where custid in
    (select custid from orders where bookid in 
        (select bookid from book where publisher='���ѹ̵��'));
        
/* ��� �μ����� */
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price) FROM book b2
WHERE b2.publisher = b1.publisher);

/* ������ */
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

/* EXISTS */
SELECT name, address
FROM customer cs
WHERE EXISTS(SELECT * FROM orders od WHERE cs.custid=od.custid);


/* �ڡڡڡڡ� �������� �ڡڡڡڡ� */
/* 1-5) �������� ������ ������ ���ǻ� �� */
select publisher, count(*) from book group by publisher;
select custid from customer where name='������';
select bookid from orders where custid=(select custid from customer where name='������');

select publisher, count(*) from book where bookid in
(select bookid from orders where custid=
(select custid from customer where name='������'))
group by publisher;

/* 1-6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ���� */
select custid from customer where name='������';

select orders.custid, book.bookname, book.price, orders.saleprice
from orders LEFT OUTER JOIN book
ON book.bookid=orders.bookid;

select book.bookname å�̸�, book.price ����, orders.saleprice �ǸŰ�, (book.price - orders.saleprice) ����
FROM orders LEFT OUTER JOIN book
ON book.bookid=orders.bookid
WHERE orders.custid = (select custid from customer where name='������');

/* 1-7) �������� �������� ���� ������ �̸� */
select custid from customer where name='������';

select DISTINCT book.bookname å�̸�
FROM book LEFT OUTER JOIN orders
ON book.bookid=orders.bookid
WHERE orders.custid != (select custid from customer where name='������');

/* 2-8) �ֹ����� ���� ���� �̸�(�μ�����) */
select distinct custid from orders;

select name from customer where custid NOT IN (select distinct custid from orders);

/* 2-9) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ� */
select SUM(saleprice) "�ֹ� �ݾ�", AVG(saleprice) "��� �ݾ�"
from orders;

/* 2-10) ���� �̸��� ���� ���ž� */
select distinct name, sum(distinct saleprice)
from (
select customer.name , orders.saleprice
from customer, orders
where customer.custid=orders.custid);

/* 2-11) ���� �̸��� ���� ������ ���� ��� */

/* 2-12) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ� */
select price from book;
select saleprice from orders;

select orderid o1 from orders where orderid =
(select orderid, max(book.price - orders.saleprice) from book, orders
group by orderid);