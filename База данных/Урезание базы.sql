-- Посказка: чтобы выполнить часть скрипта - выделите нужное и нажмите "Выполнить"

-- в среде SSMS нажмите "Запрос" - "Указать значения параметров шаблона" 

-- Обрезаем файл журнала транзакций

use master
go

ALTER DATABASE <ИмяВашейБазы, varchar(30),> SET RECOVERY SIMPLE
go
use <ИмяВашейБазы, varchar(30),>
go
DBCC SHRINKFILE (2, 10)
GO


--Очищаем журналы и логи

use <ИмяВашейБазы, varchar(30),>
go
truncate table dbo._Reference60			--Журнал изменений объектов AEMZ
truncate table dbo._Reference60_VT1359  --его табличная часть

truncate table dbo._Reference61			--Журнал изменений регистров AEMZ
truncate table dbo._Reference61_VT1375  --его табличная часть
truncate table dbo._Reference61_VT1382  --его табличная часть

truncate table dbo._InfoRg17554			--замеры времени
truncate table dbo._InfoRg19195			--Время выполнения отчетов

truncate table _inforg31991 --РС версии объектов

DBCC SHRINKFILE (2, 10)     --еще раз обрежем лог
GO



--ЗАРПЛАТА--
--Кто не работает с зарплатой - может очистить большие зарплатные таблицы 
truncate table dbo._InfoRg28617 --табель
truncate table dbo._InfoRg28635 --Предварительный табель (неявки)
truncate table dbo._InfoRg28134 --Индивидуальные графики (ЗП)





--ПРОИЗВОДСТВО
--Кто не работает с производством - может немного подчистить данные производства

--ВНИМАНИЕ! Запросы ниже могут выполняться длительное время.

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

DBCC SHRINKFILE (2, 10)     --еще раз обрежем лог
GO


-- _AccumRg21996 - ДНП
-- Таблица большая, ее не усекал
