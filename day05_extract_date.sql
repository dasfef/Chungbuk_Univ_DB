insert into TABLE values('2022-03-01 22:09:30', 23); /* ������ ���� */
select * from TABLE;

select extract (year from to_timestamp({TABLE}) �⵵
from TABLE;

select extract(hour from to_timestamp({TABLE}) �ð�
from TABLE;

select cast ({TABLE} as date) ��¥
from TABLE;