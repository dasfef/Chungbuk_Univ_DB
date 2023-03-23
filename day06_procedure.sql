create or replace procedure INSERTBOOK (
MYBOOKID in number,
MYBOOKNAME in varchar2,
MYPUBLISHER in varchar2,
MYPRICE in number)
as
begin
    insert into book(bookid, bookname, publisher, price)
    values(mybookid, mybookname, mypublisher, myprice);
end;
/

exec insertbook(13, '스포츠과학', '마당과학서적', 25000);
select * from book;

/
create or replace procedure bookINSERTorUPDATE (
    MYBOOKID NUMBER,
    MYBOOKNAME VARCHAR2,
    MYPUBLISHER VARCHAR2,
    MYPRICE INT)
as
    mycount NUMBER;
begin
    select count(*) into mycount from book
    where bookname like mybookname;
    
    if mycount != 0 then
        update book set price = myprice
        where bookname like mybookname;
    else
        insert into book(bookid, bookname, publisher, price)
        values (mybookid, mybookname, mypublisher, myprice);
    end if;
end;
/

/* ????? BOOKINSERTORUPDATE 프로시저 실행 ????? */
exec bookinsertorupdate(15, '스포츠 즐거움', '마당과학서적', 25000);
select * from book;

exec bookinsertorupdate (15, '스포츠 즐거움', '마당과학서적', 20000);
select * from book;


create or replace procedure AVERAGEPRICE(
    AVERAGEVAL out number)
as
begin
    select avg(price) into AVERAGEVAL from book 
    where price is not null;
end;
/

/* ????? AVERAGEPRICE 프로시저 실행 ????? */
set serveroutput on;
declare
    AVERAGEVAL NUMBER;
begin
    AVERAGEPRICE(AVERAGEVAL);
    DBMS_OUTPUT.PUT_LINE('책값 평균 : '||AVERAGEVAL);
end;

/
/* ????? 커서 반환 프로시저 ????? */
create or replace procedure INTEREST 
as
    MYINTEREST NUMERIC;
    PRICE NUMERIC;
    cursor INTERESTCURSOR is select saleprice from orders;
begin
    myinterest := 0.0;
    open interestcursor;
    loop
        fetch interestcursor into price;
        exit when interestcursor%notfound;
        if price >= 30000 then
            myinterest := myinterest + price * 0.1;
        else
            myinterest := myinterest + price * 0.05;
        end if;
    end loop;
    close interestcursor;
    DBMS_OUTPUT.PUT_LINE('전체 이익 금액 = '||myinterest);
end;
/

set serveroutput on;
exec interest;

-- trigger 실습 위한 테이블 생성
create table book_log (
    BOOKID_1 NUMBER,
    BOOKNAME_1 VARCHAR2(40),
    PUBLISHER_1 VARCHAR2(40),
    PRICE_1 NUMBER);
    
/* ????? 트리거 생성 file_name : AFTERINSERTBOOK.sql ????? */
create or replace trigger AFTERINSERTBOOK
after insert on book for each row
declare
    average number;
begin 
    insert into BOOK_LOG
    values(:new.bookid, :new.bookname, :new.publisher, :new.price);
    DBMS_OUTPUT.PUT_LINE('삽입 튜플을 BOOK_LOG 테이블에 백업');
end;
/

insert into book values(16, '스포츠 과학 1', '이상미디어', 25000);
select * from book where bookid = '16';
select * from book_log where bookid_1='16';


/* ????? 사용자 정의 함수 ????? */
create or replace function fnc_interest(
    price number) return int
is
    myinterest number;
begin
    if price >= 30000 then 
        myinterest := price * 0.1;
    else
        myinterest := price * 0.05;
    end if;
    return myinterest;
end;
/

select custid, orderid, saleprice, fnc_interest(saleprice) interest from orders;
