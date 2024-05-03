-- Semua command SQL yang ada di file ini akan dijalankan ketika container MySQL pertama kali dijalankan

CREATE DATABASE IF NOT EXISTS wordpressweb;
CREATE DATABASE IF NOT EXISTS wordpressecomm;
CREATE DATABASE IF NOT EXISTS nextclouddb;
CREATE DATABASE IF NOT EXISTS joomla;
GRANT ALL PRIVILEGES ON wordpressweb.* TO 'databaseuser'@'%';
GRANT ALL PRIVILEGES ON wordpressecomm.* TO 'databaseuser'@'%';
GRANT ALL PRIVILEGES ON nextclouddb.* TO 'databaseuser'@'%';
GRANT ALL PRIVILEGES ON joomla.* TO 'databaseuser'@'%';
FLUSH PRIVILEGES;
