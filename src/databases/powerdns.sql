-- powerdns (Main)
CREATE DATABASE IF NOT EXISTS powerdns;
USE powerdns;

CREATE TABLE domains (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(6)
);

CREATE TABLE records (
  id INT AUTO_INCREMENT PRIMARY KEY,
  domain_id INT,
  name VARCHAR(255),
  type VARCHAR(10),
  content TEXT,
  ttl INT
);

CREATE TABLE cryptokeys (
  id INT AUTO_INCREMENT PRIMARY KEY,
  flags INT,
  active BOOL,
  published BOOL
);

INSERT INTO domains (name, type) VALUES ('iem.local', 'MASTER');
SET @domain_id = LAST_INSERT_ID();
INSERT INTO records (domain_id, name, type, content, ttl) VALUES
(@domain_id, 'iem.local', 'SOA', 'ns1.iem.local admin.iem.local 2024091801 3600 1800 604800 86400', 3600),
(@domain_id, 'iem.local', 'NS', 'ns1.iem.local', 3600),
(@domain_id, 'ns1.iem.local', 'A', '14.194.176.205', 3600);
