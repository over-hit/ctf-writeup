REM ***************************************************************************

REM    Oracle checklist for unix 
REM    Update: 2019
REM    说明: Oracle脚本需要使用sys用户登陆
REM          运行命令 sqlplus /nolog
REM          sql> connect /as sysdba;
REM          sql> @/tmp/oracle_linux.sql;
REM	   脚本存放位置

REM ***************************************************************************
whenever sqlerror continue
set feed on
set head on
set arraysize 1
set space 1
set verify off
set pages 25
set lines 280

clear screen

clear screen
define aaa='/tmp/oracle_sec.log'
spool &aaa;

prompt ========================================================================
prompt 身份鉴别
prompt ========================================================================

prompt ========================================================================
prompt 查看数据库实例
prompt S_Q_L>select instance_name from v$instance;
prompt ========================================================================
select instance_name from v$instance;

prompt ========================================================================
prompt 密码复杂度、登录失败
prompt ========================================================================
select profile,resource_name,limit from dba_profiles;

prompt ========================================================================
prompt 用户正在使用的对应密码函数
prompt S_Q_L>select USERNAME,PROFILE from dba_users;
prompt ========================================================================
select USERNAME,PROFILE from dba_users;

prompt ========================================================================
prompt 访问控制
prompt ========================================================================

prompt ========================================================================
prompt 查看本地及远程登录认证用户
prompt S_Q_L>show parameter os_authent;
prompt ========================================================================
show parameter os_authent;

prompt ========================================================================
prompt 查看远程密码认证模式
prompt S_Q_L>show parameter remote_login_passwordfile;
prompt ========================================================================
show parameter remote_login_passwordfile;

prompt ========================================================================
prompt 查看启用的XDB服务
prompt S_Q_L>show parameter dispatcher;
prompt ========================================================================
show parameter dispatcher;

prompt ========================================================================
prompt 管理员以外用户存在DBA权限
prompt S_Q_L>select grantee from dba_role_privs where granted_role='DBA' and grantee not in ('SYS','SYSTEM','CTXSYS','WmSYS','SYSMAN');
prompt ========================================================================
select grantee from dba_role_privs where granted_role='DBA' and grantee not in ('SYS','SYSTEM','CTXSYS','WmSYS','SYSMAN');

prompt ========================================================================
prompt 查看锁定多余用户
prompt S_Q_L>select * from dba_users......
prompt ========================================================================
select * from dba_users where username in ('SCOTT','HR','OE','PM','SH','COMPANY','MFG','FINANCE','ANYDATA_USER','ANYDSET_USER','ANYTYPE_USER','AQJAVA','AQUSER', 'AQXMLUSER','GPFD','GPLD','MMO2','XMLGEN1','BLAmE','ADAMS','CLARm','JONES')or username like 'QS%'or username like 'USER%'or username like '%DEMO%'or username like 'SERVICECONSUMER%';

prompt ========================================================================
prompt 查看用户锁定及有效期限
prompt S_Q_L>select USERNAME,PASSWORD,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,AUTHENTICATION_TYPE from dba_users;
prompt ========================================================================
select USERNAME,PASSWORD,PROFILE,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,AUTHENTICATION_TYPE from dba_users;

prompt ========================================================================
prompt 查看存在默认密码用户
prompt S_Q_L>select username "User(s) with Default Password!" from dba_users where password in (???);
prompt ========================================================================
select username "User(s) with Default Password!"
 from dba_users
 where password in
