CREATE DATABASE IF NOT EXISTS wordpressweb;
CREATE DATABASE IF NOT EXISTS wordpressecomm;
CREATE DATABASE IF NOT EXISTS nextclouddb;
GRANT ALL PRIVILEGES ON wordpressweb.* TO 'wordpressuser'@'%';
GRANT ALL PRIVILEGES ON wordpressecomm.* TO 'wordpressuser'@'%';
GRANT ALL PRIVILEGES ON nextclouddb.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;
