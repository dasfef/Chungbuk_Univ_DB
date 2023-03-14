/* ===== 2023.03.14 ===== */

select bookname, price from book; 

/* 중복 제거시 DISTINCT 키워드 사용 */
select distinct publisher from book;

/* 조건 검색 : WHERE */
select * from book where price < 20000;

/* IS NULL, IS NOT NULL 등과 같이 널값과 널값이 아닌것을 추출 가능 */

/* WHERE 조건 between */
select * from book where price between 10000 and 20000;

/* WHERE + IN 조건절로 검색 */
select * from book where publisher not in ('굿스포츠', '대한미디어');

/* != (not equal)은 sql에서 <> 로 쓰인다 */
select * from book where (publisher != '굿스포츠') and (publisher <> '대한미디어');

/* ===== LIKE ===== */
/* LIKE 는 '문자' 내의 값과 정확히 일치하는 것을 추출 */
select bookname, publisher from book where bookname like '축구의 역사';

/* LIKE 내에 '%문자%' 로 문자가 포함된 값을 추출 */
select bookname, publisher from book where bookname like '%축구%';

/* LIKE 내에 '_구%' 로 두번째 위치에 '구' 가 포함된 값을 추출 */
select * from book where bookname like '_구%';

/* 복합조건 : 축구에 관한 도서 중 가격이 20000원 이상인 도서 검색 */
select bookname from book where bookname like '%축구%' and price >= 20000;

/* ===== ORDER BY 정렬 ===== */
/* 기본 정렬 방식 : ASC 오름차순 */
select * from book order by bookname;

select * from book order by price desc, publisher asc;

/* 집계 함수 */
select sum(saleprice) 총매출 from orders;
select sum(saleprice) from orders;

select sum(saleprice) 총매출 from orders where custid=2;

/* 종합 집계 함수 */
select sum(saleprice) Total,
avg(saleprice) Average,
min(saleprice) Minimum, 
max(saleprice) Maximum
from orders;

/* COUNT 함수 */
select count(*) C from orders;

/* GROUP BY 검색 */
select count(*) 도서수량, sum(saleprice) 총액 from orders group by custid order by 총액 desc;

/* HAVING 절 */
/* 가격이 8,000원 이상인 도서를 구매한 사람 중 고객별 주문 도서의 총 수량 구하기(단, 두 권 이상 구매한 고객만)*/
select custid, count(*) 도서수량
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

/* ★★★★★ 연습문제 ★★★★★ */
/* 1-1) 도서번호가 1인 도서 이름 */
select bookname from book where bookid=1;

/* 1-2) 가격이 20,000원 이상인 도서 이름 */
select bookname from book where price >= 20000;

/* 1-3) 박지성의 총 구매액(고객번호 : 1) */
select sum(saleprice)총구매액 from orders where custid=1;

/* 1-4) 박지성이 구매한 도서의 수(고객번호 : 1) */
select count(*) 도서개수 from orders where custid=1;

/* 2-1) 마당서점 도서의 총 개수 */
select count(*) 도서의총개수 from book;

/* 2-2) 마당서점에 도서를 출고하는 출판사의 총 개수 */
select count(distinct publisher) 출판사 from book;

select count(*) "총 출판사 수" from (select publisher from book group by publisher);

/* 2-3) 모든 고객의 이름, 주소 */
select name, address from customer;

/* 2-4) 2020년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서의 주문번호 */
select orderid from orders where orderdate >= to_date(200704, 'YY/MM/DD') and 
orderdate <= to_date(200707, 'YY/MM/DD');

/* 2-5) 2020년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호 */
select orderid from orders where orderdate 
not between '20/07/04' and '20/07/07';

/* 2-6) 성이 '김'씨인 고객의 이름과 주소 */
select name, address from customer where name like '김%';

/* 2-7) 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소 */
select name, address from customer where name like '%김__' and name like '__아%';

select name, address from customer where name like '김%아';


/* ★★★★★ JOIN ★★★★★ */
select * from customer, orders where customer.custid = orders.custid;

select * from customer, orders where customer.custid = orders.custid order by customer.custid;

select name, saleprice from customer, orders where customer.custid = orders.custid;

/* 3개 릴레이션 조인 */
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid;

/* 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름 */
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid
and book.price = 20000;

/* 외부조인 */
SELECT customer.name, saleprice
FROM customer LEFT OUTER JOIN orders
    ON customer.custid = orders.custid;

/* 부속질의 */
SELECT max(price) FROM book;

SELECT bookname, price FROM book
WHERE price=(SELECT max(price) FROM book);

/* 도서를 구매한 적이 있는 고객의 이름 */
SELECT DISTINCT custid FROM orders;
SELECT name FROM customer
WHERE custid in (select distinct custid from orders);

/* 대한미디어에서 출판한 도서를 구매한 고객의 이름 */
select bookid from book where publisher='대한미디어';

select custid from orders where bookid in 
(select bookid from book where publisher='대한미디어');

select name from customer where custid in
    (select custid from orders where bookid in 
        (select bookid from book where publisher='대한미디어'));
        
/* 상관 부속질의 */
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price) FROM book b2
WHERE b2.publisher = b1.publisher);

/* 차집합 */
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


/* ★★★★★ 연습문제 ★★★★★ */
/* 1-5) 박지성이 구매한 도서의 출판사 수 */
select publisher, count(*) from book group by publisher;
select custid from customer where name='박지성';
select bookid from orders where custid=(select custid from customer where name='박지성');

select publisher, count(*) from book where bookid in
(select bookid from orders where custid=
(select custid from customer where name='박지성'))
group by publisher;

/* 1-6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 */
select custid from customer where name='박지성';

select orders.custid, book.bookname, book.price, orders.saleprice
from orders LEFT OUTER JOIN book
ON book.bookid=orders.bookid;

select book.bookname 책이름, book.price 정가, orders.saleprice 판매가, (book.price - orders.saleprice) 차액
FROM orders LEFT OUTER JOIN book
ON book.bookid=orders.bookid
WHERE orders.custid = (select custid from customer where name='박지성');

/* 1-7) 박지성이 구매하지 않은 도서의 이름 */
select custid from customer where name='박지성';

select DISTINCT book.bookname 책이름
FROM book LEFT OUTER JOIN orders
ON book.bookid=orders.bookid
WHERE orders.custid != (select custid from customer where name='박지성');

/* 2-8) 주문하지 않은 고객의 이름(부속질의) */
select distinct custid from orders;

select name from customer where custid NOT IN (select distinct custid from orders);

/* 2-9) 주문 금액의 총액과 주문의 평균 금액 */
select SUM(saleprice) "주문 금액", AVG(saleprice) "평균 금액"
from orders;

/* 2-10) 고객의 이름과 고객별 구매액 */
select distinct name, sum(distinct saleprice)
from (
select customer.name , orders.saleprice
from customer, orders
where customer.custid=orders.custid);

/* 2-11) 고객의 이름과 고객이 구매한 도서 목록 */

/* 2-12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문 */
select price from book;
select saleprice from orders;

select orderid o1 from orders where orderid =
(select orderid, max(book.price - orders.saleprice) from book, orders
group by orderid);