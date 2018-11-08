--РС версии объектов

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

