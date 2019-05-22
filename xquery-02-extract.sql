-- Author: Li Leo Wang
-- Date:   2019-05-22
-- Description:
--   - XQuery demo: extract values from XML
-- Notes:
--   - books.xml from:
--      https://msdn.microsoft.com/en-us/windows/desktop/ms762271
--      Sample XML File (books.xml)
--   - copy books.xml to c:\temp
--   - make sure to use "cross apply", not "cross join"
-- 

use LWSqlServer
go

select
    meas.id
    , t1.c.value('@id', 'varchar(32)') as bkid
    , t1.c.value('title[1]', 'varchar(256)') as title
    , t1.c.value('count(for $i in . return $i/../* [. << $i]) + 1', 'int') as idx
from testxquery01 as meas
    cross apply meas.xmlrecord.nodes('//book') as t1(c)
