#!/bin/bash
# Enable DNSSEC on all zones

echo "=== Enabling DNSSEC on Port 5300 (iem.local) ==="
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns secure-zone iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns rectify-zone iem.local

echo "=== Enabling DNSSEC on Port 5305 (dilithium.iem.local) ==="
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-dilithium secure-zone dilithium.iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-dilithium rectify-zone dilithium.iem.local

echo "=== Enabling DNSSEC on Port 5304 (falcon.iem.local) ==="
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-falcon secure-zone falcon.iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-falcon rectify-zone falcon.iem.local

echo "=== Enabling DNSSEC on Port 5303 (sphincs.iem.local) ==="
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-sphincs secure-zone sphincs.iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-sphincs rectify-zone sphincs.iem.local

echo "DNSSEC enabled on all zones!"
