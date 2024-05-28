REM ***************************************************************************

REM    Oracle checklist for unix 
REM    Update: 2019
REM    ˵��: Oracle�ű���Ҫʹ��sys�û���½
REM          �������� sqlplus /nolog
REM          sql> connect /as sysdba;
REM          sql> @/tmp/oracle_linux.sql;
REM	   �ű����λ��

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
prompt ��ݼ���
prompt ========================================================================

prompt ========================================================================
prompt �鿴���ݿ�ʵ��
prompt S_Q_L>select instance_name from v$instance;
prompt ========================================================================
select instance_name from v$instance;

prompt ========================================================================
prompt ���븴�Ӷȡ���¼ʧ��
prompt ========================================================================
select profile,resource_name,limit from dba_profiles;

prompt ========================================================================
prompt �û�����ʹ�õĶ�Ӧ���뺯��
prompt S_Q_L>select USERNAME,PROFILE from dba_users;
prompt ========================================================================
select USERNAME,PROFILE from dba_users;

prompt ========================================================================
prompt ���ʿ���
prompt ========================================================================

prompt ========================================================================
prompt �鿴���ؼ�Զ�̵�¼��֤�û�
prompt S_Q_L>show parameter os_authent;
prompt ========================================================================
show parameter os_authent;

prompt ========================================================================
prompt �鿴Զ��������֤ģʽ
prompt S_Q_L>show parameter remote_login_passwordfile;
prompt ========================================================================
show parameter remote_login_passwordfile;

prompt ========================================================================
prompt �鿴���õ�XDB����
prompt S_Q_L>show parameter dispatcher;
prompt ========================================================================
show parameter dispatcher;

prompt ========================================================================
prompt ����Ա�����û�����DBAȨ��
prompt S_Q_L>select grantee from dba_role_privs where granted_role='DBA' and grantee not in ('SYS','SYSTEM','CTXSYS','WmSYS','SYSMAN');
prompt ========================================================================
select grantee from dba_role_privs where granted_role='DBA' and grantee not in ('SYS','SYSTEM','CTXSYS','WmSYS','SYSMAN');

prompt ========================================================================
prompt �鿴���������û�
prompt S_Q_L>select * from dba_users......
prompt ========================================================================
select * from dba_users where username in ('SCOTT','HR','OE','PM','SH','COMPANY','MFG','FINANCE','ANYDATA_USER','ANYDSET_USER','ANYTYPE_USER','AQJAVA','AQUSER', 'AQXMLUSER','GPFD','GPLD','MMO2','XMLGEN1','BLAmE','ADAMS','CLARm','JONES')or username like 'QS%'or username like 'USER%'or username like '%DEMO%'or username like 'SERVICECONSUMER%';

prompt ========================================================================
prompt �鿴�û���������Ч����
prompt S_Q_L>select USERNAME,PASSWORD,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,AUTHENTICATION_TYPE from dba_users;
prompt ========================================================================
select USERNAME,PASSWORD,PROFILE,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,AUTHENTICATION_TYPE from dba_users;

prompt ========================================================================
prompt �鿴����Ĭ�������û�
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
prompt �����ݿ������ֵ䱣��
prompt S_Q_L>show parameter O7_DICTIONARY_ACCESSIBILITY;
prompt ========================================================================
show parameter O7_DICTIONARY_ACCESSIBILITY;

prompt ========================================================================
prompt ��ȫ���
prompt ========================================================================

prompt ========================================================================
prompt �鿴��ȫ���
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
prompt �鿴��ǰ�������Щѡ��
prompt S_Q_L>select sel,upd,del,ins,gra from dba_obj_audit_opts;
prompt ========================================================================
select * from dba_obj_audit_opts;

prompt ========================================================================
prompt �鿴��ǰ���ݿ�ϵͳ���ѡ��
prompt S_Q_L>select sel,upd,del,ins,gra from dba_stmt_audit_opts;
prompt ========================================================================
select * from dba_stmt_audit_opts;

prompt ========================================================================
prompt �鿴��Ȩ�˻����Ȩ��
prompt S_Q_L>select sel,upd,del,ins,gra from dba_priv_audit_opts;
prompt ========================================================================
select * from dba_priv_audit_opts;

prompt ========================================================================
prompt �鿴�����־����
prompt S_Q_L>select value from v$parameter where name='audit_trail';
prompt ========================================================================
select value from v$parameter where name='audit_trail';

prompt ========================================================================
prompt ���ַ���
prompt ========================================================================

prompt ========================================================================
prompt �鿴���ݿ�汾
prompt S_Q_L>select * from v$version;
prompt ========================================================================
select * from v$version;

prompt ========================================================================
prompt �鿴���ݿ�10g��11g��12g���²�����¼
prompt S_Q_L>select * from dba_registry_history;
prompt ========================================================================
select * from dba_registry_history;

prompt ========================================================================
prompt �鿴���ݿ�12g���²��������¼
prompt S_Q_L>select * from dba_registry_sqlpatch;
prompt ========================================================================
select * from dba_registry_sqlpatch;

