-- Author: Li Leo Wang
-- Date:   2019-05-27
-- Description:
--   - Use sp_msforeachtable to display records in all tables of one database
-- Notes:
--   - (none)
--

use LWSqlServer
go

if OBJECT_ID('tempdb..#temp', 'u') is not null
begin
    drop table #temp
end

create table #temp
(
    id int identity(1, 1) primary key
    , name varchar( 128 ), rows varchar( 128 ), reserved varchar( 128 ), data varchar( 128 ), index_size varchar( 128 ), unused varchar( 128 ), 
);

insert into #temp(name, rows, reserved, data, index_size, unused)
exec sp_MSforeachtable 'sp_spaceused [?]'

select *
from #temp
order by cast(rows as int) desc 
