#drop_table
drop table {table}
#char
char({len})
#vchar
varchar({len})
#int
integer
#double
double precision
#date
datetime
#numeric
numeric({len},{dec})
#blob
integer
#c_table
create table {table} ( [{c_list} {typ_list}])
#i_table
insert into {table}  ( [{c_list}] ) values ( [{v_list}] )
#is_table
insert into {table}  ( [{c_list}] ) {select}
#u_emptydate  для InterBase обнуление пустых дат
update {table} set {col}=null where {col}="30.12.1899"
#commit
commit
#select*
select * from [{table}]
#select_table
select * from [{table}] where table_name={v_table}
#select_field
select * from [{table}] where vers<>{vers} and table_name={v_table} and fld_name={v_fld}
#select_flist
select [{c_list}] from [{table}]
#select_where
select [{c_list}] from [{table}] where {where}
#select_order
select [{c_list}] from [{table}] order by [{o_list}]
#select_worder
select [{c_list}] from [{table}] where {where} order by [{o_list}]
#select_group
select [{c_list}] from [{table}] group by [{g_list}]
#select_grorder
select [{c_list}] from [{table}] group by [{g_list}] order by [{o_list}]
#select_wgroup
select [{c_list}] from [{table}] where {where} group by [{g_list}]
#select_wgrorder
select [{c_list}] from [{table}] where {where} group by [{g_list}] order by [{o_list}]
#s+s
concat([{c_list}])
#asint
ceiling({col})
#asnum
{col}
#aschar
{col}
#aschar()
rpad({col},{len},' ')
#asdate
{col}
#dc_table
alter table {table} drop {col}
#ac_table
alter table {table} add {col} {type}
#u_table
update {table} set [{c_list}={v_list}]
#uw_table
update {table} set [{c_list}={v_list}] where {where}
#d_table
delete from {table}
#dw_table
delete from {table} where {where}
#sel_col_group
select {col} from {table} group by {col}
#trim_col
update {table} set {col}={v1} where {col2}={v2}
#exec_proc
execute procedure {name} {v_list}
#c_table_tmp
create temporary table {table} ( [{c_list} {typ_list}])
#fmtdate
yyyy-mm-dd
#fmtdatetime
yyyy-mm-dd hh:nn:ss:z
#now
now()
#minute
interval {count} minute
#c_index
create index {index} on {table} ([{c_list}])
#capabilities
datetime
#flush_tbl
flush tables
#notnull
not null
