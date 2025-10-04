#!/bin/bash
# Test DNSSEC on all ports

echo "=== Testing DNSSEC on All Ports ==="

for port in 5300 5303 5304 5305; do
    echo ""
    echo "=== Port $port ==="
    case $port in
        5300) domain="iem.local" ;;
        5303) domain="sphincs.iem.local" ;;
        5304) domain="falcon.iem.local" ;;
        5305) domain="dilithium.iem.local" ;;
    esac
    
    dig @14.194.176.205 -p $port $domain SOA +dnssec +multiline
    echo ""
done
