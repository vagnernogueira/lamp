create user 'root'@'%' identified by 'root';
use mysql;
update user set password=PASSWORD('root') where user='root';
update user set plugin="mysql_native_password";
flush privileges;
