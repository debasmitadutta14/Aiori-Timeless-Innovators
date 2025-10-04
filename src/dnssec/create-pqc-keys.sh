#!/bin/bash
# Create simulated PQC key files

echo "=== Creating PQC Key Directory ==="
sudo mkdir -p /etc/powerdns/pqc-keys
cd /etc/powerdns/pqc-keys

echo "=== Creating Dilithium3 Key ==="
echo "-----BEGIN SIMULATED PQC PRIVATE KEY-----" | sudo tee dilithium3.pem
echo "Algorithm: dilithium3 (simulated)" | sudo tee -a dilithium3.pem
echo "Key: $(openssl rand -hex 32)" | sudo tee -a dilithium3.pem
echo "-----END SIMULATED PQC PRIVATE KEY-----" | sudo tee -a dilithium3.pem

echo "=== Creating Falcon512 Key ==="
echo "-----BEGIN SIMULATED PQC PRIVATE KEY-----" | sudo tee falcon512.pem
echo "Algorithm: falcon512 (simulated)" | sudo tee -a falcon512.pem
echo "Key: $(openssl rand -hex 32)" | sudo tee -a falcon512.pem
echo "-----END SIMULATED PQC PRIVATE KEY-----" | sudo tee -a falcon512.pem

echo "=== Creating SPHINCS+ Key ==="
echo "-----BEGIN SIMULATED PQC PRIVATE KEY-----" | sudo tee sphincs.pem
echo "Algorithm: sphincssha256128frobust (simulated)" | sudo tee -a sphincs.pem
echo "Key: $(openssl rand -hex 32)" | sudo tee -a sphincs.pem
echo "-----END SIMULATED PQC PRIVATE KEY-----" | sudo tee -a sphincs.pem

echo "=== Verifying Keys ==="
ls -la /etc/powerdns/pqc-keys/

echo "PQC keys created successfully!"