('E066D214D5421CCC',  -- dbsnmp
 '24ABAB8B06281B4C',  -- ctxsys
 '72979A94BAD2AF80',  -- mdsys
 'C252E8FA117AF049',  -- odm
 'A7A32CD03D3CE8D5',  -- odm_mtr
 '88A2B2C183431F00',  -- ordplugins
 '7EFA02EC7EA6B86F',  -- ordsys
 '4A3BA55E08595C81',  -- outln
 'F894844C34402B67',  -- scott
 '3F9FBD883D787341',  -- wk_proxy
 '79DF7A1BD138CF11',  -- wk_sys
 '7C9BA362F8314299',  -- wmsys
 '88D8364765FCE6AF',  -- xdb
 'F9DA8977092B7B81',  -- tracesvr
 '9300C0977D7DC75E',  -- oas_public
 'A97282CE3D94E29E',  -- websys
 'AC9700FD3F1410EB',  -- lbacsys
 'E7B5D92911C831E1',  -- rman
 'AC98877DE1297365',  -- perfstat
 '66F4EF5650C20355',  -- exfsys
 '84B8CBCA4D477FA3',  -- si_informtn_schema
 'D4C5016086B2DC6A',  -- sys
 'D4DF7931AB130E37')  -- system
/           

prompt ========================================================================
prompt 对数据库数据字典保护
prompt S_Q_L>show parameter O7_DICTIONARY_ACCESSIBILITY;
prompt ========================================================================
show parameter O7_DICTIONARY_ACCESSIBILITY;

prompt ========================================================================
prompt 安全审计
prompt ========================================================================

prompt ========================================================================
prompt 查看安全审计
prompt S_Q_L>show parameter audit;
prompt ========================================================================
show parameter audit;
prompt S_Q_L>show parameter audit_trail;
prompt ========================================================================
show parameter audit_trail;
prompt S_Q_L>show parameter audit_sys_operations;
prompt ========================================================================
show parameter audit_sys_operations;

prompt ========================================================================
prompt 查看当前审计了哪些选项
prompt S_Q_L>select sel,upd,del,ins,gra from dba_obj_audit_opts;
prompt ========================================================================
select * from dba_obj_audit_opts;

prompt ========================================================================
prompt 查看当前数据库系统审计选项
prompt S_Q_L>select sel,upd,del,ins,gra from dba_stmt_audit_opts;
prompt ========================================================================
select * from dba_stmt_audit_opts;

prompt ========================================================================
prompt 查看特权账户审计权限
prompt S_Q_L>select sel,upd,del,ins,gra from dba_priv_audit_opts;
prompt ========================================================================
select * from dba_priv_audit_opts;

prompt ========================================================================
prompt 查看审计日志策略
prompt S_Q_L>select value from v$parameter where name='audit_trail';
prompt ========================================================================
select value from v$parameter where name='audit_trail';

prompt ========================================================================
prompt 入侵防范
prompt ========================================================================

prompt ========================================================================
prompt 查看数据库版本
prompt S_Q_L>select * from v$version;
prompt ========================================================================
select * from v$version;

prompt ========================================================================
prompt 查看数据库10g、11g、12g更新补丁记录
prompt S_Q_L>select * from dba_registry_history;
prompt ========================================================================
select * from dba_registry_history;

prompt ========================================================================
prompt 查看数据库12g更新补丁补充记录
prompt S_Q_L>select * from dba_registry_sqlpatch;
prompt ========================================================================
select * from dba_registry_sqlpatch;

prompt ========================================================================
prompt 查看数据库12g更新补丁记录
prompt S_Q_L>select PATCH_ID, PATCH_UID,VERSION,ACTION, STATUS,ACTION_TIME,DESCRIPTION from dba_registry_sqlpatch;
prompt ========================================================================
select PATCH_ID, PATCH_UID,VERSION,ACTION,STATUS,ACTION_TIME,DESCRIPTION from dba_registry_sqlpatch;

prompt ========================================================================
prompt 查看归档日志模式
prompt S_Q_L>select log_mode from v$database;
prompt ========================================================================
select log_mode from v$database;

prompt ========================================================================
prompt 查看实例归档状态
prompt S_Q_L>select archiver from v$instance; 
prompt ========================================================================
select archiver from v$instance;

prompt ========================================================================
prompt 查看已归档日志路径
prompt S_Q_L>select name from v$archived_log;
prompt ========================================================================
select name from v$archived_log;

