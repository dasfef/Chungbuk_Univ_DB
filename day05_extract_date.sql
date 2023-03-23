insert into TABLE values('2022-03-01 22:09:30', 23); /* 데이터 기입 */
select * from TABLE;

select extract (year from to_timestamp({TABLE}) 년도
from TABLE;

select extract(hour from to_timestamp({TABLE}) 시간
from TABLE;

select cast ({TABLE} as date) 날짜
from TABLE;