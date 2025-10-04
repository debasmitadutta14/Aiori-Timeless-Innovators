-- Populate iem.local domain (Port 5300)

USE powerdns;

INSERT INTO domains (name, type) VALUES ('iem.local', 'MASTER');

INSERT INTO records (domain_id, name, type, content, ttl) VALUES
(LAST_INSERT_ID(), 'iem.local', 'SOA', 'ns1.iem.local admin.iem.local 2024091801 3600 1800 604800 86400', 3600),
(LAST_INSERT_ID(), 'iem.local', 'NS', 'ns1.iem.local', 3600),
(LAST_INSERT_ID(), 'ns1.iem.local', 'A', '14.194.176.205', 3600);