prompt ========================================================================
prompt 查看归档目录空间
prompt S_Q_L>show parameter db_recovery;
prompt ========================================================================
show parameter db_recovery;

prompt ========================================================================
prompt 连接库查看归档日志单
prompt S_Q_L>archive log list;
prompt ========================================================================
archive log list;

prompt ========================================================================
prompt 查看数据库public用户权限
prompt S_Q_L>select table_name from dba_tab_privs where grantee='PUBLIC' and privilege='EXECUTE' and table_name like 'UTL%';
prompt ========================================================================
select table_name from dba_tab_privs where grantee='PUBLIC' and privilege='EXECUTE' and table_name like 'UTL%';

prompt ========================================================================
prompt 查看资源限制开关状态
prompt S_Q_L>show parameter resource_limit;
prompt ========================================================================
show parameter resource_limit;

prompt ========================================================================
prompt 查看数据库空闲连接超时时间
prompt S_Q_L>select * from dba_profiles where resource_name='IDLE_TIME';
prompt ========================================================================
select * from dba_profiles where resource_name='IDLE_TIME';

prompt ========================================================================
prompt 查看数据库同时最大登陆会话数
prompt S_Q_L>select * from dba_profiles where resource_name='SESSIONS_PER_USER';
prompt ========================================================================
select * from dba_profiles where resource_name='SESSIONS_PER_USER';

prompt ========================================================================
prompt 查看数据库单次会话期间可以使用的CPU时间，单位是百分之一秒
prompt S_Q_L>select * from dba_profiles where resource_name='CPU_PER_SESSION';
prompt ========================================================================
select * from dba_profiles where resource_name='CPU_PER_SESSION';

prompt ========================================================================
prompt 查看数据库执行每条sql所使用的cpu时间，单位是百分之一秒
prompt S_Q_L>select * from dba_profiles where resource_name='CPU_PER_CALL';
prompt ========================================================================
select * from dba_profiles where resource_name='CPU_PER_CALL';

prompt ========================================================================
prompt 查看数据库的每个会话能读取的数据库数量
prompt S_Q_L>select * from dba_profiles where resource_name='LOGICAL_READS_PER_SESSION';
prompt ========================================================================
select * from dba_profiles where resource_name='LOGICAL_READS_PER_SESSION';

prompt ========================================================================
prompt 查看数据库的每个sql语句能读取数据块数
prompt S_Q_L>select * from dba_profiles where resource_name='LOGICAL_READS_PER_CALL';
prompt ========================================================================
select * from dba_profiles where resource_name='LOGICAL_READS_PER_CALL';

prompt ========================================================================
prompt 查看数据库一个会话可以使用的内存SGA区的最大空间，单位：字节
prompt S_Q_L>select * from dba_profiles where resource_name='PRIVATE_SGA';
prompt ========================================================================
select * from dba_profiles where resource_name='PRIVATE_SGA';

prompt ========================================================================
prompt 查看数据库每个用户能够连接数据库的最长时间
prompt S_Q_L>select * from dba_profiles where resource_name='CONNECT_TIME';
prompt ========================================================================
select * from dba_profiles where resource_name='CONNECT_TIME';

prompt ========================================================================
prompt 查看数据库一个会话的总的资源消耗
prompt S_Q_L>select * from dba_profiles where resource_name='COMPOSITE_LIMIT';
prompt ========================================================================
select * from dba_profiles where resource_name='COMPOSITE_LIMIT';

prompt ========================================================================
prompt 查看数据库敏感标记
prompt ========================================================================
select username from dba_users;
prompt ========================================================================
select policy_name,status from dba_sa_policies;
prompt ========================================================================
select * from dba_sa_levels order by level_num;
prompt ========================================================================
select * from dba_sa_labels;
prompt ========================================================================
select * from dba_sa_table_policies;

prompt ========================================================================
prompt SQL脚本执行完成!!!!!!
prompt ========================================================================

spool off;