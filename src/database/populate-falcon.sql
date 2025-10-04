-- Populate falcon.iem.local domain (Port 5304)

USE pdns_falcon;

INSERT INTO domains (name, type) VALUES ('falcon.iem.local', 'MASTER');

INSERT INTO records (domain_id, name, type, content, ttl) VALUES
(LAST_INSERT_ID(), 'falcon.iem.local', 'SOA', 'ns1.falcon.iem.local admin.falcon.iem.local 2024091801 3600 1800 604800 86400', 3600),
(LAST_INSERT_ID(), 'falcon.iem.local', 'NS', 'ns1.falcon.iem.local', 3600),
(LAST_INSERT_ID(), 'ns1.falcon.iem.local', 'A', '14.194.176.205', 3600),
(LAST_INSERT_ID(), 'www.falcon.iem.local', 'A', '14.194.176.205', 3600),
(LAST_INSERT_ID(), 'test.falcon.iem.local', 'A', '14.194.176.205', 3600);
