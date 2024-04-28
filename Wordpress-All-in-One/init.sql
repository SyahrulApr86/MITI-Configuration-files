CREATE DATABASE IF NOT EXISTS wordpressweb;
CREATE DATABASE IF NOT EXISTS wordpressecomm;
GRANT ALL PRIVILEGES ON wordpressweb.* TO 'wordpressuser'@'%';
GRANT ALL PRIVILEGES ON wordpressecomm.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;

