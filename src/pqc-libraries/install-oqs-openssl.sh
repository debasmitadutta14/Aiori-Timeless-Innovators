#!/bin/bash
# Install OQS-OpenSSL - OpenSSL with PQC Support

echo "=== Installing OQS-OpenSSL ==="

cd /tmp
git clone https://github.com/open-quantum-safe/openssl.git
cd openssl

./Configure linux-x86_64 --prefix=/opt/oqs-openssl
make -j$(nproc)
sudo make install

echo "OQS-OpenSSL installation complete!"
echo "Installation location: /opt/oqs-openssl"
