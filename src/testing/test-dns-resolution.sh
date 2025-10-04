#!/bin/bash
# Test DNS resolution on all ports

echo "=== Testing DNS Resolution on All Ports ==="

echo ""
echo "--- Port 5300 (iem.local) ---"
dig @14.194.176.205 -p 5300 iem.local SOA
dig @14.194.176.205 -p 5300 ns1.iem.local A

echo ""
echo "--- Port 5305 (dilithium.iem.local) ---"
dig @14.194.176.205 -p 5305 dilithium.iem.local SOA
dig @14.194.176.205 -p 5305 www.dilithium.iem.local A
dig @14.194.176.205 -p 5305 test.dilithium.iem.local A

echo ""
echo "--- Port 5304 (falcon.iem.local) ---"
dig @14.194.176.205 -p 5304 falcon.iem.local SOA
dig @14.194.176.205 -p 5304 www.falcon.iem.local A
dig @14.194.176.205 -p 5304 test.falcon.iem.local A

echo ""
echo "--- Port 5303 (sphincs.iem.local) ---"
dig @14.194.176.205 -p 5303 sphincs.iem.local SOA
dig @14.194.176.205 -p 5303 www.sphincs.iem.local A
dig @14.194.176.205 -p 5303 test.sphincs.iem.local A
