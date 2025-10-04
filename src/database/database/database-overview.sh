#!/bin/bash
# Display overview of all databases

echo "=== POWERDNS DATABASE OVERVIEW ==="
echo ""

echo "--- Database: powerdns (Port 5300) ---"
mysql -u pdns -p'!emlab6.6' -e "USE powerdns; SELECT 'Domains:' AS ''; SELECT id, name, type FROM domains; SELECT 'Records:' AS ''; SELECT name, type, content FROM records; SELECT 'DNSSEC Keys:' AS ''; SELECT id, flags, active, published FROM cryptokeys;"

echo ""
echo "--- Database: pdns_dilithium (Port 5305) ---"
mysql -u pdns -p'!emlab6.6' -e "USE pdns_dilithium; SELECT 'Domains:' AS ''; SELECT id, name, type FROM domains; SELECT 'Records:' AS ''; SELECT name, type, content FROM records; SELECT 'DNSSEC Keys:' AS ''; SELECT id, flags, active, published FROM cryptokeys;"

echo ""
echo "--- Database: pdns_falcon (Port 5304) ---"
mysql -u pdns -p'!emlab6.6' -e "USE pdns_falcon; SELECT 'Domains:' AS ''; SELECT id, name, type FROM domains; SELECT 'Records:' AS ''; SELECT name, type, content FROM records; SELECT 'DNSSEC Keys:' AS ''; SELECT id, flags, active, published FROM cryptokeys;"

echo ""
echo "--- Database: pdns_sphincs (Port 5303) ---"
mysql -u pdns -p'!emlab6.6' -e "USE pdns_sphincs; SELECT 'Domains:' AS ''; SELECT id, name, type FROM domains; SELECT 'Records:' AS ''; SELECT name, type, content FROM records; SELECT 'DNSSEC Keys:' AS ''; SELECT id, flags, active, published FROM cryptokeys;"
