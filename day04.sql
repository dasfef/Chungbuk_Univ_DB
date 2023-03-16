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

/* 외부키 참조 속성 */
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
drop table newcustomer;                 /* neworders가 참조하고 있는 부모 테이블 */
drop table neworders;

/* 데이터 조작어 - INSERT, UPDATE, DELETE */
insert into book(bookid, bookname, publisher, price)        /* 속성리스트 없이 값만 넣어도 순서대로 기입 가능 */
values(11, '스포츠의학', '한솔의학서적', 90000);

insert into book (bookid, bookname, publisher)
values(14, '스포츠 의학2', '한솔의학서적');

insert into book (price, bookid, bookname, publisher) values(1000, 17, '홍길동전', '스마트');

-- bulk into
insert into book 
select * from imported_book;

-- UPDATE
select * from customer;

update customer
set address='대한민국 부산'
where name = '박세리';

update customer
set address = (select address from customer where name='김연아')
where name = '박세리';

-- DELETE
delete from customer
where custid=5;


/* ★★★★★ 연습문제 ★★★★★ */
-- 1-1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select custid from customer where name = '박지성';
select orders.bookid from orders, book, customer
where orders.custid = (select custid from customer where name = '박지성')
group by orders.bookid;

select orders.custid from orders inner join book
on orders.bookid = book.bookid
where orders.custid = (select custid from customer where name = '박지성');

select customer.name from orders, book, customer
where orders.custid = (select custid from customer where name = '박지성') and 
(select bookid from orders where custid = (select custid from customer where name = '박지성');

/* 1-1 풀이 */
select name
from customer, orders, book
where book.bookid = orders.bookid and customer.custid = orders.custid and publisher
in (select publisher
from book, customer, orders
where customer.custid = orders.custid and book.bookid = orders.bookid and name = '박지성')
and not name = '박지성';

select name
from orders inner join customer on customer.custid = orders.custid inner join book on book.bookid = orders.bookid
where publisher in (select publisher
from book, customer, orders
where customer.custid = orders.custid and book.bookid = orders.bookid and name = '박지성') and not name = '박지성';

/* 1-2 풀이 */
select name, count(distinct publisher)
from orders inner join book on orders.bookid = book.bookid inner join customer on orders.custid = customer.custid
group by name
having count(distinct publisher) >= 2;

/* 1-3 풀이 */
select bookname
from orders inner join book on orders.bookid = book.bookid inner join customer on orders.custid = customer.custid
group by bookname
having count(bookname) >= 0.3 * (select count(*) from customer);

-- 1-2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select distinct publisher from book;


-- 2-1) 새로운 도서 ('스포츠 세계', '대한미디어', 10000원) 삽입
insert into book (bookid, bookname, publisher, price)
values(12, '스포츠 세계', '대한미디어', 10000);

-- 2-2) 삼성당에서 출판한 도서 삭제
delete from book where publisher='삼성당';

-- 2-3) '이상미디어'에서 출판한 도서 삭제
delete from book where publisher='이상미디어';

-- 2-4) 출판사 '대한미디어'가 '대한출판사'로 이름 변경
update book
set publisher='대한출판사' where publisher='대한미디어';


select custid "고객번호", round(sum(saleprice)/count(*), -2) "평균금액"
from orders
group by custid;

-----------------------------
/* 고급 SQL */
/* 일시적으로 변환해주고 영구적으로 변환 X : replace */
select bookid, replace(bookname, '야구', '농구') bookname, publisher, price
from book;

select * from book;

/* LENGTH 단위가 바이트가 아닌 문자 단위 */
select bookname "제목", length(bookname) "글자수", 
lengthb(bookname) "바이트 수"
from book
where publisher = '굿스포츠';

/* 지정한 길이만큼의 문자열 반환 */
select substr(name, 1, 1) "성", count(*) "인원"
from customer
group by substr(name, 1, 1);

/* 날짜 ` 시간 함수 */
select orderid "주문번호", orderdate "주문일", orderdate + 10 "확정"
from orders;

select orderid "주문번호", to_char(orderdate, 'yyyy-mm-dd') "주문일", custid "고객번호", bookid "도서번호"
from orders
where orderdate = '2020-07-07';

select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') "SYSDATE_1" from dual;
