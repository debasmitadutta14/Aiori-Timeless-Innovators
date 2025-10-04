#!/bin/bash
# PQC Zone Signing Script (Simulation)

ZONE_FILE="$1"
PQC_ALGORITHM="$2"
OUTPUT_DIR="/etc/powerdns/signed-zones"

if [ $# -lt 2 ]; then
    echo "Usage: $0 <zone_file> <algorithm>"
    echo "Algorithms: dilithium3, falcon512, sphincs"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

case "$PQC_ALGORITHM" in
    "dilithium3")
        KEY_FILE="/etc/powerdns/pqc-keys/dilithium3.pem"
        ALGORITHM_ID="TBD-DILITHIUM3"
        ;;
    "falcon512")
        KEY_FILE="/etc/powerdns/pqc-keys/falcon512.pem"
        ALGORITHM_ID="TBD-FALCON512"
        ;;
    "sphincs")
        KEY_FILE="/etc/powerdns/pqc-keys/sphincs.pem"
        ALGORITHM_ID="TBD-SPHINCS+"
        ;;
    *)
        echo "Unsupported algorithm: $PQC_ALGORITHM"
        exit 1
        ;;
esac

echo "Signing zone with $PQC_ALGORITHM..."

ZONE_NAME=$(basename "$ZONE_FILE" .zone)

# Create signed zone file
SIGNED_ZONE="$OUTPUT_DIR/${ZONE_NAME}.${PQC_ALGORITHM}.signed"
cp "$ZONE_FILE" "$SIGNED_ZONE"

# Add simulated RRSIG records
cat >> "$SIGNED_ZONE" << EOF

; PQC RRSIG Records (SIMULATED)
; Algorithm: $ALGORITHM_ID
\$ORIGIN $ZONE_NAME.
@ 3600 IN RRSIG SOA $ALGORITHM_ID 2 3600 $(date -d '+30 days' +%Y%m%d%H%M%S) $(date +%Y%m%d%H%M%S) 12345 $ZONE_NAME.
SIMULATED_PQC_SIGNATURE_$(openssl rand -hex 16)
EOF

echo "Signed zone created: $SIGNED_ZONE"

# Calculate signature sizes
ORIGINAL_SIZE=$(stat -c%s "$ZONE_FILE")
SIGNED_SIZE=$(stat -c%s "$SIGNED_ZONE")
OVERHEAD=$((SIGNED_SIZE - ORIGINAL_SIZE))

echo "Zone signing complete!"
echo "Original size: $ORIGINAL_SIZE bytes"
echo "Signed size: $SIGNED_SIZE bytes"
echo "PQC overhead: $OVERHEAD bytes"

# Make executable (instruction when installing)
# sudo chmod +x /usr/local/bin/pqc-zone-signer.sh
