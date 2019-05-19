-- Author: Li Leo Wang
-- Date:   2019-05-19
-- Description:
--   - Catch bad xml records: create sample table
-- Notes:
--   - (none)
--

use LWSqlServer
go

if OBJECT_ID('testxml03', 'u') is not null
begin
    drop table testxml03
end

create table testxml03
(
    id int identity(1, 1) primary key
    , xmlrecord varchar(max) null
);

-- good xml
declare @i int = 0
while @i < 100
begin
    insert into testxml03(xmlrecord) values('<root>test</root>')
    set @i = @i + 1
end

-- xml record == null
set @i = 0
while @i < 10
begin
    insert into testxml03(xmlrecord) values(null)
    set @i = @i + 1
end

-- bad xml
set @i = 0
while @i < 10
begin
    insert into testxml03(xmlrecord) values('<root><test</root>')
    set @i = @i + 1
end

select *
from testxml03
