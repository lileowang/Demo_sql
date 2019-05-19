-- Author: Li Leo Wang
-- Date:   2019-05-19
-- Description:
--   - Catch bad xml records: use loop to do the job
-- Notes:
--   - (none)
--

use LWSqlServer
go

set nocount on

if OBJECT_ID('tempdb..#temp', 'u') is not null
begin
    drop table #temp
end

select id, cast(null as bit) as processed
into #temp
from testxml03
where xmlrecord is not null

declare @count int, @theMax int, @rowHit int
select @count = MIN(id) from #temp
select @theMax = MAX(id) from #temp

while @count <= @theMax
begin
    begin try
        if (select DATALENGTH(CAST(xmlrecord as xml)) from testxml03 where id = @count) > 0
        begin
            update #temp
            set processed = 1
            where id = @count
        end
    end try

    begin catch
        update #temp
        set processed = 0
        where id = @count

        print 'b: ' + cast(@count as varchar(32))
    end catch

    select @rowHit = count(*) from #temp where processed is not null
    if @rowHit % 10 = 0
    begin
        print 'p: ' + cast(@rowHit as varchar(32))
    end

    select @count = MIN(id) from #temp where processed is null
end

select *
from #temp
where processed = 0
