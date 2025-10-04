#!/bin/bash
# Import PowerDNS schema into all databases

echo "=== Importing PowerDNS Schema ==="

sudo mysql -u root -p pdns_dilithium < /usr/share/doc/powerdns/schema.mysql.sql
sudo mysql -u root -p pdns_falcon < /usr/share/doc/powerdns/schema.mysql.sql
sudo mysql -u root -p pdns_sphincs < /usr/share/doc/powerdns/schema.mysql.sql

echo "Schema import complete!"
