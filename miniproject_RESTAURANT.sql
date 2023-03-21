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
select 1, '롯데리아', '서울특별시 강남구 도산대로 95길 20', '02-1234-5678', '10:00 - 22:00', 5 from dual union all
select 2, '맥도날드', '부산광역시 해운대구 해운대해변로 280', '051-9876-5432', '11:00 - 23:00', 3 from dual union all
select 3, '버거킹', '대구광역시 수성구 수성로 45길 8', '053-4567-1234', '09:00 - 21:00', 4 from dual union all
select 4, '맘스터치', '인천광역시 연수구 컨벤시아대로 123', '032-7890-1234', '11:00 - 23:00', 4 from dual;

INSERT INTO Menu (menuId, restId, menuName, describe, price)
select 1, 1, '불고기버거', '한국 전통의 불고기 맛 햄버거.', 4500 from dual union all
select 2, 1, '새우버거', '당신들이 새우 맛을 아는가.', 4500 from dual union all
select 3, 2, '빅맥', '빅맥지수의 그 빅맥.', 5200 from dual union all
select 4, 2, '맥치킨', '맥치킨이지만 사실 햄버거다.', 3500 from dual union all
select 5, 3, '와퍼', '불맛나는 햄버거.', 6900 from dual union all
select 6, 3, '킹치킨버거', '버거킹 최약체.', 3600 from dual union all
select 7, 4, '싸이버거', '월드스타 싸이와 연관 없다.', 4300 from dual union all
select 8, 4, '화이트갈릭버거', '힘을 숨긴 햄버거.', 4600 from dual;

/*alter table menu drop column orderer;*/

INSERT INTO Review (reviewId, restId, menuid, orderer, r_text, reviewRating, wrottendate)
select 1, 1, 1, '이동묵', '이 햄버거의 육즙이 넘치고, 소스도 완벽하게 어우러져 있어요!', 1, '2023-02-15' from dual union all
select 2, 1, 2, '최연웅', '햄버거가 크고 든든해서 배부르게 먹을 수 있어 좋았습니다.', 3, '2023-01-28' from dual union all
select 3, 4, 7, '국유채', '햄버거가 짜요.', 1, '2023-02-20' from dual union all
select 4, 4, 8, '윌 스미스', '신선한 야채와 바삭한 튀김이 어우러진 햄버거가 인상적이었습니다.', 2, '2023-03-05' from dual union all
select 5, 3, 5, '도널드 트럼프', '햄버거 빵이 부드럽고 담백한 맛이 좋았어요.', 4, '2023-01-10' from dual union all
select 6, 3, 5, '이동묵', '스파이시한 소스가 들어간 햄버거로, 매콤한 맛을 좋아하는 사람들에게 추천합니다.', 1, '2023-03-12' from dual union all
select 7, 2, 4, '이동묵', '스파게티가 참 맛있어요 매콤달달해서 개인적으로 만족합니다.', 4,'2023-03-21' from dual union all
select 8, 4, 7, '국유채', '매장이 더러워요', 2,'2023-02-20' from dual union all
select 9, 4, 7, '국유채', '알바가 노려봐요', 1,'2023-01-20' from dual union all
select 10, 4, 7, '최연웅', '뭘로 만들었는지 모르겠어요', 1,'2023-03-11' from dual union all
select 11, 2, 4, '최연웅', '이 햄버거는 고기와 야채의 균형이 잘 맞아, 깔끔한 맛을 즐길 수 있었습니다.', 1, '2023-02-05' from dual;


--1 등록된 점포를 별점순으로 모두 출력
SELECT *
FROM Restaurant
ORDER BY restRating desc;

--2 메뉴 릴레이션에서 가격이 4500이상 5500미만인 메뉴를 출력
SELECT *
FROM Menu
WHERE price >= 4500 and price <5500;

--3 리뷰를 날짜순으로 전체 출력
SELECT *
FROM Review
ORDER BY wrottendate;

--4 별점4점 이상인 레스토랑과 별점을 출력
SELECT restName, restRating
FROM Restaurant
WHERE restRating >= 4;


--5 메뉴 이름에 '치킨'이 들어간 메뉴의 제품이름, 제품가격을 출력 
SELECT menuName, price
FROM Menu
WHERE Menuname LIKE '%치킨%'
ORDER BY price;

--6 소비자 평점 3점 이상인 리뷰 내용을 별점순으로 출력
SELECT reviewRating, r_text
FROM Review
WHERE reviewRating >= 3
ORDER BY reviewRating;

--7 서울지역이 아닌 레스토랑과 영업시간을 출력
SELECT restName, openHours 
FROM Restaurant
WHERE address not like '서울%';

--8 각 레스토랑의 메뉴, 메뉴별 설명상세와 가격을 출력
SELECT  restName 레스토랑명, Menuname 메뉴이름, Describe 메뉴상세, price 가격
FROM Restaurant,Menu
WHERE Restaurant.restid = Menu.restid
ORDER BY Restaurant.restid;

--9 싸이버거에 대한 평가내용만 모아서 세 건만 볼 수 있게
SELECT orderer 주문자, reviewRating 별점 , r_text 평가내용
FROM (select * from Review where menuid=(SELECT menuid from menu where menuname = '싸이버거' ) 
order by reviewRating DESC) 
WHERE ROWNUM <=3;

--10 주문자 이동묵의 리뷰만 모아보기
SELECT reviewRating 평점, r_text 리뷰내용
FROM Review
WHERE orderer = '이동묵'
ORDER BY reviewRating;

--11 불고기버거의 메뉴 상세설명, 가격정보를 보고싶다.
SELECT Menuname 메뉴명, describe 상세설명
FROM Menu
WHERE menuName = '불고기버거';

--12 국유채씨의 총 주문액
SELECT orderer 주문자, sum(price) 총주문액
FROM  menu, review
WHERE menu.menuid = review.menuid
GROUP BY orderer
HAVING orderer = '국유채';
