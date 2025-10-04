-- Create all databases for PQC DNSSEC Testbed

CREATE DATABASE powerdns;
CREATE DATABASE pdns_dilithium;
CREATE DATABASE pdns_falcon;
CREATE DATABASE pdns_sphincs;

-- Grant privileges to pdns user
GRANT ALL PRIVILEGES ON powerdns.* TO 'pdns'@'localhost';
GRANT ALL PRIVILEGES ON pdns_dilithium.* TO 'pdns'@'localhost';
GRANT ALL PRIVILEGES ON pdns_falcon.* TO 'pdns'@'localhost';
GRANT ALL PRIVILEGES ON pdns_sphincs.* TO 'pdns'@'localhost';

FLUSH PRIVILEGES;
