#!/bin/bash
# Create a test zone file for PQC signing

sudo mkdir -p /etc/powerdns/zones

sudo tee /etc/powerdns/zones/test.zone > /dev/null << 'EOF'
$ORIGIN test.iem.local.
$TTL 3600
@ IN SOA ns1.test.iem.local. admin.test.iem.local. (
    2024091801 ; Serial
    3600       ; Refresh
    1800       ; Retry
    604800     ; Expire
    86400      ; Minimum TTL
)
@ IN NS ns1.test.iem.local.
ns1 IN A 14.194.176.205
www IN A 14.194.176.205
EOF

echo "Test zone created: /etc/powerdns/zones/test.zone"

# Test signing with different algorithms
echo ""
echo "=== Testing PQC Signing ==="

sudo /usr/local/bin/pqc-zone-signer.sh /etc/powerdns/zones/test.zone dilithium3
echo ""
sudo /usr/local/bin/pqc-zone-signer.sh /etc/powerdns/zones/test.zone falcon512
echo ""
sudo /usr/local/bin/pqc-zone-signer.sh /etc/powerdns/zones/test.zone sphincs

echo ""
