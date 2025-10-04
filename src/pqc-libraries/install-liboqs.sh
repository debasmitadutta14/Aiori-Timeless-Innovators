#!/bin/bash
# Install liboqs - Open Quantum Safe Library

echo "=== Installing liboqs ==="

cd /tmp
git clone https://github.com/open-quantum-safe/liboqs.git
cd liboqs
mkdir build && cd build

cmake -DCMAKE_INSTALL_PREFIX=/opt/liboqs ..
make -j$(nproc)
sudo make install

# Configure library path
echo "/opt/liboqs/lib" | sudo tee /etc/ld.so.conf.d/liboqs.conf
sudo ldconfig

echo "liboqs installation complete!"
echo "Installation location: /opt/liboqs"
