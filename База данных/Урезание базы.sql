use master
go

ALTER DATABASE [psvbuh_test4] SET RECOVERY SIMPLE
go
use psvbuh_test4
go
DBCC SHRINKFILE (2, 10)
GO

--ПРОИЗВОДСТВО


delete top (100000) t
--select count(*) 
From _InfoRg20804 t where _Period < '40180401' --Штрих код прослеживаемость
go 50

delete top (100000) t
--select count(*) 
From dbo._InfoRg29702 t where _Fld29705 < '40180401' --Взвешивание
go 50
--truncate table dbo._InfoRg29702

delete top (100000) t
from _InfoRg31656 t where t._Period < '40180401' --партии показатели
go 50

delete top (100000) t
from _InfoRg35903 t where t._Period < '40180401' --доп сведения ДНП
go 50
--truncate table dbo._InfoRg35903




--ЗАРПЛАТА--
truncate table dbo._InfoRg28617 --табель
truncate table dbo._InfoRg28635 --Предварительный табель (неявки)
truncate table dbo._InfoRg28134 --Индивидуальные графики (ЗП)

--ОБЩЕЕ
truncate table dbo._Reference60			--AEMZ
truncate table dbo._Reference60_VT1359

truncate table dbo._Reference61			--AEMZ
truncate table dbo._Reference61_VT1375
truncate table dbo._Reference61_VT1382

truncate table dbo._InfoRg17554			--замеры времени
truncate table dbo._InfoRg19195			--Время выполнения отчетов

truncate table _inforg31991 --РС версии объектов

DBCC SHRINKFILE (2, 10)
GO



_AccumRg21996 - ДНП






if exists(select name from tempdb..sysobjects where name='#tmp')
drop table #tmp

SELECT *
into #tmp
-- Select Count(*)
FROM _InfoRg31656
WHERE _Period >= '40180901'

truncate table _InfoRg31656

insert into _InfoRg31656 
select * from #tmp

drop table #tmp
go




