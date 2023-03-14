select * from customer where name = '김연아';
select bookname, price from Book;
select price, bookname from book;
select distinct publisher from book;

select * from book where price between 10000 and 20000;

select * from book where price >= 10000 and price <= 20000;

select bookname from book where publisher in ('굿스포츠', '대한미디어');

select * from book where publisher not in ('굿스포츠', '대한미디어');

select bookname, publisher from book where bookname like '축구의 역사';

select bookname, publisher from book where bookname like '축구';

select bookname, publisher from book where bookname like '%축구%';

select * from book where bookname like '_구%';

select * from book where bookname like '%축구%' and price >= 20000;

select * from book where publisher='굿스포츠' or publisher = '이상미디어';

select * from book order by bookname desc;

select * from book order by price, bookname;

select * from book order by price desc, publisher asc;

select sum(saleprice) from orders;

select sum(saleprice) as 총매출 from orders;

select sum(saleprice) as 총매출 from orders where custid=2;

select 
    sum(saleprice) as Total,
    avg(saleprice) as Average,
    min(saleprice) as Minimum,
    max(saleprice) as Maximum

from orders;    

select count(*) from orders;

select custid, count(*) as 도서수량, sum(saleprice) as 총액 
from orders group by custid order by sum(saleprice) desc;

/* 가격이 8000원 이상인 도서를 구매한 고객에 대해 고객별 주문 도서의 총 수량, 단 두권 이상 구매한 사람만 */
select custid, count(*) as 도서수량 from orders 
where saleprice >= 8000 group by custid
having count(*) >= 2;

/* 도서번호가 1인 도서의 이름 */
select bookname from book where bookid=1;

/* 가격이 20,000원 이상인 도서의 이름 */
select bookname from book where price >= 20000;

/* 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성 */
select sum(saleprice) from orders where custid=1;

/* 박지성이 구매한 도서의 수(박지성의 고객번호 : 1) */
select count(*) from orders where custid=1;

/* 마당서점 도서의 총 개수 */


/* ========== 2023.03.14 =========== */
select bookname, price from book;