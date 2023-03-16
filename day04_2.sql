/* NULL 값 처리 */
create table Mybook (
bookid number,
price number);

insert into mybook (bookid, price) values (1, 10000);
insert into mybook (bookid, price) values (2, 20000);
insert into mybook (bookid, price) values (3, NULL);

select sum(price), avg(price), count(*), count(price) from mybook;

select sum(price), avg(price), count(*) from mybook where bookid >= 4;

select * from mybook where price is null;

insert into customer values (5, '박세리', '대한민국 서울', null);

-- 박세리 연락처 NULL 값 대치 (NVL)
select name "이름", nvl(phone, '연락처없음') "전화번호" from customer;

-- ROWNUM
select rownum "순번", custid, name, phone from customer where rownum <= 2;

/* 평균 주문금액 이하의 주문에 대해 주문번호와 금액 */
select orderid "주문번호", saleprice "금액" from orders
where saleprice <= (select avg(saleprice) from orders);

/* 각 고객의 평균 주문금액보다 큰 금액의 주문 내역의 주문번호, 고객번호, 금액 */
select orderid "주문번호", custid "고객번호", saleprice "주문 금액" from orders md
where saleprice > (select avg(saleprice) from orders so where md.custid=so.custid);

/* 대한민국에 거주하는 고객에게 판매한 도서의 총판매액 */
select sum(saleprice) from orders inner join customer on orders.custid = customer.custid
where customer.address = (select address from customer);

select sum(saleprice) "total" from orders where custid in
(select custid from customer where address like '%대한민국%');

/* 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액 */
select orderid, saleprice from orders where saleprice > 
all(select saleprice from orders where custid='3');

select orderid, saleprice from orders where saleprice > 
(select max(saleprice) from orders where orderid='3');

/* EXISTS 연산자로 대한민국에 거주하는 고객에 판매한 도서의 총 판매액 */
select sum(saleprice) "total"
from orders od
where exists (select * from customer cs
where address like '%대한민국%' and cs.custid = od.custid);

/* INLINE VIEW : FROM 절에서 사용되는 부속질의 */
select cs.name, sum(od.saleprice) "total"
from (select custid, name from customer where custid <= 2) cs, orders od
where cs.custid = od.custid
group by cs.name;

/* VIEW 하나 이상의 테이블을 합하여 만든 가상의 테이블 */
create view vw_customer
as select *from customer
where address like '%대한민국%';

select * from vw_customer;