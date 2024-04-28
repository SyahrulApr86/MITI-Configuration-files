CREATE DATABASE IF NOT EXISTS wordpressweb;
CREATE DATABASE IF NOT EXISTS wordpressecomm;
CREATE DATABASE IF NOT EXISTS nextclouddb;
CREATE DATABASE IF NOT EXISTS joomla;
GRANT ALL PRIVILEGES ON wordpressweb.* TO 'wordpressuser'@'%';
GRANT ALL PRIVILEGES ON wordpressecomm.* TO 'wordpressuser'@'%';
GRANT ALL PRIVILEGES ON nextclouddb.* TO 'wordpressuser'@'%';
GRANT ALL PRIVILEGES ON joomla.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;
