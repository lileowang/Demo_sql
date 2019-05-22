-- Author: Li Leo Wang
-- Date:   2019-05-22
-- Description:
--   - XQuery demo: create sample table
-- Notes:
--   - books.xml from:
--      https://msdn.microsoft.com/en-us/windows/desktop/ms762271
--      Sample XML File (books.xml)
--   - copy books.xml to c:\temp
--

use LWSqlServer
go

if OBJECT_ID('testxquery01', 'u') is not null
begin
    drop table testxquery01
end

create table testxquery01
(
    id int identity(1, 1) primary key
    , fn varchar(256) not null
    , xmlrecord xml not null
);

insert into testxquery01(fn, xmlrecord)
select 
    'C:\Temp\books.xml'
    , *
from openrowset
(
    bulk 'C:\Temp\books.xml', single_blob
) t

select *
from testxquery01