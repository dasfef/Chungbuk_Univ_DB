create table NewBook(
bookid number primary key,
bookname varchar2(20),
publisher varchar2(20),
price number);

describe newbook;

create table NewCustomer (
custid number primary key,
name varchar2(40),
address varchar2(40),
phone varchar2(30));

/* �ܺ�Ű ���� �Ӽ� */
create table NewOrders (
orderid number primary key,
custid number NOT NULL,
bookid number NOT NULL,
saleprice number,
orderdate date,
foreign key(custid) references newcustomer(custid) on delete cascade);

/* ALTER TABLE */
drop table newbook;

create table newbook (
bookid number,
bookname varchar2(20),
publisher varchar2(20),
price number);

alter table newbook add isbn varchar2(13);

alter table newbook modify isbn number;

alter table newbook drop column isbn;

alter table newbook modify bookid number not null;

alter table newbook modify bookid primary key;

/* DROP TABLE */
drop table newbook;
drop table newcustomer;                 /* neworders�� �����ϰ� �ִ� �θ� ���̺� */
drop table neworders;

/* ������ ���۾� - INSERT, UPDATE, DELETE */
insert into book(bookid, bookname, publisher, price)        /* �Ӽ�����Ʈ ���� ���� �־ ������� ���� ���� */
values(11, '����������', '�Ѽ����м���', 90000);

insert into book (bookid, bookname, publisher)
values(14, '������ ����2', '�Ѽ����м���');

insert into book (price, bookid, bookname, publisher) values(1000, 17, 'ȫ�浿��', '����Ʈ');

-- bulk into
insert into book 
select * from imported_book;

-- UPDATE
select * from customer;

update customer
set address='���ѹα� �λ�'
where name = '�ڼ���';

update customer
set address = (select address from customer where name='�迬��')
where name = '�ڼ���';

-- DELETE
delete from customer
where custid=5;


/* �ڡڡڡڡ� �������� �ڡڡڡڡ� */
-- 1-1) �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�
select custid from customer where name = '������';
select orders.bookid from orders, book, customer
where orders.custid = (select custid from customer where name = '������')
group by orders.bookid;

select orders.custid from orders inner join book
on orders.bookid = book.bookid
where orders.custid = (select custid from customer where name = '������');

select customer.name from orders, book, customer
where orders.custid = (select custid from customer where name = '������') and 
(select bookid from orders where custid = (select custid from customer where name = '������');

/* 1-1 Ǯ�� */
select name
from customer, orders, book
where book.bookid = orders.bookid and customer.custid = orders.custid and publisher
in (select publisher
from book, customer, orders
where customer.custid = orders.custid and book.bookid = orders.bookid and name = '������')
and not name = '������';

select name
from orders inner join customer on customer.custid = orders.custid inner join book on book.bookid = orders.bookid
where publisher in (select publisher
from book, customer, orders
where customer.custid = orders.custid and book.bookid = orders.bookid and name = '������') and not name = '������';

/* 1-2 Ǯ�� */
select name, count(distinct publisher)
from orders inner join book on orders.bookid = book.bookid inner join customer on orders.custid = customer.custid
group by name
having count(distinct publisher) >= 2;

/* 1-3 Ǯ�� */
select bookname
from orders inner join book on orders.bookid = book.bookid inner join customer on orders.custid = customer.custid
group by bookname
having count(bookname) >= 0.3 * (select count(*) from customer);

-- 1-2) �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�
select distinct publisher from book;


-- 2-1) ���ο� ���� ('������ ����', '���ѹ̵��', 10000��) ����
insert into book (bookid, bookname, publisher, price)
values(12, '������ ����', '���ѹ̵��', 10000);

-- 2-2) �Ｚ�翡�� ������ ���� ����
delete from book where publisher='�Ｚ��';

-- 2-3) '�̻�̵��'���� ������ ���� ����
delete from book where publisher='�̻�̵��';

-- 2-4) ���ǻ� '���ѹ̵��'�� '�������ǻ�'�� �̸� ����
update book
set publisher='�������ǻ�' where publisher='���ѹ̵��';


select custid "����ȣ", round(sum(saleprice)/count(*), -2) "��ձݾ�"
from orders
group by custid;

-----------------------------
/* ��� SQL */
/* �Ͻ������� ��ȯ���ְ� ���������� ��ȯ X : replace */
select bookid, replace(bookname, '�߱�', '��') bookname, publisher, price
from book;

select * from book;

/* LENGTH ������ ����Ʈ�� �ƴ� ���� ���� */
select bookname "����", length(bookname) "���ڼ�", 
lengthb(bookname) "����Ʈ ��"
from book
where publisher = '�½�����';

/* ������ ���̸�ŭ�� ���ڿ� ��ȯ */
select substr(name, 1, 1) "��", count(*) "�ο�"
from customer
group by substr(name, 1, 1);

/* ��¥ ` �ð� �Լ� */
select orderid "�ֹ���ȣ", orderdate "�ֹ���", orderdate + 10 "Ȯ��"
from orders;

select orderid "�ֹ���ȣ", to_char(orderdate, 'yyyy-mm-dd') "�ֹ���", custid "����ȣ", bookid "������ȣ"
from orders
where orderdate = '2020-07-07';

select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') "SYSDATE_1" from dual;