prompt ========================================================================
prompt �鿴���ݿ�12g���²�����¼
prompt S_Q_L>select PATCH_ID, PATCH_UID,VERSION,ACTION, STATUS,ACTION_TIME,DESCRIPTION from dba_registry_sqlpatch;
prompt ========================================================================
select PATCH_ID, PATCH_UID,VERSION,ACTION,STATUS,ACTION_TIME,DESCRIPTION from dba_registry_sqlpatch;

prompt ========================================================================
prompt �鿴�鵵��־ģʽ
prompt S_Q_L>select log_mode from v$database;
prompt ========================================================================
select log_mode from v$database;

prompt ========================================================================
prompt �鿴ʵ���鵵״̬
prompt S_Q_L>select archiver from v$instance; 
prompt ========================================================================
select archiver from v$instance;

prompt ========================================================================
prompt �鿴�ѹ鵵��־·��
prompt S_Q_L>select name from v$archived_log;
prompt ========================================================================
select name from v$archived_log;

prompt ========================================================================
prompt �鿴�鵵Ŀ¼�ռ�
prompt S_Q_L>show parameter db_recovery;
prompt ========================================================================
show parameter db_recovery;

prompt ========================================================================
prompt ���ӿ�鿴�鵵��־��
prompt S_Q_L>archive log list;
prompt ========================================================================
archive log list;

prompt ========================================================================
prompt �鿴���ݿ�public�û�Ȩ��
prompt S_Q_L>select table_name from dba_tab_privs where grantee='PUBLIC' and privilege='EXECUTE' and table_name like 'UTL%';
prompt ========================================================================
select table_name from dba_tab_privs where grantee='PUBLIC' and privilege='EXECUTE' and table_name like 'UTL%';

prompt ========================================================================
prompt �鿴��Դ���ƿ���״̬
prompt S_Q_L>show parameter resource_limit;
prompt ========================================================================
show parameter resource_limit;

prompt ========================================================================
prompt �鿴���ݿ�������ӳ�ʱʱ��
prompt S_Q_L>select * from dba_profiles where resource_name='IDLE_TIME';
prompt ========================================================================
select * from dba_profiles where resource_name='IDLE_TIME';

prompt ========================================================================
prompt �鿴���ݿ�ͬʱ����½�Ự��
prompt S_Q_L>select * from dba_profiles where resource_name='SESSIONS_PER_USER';
prompt ========================================================================
select * from dba_profiles where resource_name='SESSIONS_PER_USER';

prompt ========================================================================
prompt �鿴���ݿⵥ�λỰ�ڼ����ʹ�õ�CPUʱ�䣬��λ�ǰٷ�֮һ��
prompt S_Q_L>select * from dba_profiles where resource_name='CPU_PER_SESSION';
prompt ========================================================================
select * from dba_profiles where resource_name='CPU_PER_SESSION';

prompt ========================================================================
prompt �鿴���ݿ�ִ��ÿ��sql��ʹ�õ�cpuʱ�䣬��λ�ǰٷ�֮һ��
prompt S_Q_L>select * from dba_profiles where resource_name='CPU_PER_CALL';
prompt ========================================================================
select * from dba_profiles where resource_name='CPU_PER_CALL';

prompt ========================================================================
prompt �鿴���ݿ��ÿ���Ự�ܶ�ȡ�����ݿ�����
prompt S_Q_L>select * from dba_profiles where resource_name='LOGICAL_READS_PER_SESSION';
prompt ========================================================================
select * from dba_profiles where resource_name='LOGICAL_READS_PER_SESSION';

prompt ========================================================================
prompt �鿴���ݿ��ÿ��sql����ܶ�ȡ���ݿ���
prompt S_Q_L>select * from dba_profiles where resource_name='LOGICAL_READS_PER_CALL';
prompt ========================================================================
select * from dba_profiles where resource_name='LOGICAL_READS_PER_CALL';

prompt ========================================================================
prompt �鿴���ݿ�һ���Ự����ʹ�õ��ڴ�SGA�������ռ䣬��λ���ֽ�
prompt S_Q_L>select * from dba_profiles where resource_name='PRIVATE_SGA';
prompt ========================================================================
select * from dba_profiles where resource_name='PRIVATE_SGA';

prompt ========================================================================
prompt �鿴���ݿ�ÿ���û��ܹ��������ݿ���ʱ��
prompt S_Q_L>select * from dba_profiles where resource_name='CONNECT_TIME';
prompt ========================================================================
select * from dba_profiles where resource_name='CONNECT_TIME';

prompt ========================================================================
prompt �鿴���ݿ�һ���Ự���ܵ���Դ����
prompt S_Q_L>select * from dba_profiles where resource_name='COMPOSITE_LIMIT';
prompt ========================================================================
select * from dba_profiles where resource_name='COMPOSITE_LIMIT';

prompt ========================================================================
prompt �鿴���ݿ����б��
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
prompt SQL�ű�ִ�����!!!!!!
prompt ========================================================================

spool off;