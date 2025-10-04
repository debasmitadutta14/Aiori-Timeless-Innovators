
#!/bin/bash
# Install Dependencies for PQC DNSSEC Testbed

echo "=== Installing System Dependencies ==="
sudo apt update
sudo apt install build-essential cmake git libssl-dev -y

echo "=== Installing PowerDNS and MySQL ==="
sudo apt install pdns-server pdns-backend-mysql mysql-server -y

echo "Dependencies installation complete!"
