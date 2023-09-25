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
timestamp
#numeric
numeric({len},{dec})
#blob
blob
#c_table
create table {table} ( [{c_list} {typ_list}])
#ce_table
create table {table} external "{file}" ( [{c_list} {typ_list}])
#i_table
insert into {table}  ( [{c_list}] ) values ( [{v_list}] )
#is_table
insert into {table}  ( [{c_list}] ) {select}
#u_emptydate  для InterBase обнуление пустых дат
update {table} set {col}=null where {col}="30.12.1899"
#u_empextdate  для InterBase обнуление пустых дат (External file)
update {table} set {col}=null where {col}="17.11.1858"
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
#sel_gh
select [{c_list}] from [{table}] group by [{g_list}] having {have}
#sel_wgh
select [{c_list}] from [{table}] where {where} group by [{g_list}] having {have}
#sel_gho
select [{c_list}] from [{table}] group by [{g_list}] having {have} order by [{o_list}]
#sel_wgho
select [{c_list}] from [{table}] where {where} group by [{g_list}] having {have} order by [{o_list}]
#s+s
[{c_list}]"||"
#asint
cast ({col} as INTEGER)
#asnum
cast ({col} as double precision)
#aschar
cast ({col} as CHARACTER)
#aschar()
cast ({col} as CHAR({len}))
#asdate
cast ({col} as DATE)
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
#union
{select1} union {select2}
#fmtdate
dd/mm/yyyy
#fmtdatetime
dd/mm/yyyy hh:nn:ss:zzz
#now
"now"
#getnow
select cast({c_list} as timestamp)-"now" from GLOBSET
#minute
{count}/24/60
#c_index
create index {index} on {table} ([{c_list}])
#notnull
not null
#capabilities
datetime
transaction
in_select
blob
