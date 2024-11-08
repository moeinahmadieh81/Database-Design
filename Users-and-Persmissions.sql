create user 'john-stones'@'localhost' identified by 'johnstones2000john';
select * from mysql.user;
GRANT SELECT ON onlinestore.* TO 'john-stones'@'localhost';
SHOW GRANTS FOR 'john-stones'@'localhost';