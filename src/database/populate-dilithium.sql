-- Populate dilithium.iem.local domain (Port 5305)

USE pdns_dilithium;

INSERT INTO domains (name, type) VALUES ('dilithium.iem.local', 'MASTER');

INSERT INTO records (domain_id, name, type, content, ttl) VALUES
(LAST_INSERT_ID(), 'dilithium.iem.local', 'SOA', 'ns1.dilithium.iem.local admin.dilithium.iem.local 2024091801 3600 1800 604800 86400', 3600),
(LAST_INSERT_ID(), 'dilithium.iem.local', 'NS', 'ns1.dilithium.iem.local', 3600),
(LAST_INSERT_ID(), 'ns1.dilithium.iem.local', 'A', '14.194.176.205', 3600),
(LAST_INSERT_ID(), 'www.dilithium.iem.local', 'A', '14.194.176.205', 3600),
(LAST_INSERT_ID(), 'test.dilithium.iem.local', 'A', '14.194.176.205', 3600);
