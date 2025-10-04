# Aiori-Timeless-Innovators
Problem Statement 03: Post-Quantum DNSSEC Testbed under a Delegated .IN Domain
 
**Institution:** Institute of Engineering & Management (IEM-UEM), Kolkata  
**Team Name:** Timeless Innovators  

### Members
- **Rajdeep Das**
- **Debasmita Dutta**
- **Dr. Indrajit De**

---

## 🔍 Background

With the advancement of quantum computing, cryptographic primitives used in DNSSEC — primarily RSA and ECDSA — are at risk of compromise.  
This project builds an experimental **Post-Quantum Cryptography (PQC)**-enabled **DNSSEC testbed**, designed to be scalable to a **delegated `.IN` Second-Level Domain (SLD)** in future phases.

The immediate implementation focuses on a **local environment (`iem.local`)**, serving as a fully functional prototype to validate PQC algorithms, infrastructure automation, and signing behavior before real delegation.

---

## 🎯 Core Objectives

1. **Delegated PQC Testbed Setup**
   - Establish a delegated `.IN` SLD (e.g., `pqc-research.in`) for PQC-signed zones.
   - Verify delegation anchoring and resolver reachability.  
   *(Planned — pending external DNS delegation setup)*

2. **Prototype Authoritative Servers**
   - Implement PQC-compliant PowerDNS authoritative instances (local testbed completed).  
   - Track resolver fallback behavior over UDP/TCP under PQC signature load.

3. **Performance & Abuse Analysis**
   - Measure PQC overhead, latency, packet fragmentation, and caching anomalies.

4. **Benchmarking with AIORI IMNs**
   - Compare performance of Dilithium3, Falcon512, and SPHINCS+ using distributed IMNs.  
   *(To be performed after `.IN` domain delegation is live)*

5. **Protocol Validation & Feedback**
   - Validate operational compatibility and draft early feedback for IETF PQDNSSEC.

---

## 🧱 Project Implementation Overview

This repository documents the **local deployment and verification** of a PQC DNSSEC testbed built using **PowerDNS**, **MySQL**, and **liboqs** tools.  
It serves as a baseline framework for upcoming **delegated `.IN` integration**.

---

## ⚙️ Experimental Setup

**Platform:** Proxmox VE Hypervisor (HPE ML30 Gen10 Plus)  
**Virtual Machines:**

| VM ID | Hostname | Role | IP | Description |
|--------|-----------|------|----|-------------|
| 100 | iem-ubuntu-dns-server | Authoritative DNS Server | 14.194.176.205 | PowerDNS 4.5.3 + MySQL 8.0 |
| 103 | iem-ubuntu-dns-client | DNS Resolver Client | 14.194.176.204 | Performs DNSSEC and PQC testing |

**Algorithms Tested:**
- **RSA/ECDSA (Baseline)**
- **Dilithium3 (Lattice-based PQC)**
- **Falcon512 (Compact Lattice-based PQC)**
- **SPHINCS+ (Hash-based PQC)**

## 🖥️ VM 100 – PowerDNS Authoritative Server (PQC-Enabled)

Hostname: iem-ubuntu-dns-server

IP Address: 14.194.176.205

Role: Authoritative DNS Server (Baseline + PQC variants)

Databases:
- powerdns (Traditional)
- pdns_dilithium
- pdns_falcon
- pdns_sphincs

### Phase 1 – Install Prerequisites and PowerDNS**
```bash
sudo apt update
sudo apt install -y pdns-server pdns-backend-mysql mysql-server dnsutils git build-essential cmake libssl-dev

pdns_server --version
```

## Phase 2 – Setup PQC Libraries (for Signature Simulation)**
```bash
cd /tmp
git clone https://github.com/open-quantum-safe/liboqs.git
cd liboqs && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/liboqs ..
make -j$(nproc)
sudo make install
echo "/opt/liboqs/lib" | sudo tee /etc/ld.so.conf.d/liboqs.conf
sudo ldconfig

```

## Phase 3 – Create PQC Key Directory**
```bash
sudo mkdir -p /etc/powerdns/pqc-keys
cd /etc/powerdns/pqc-keys

# Simulated keys
echo "-----BEGIN SIMULATED PQC PRIVATE KEY-----" | sudo tee dilithium3.pem
echo "Algorithm: dilithium3 (simulated)" | sudo tee -a dilithium3.pem
echo "Key: $(openssl rand -hex 32)" | sudo tee -a dilithium3.pem
echo "-----END SIMULATED PQC PRIVATE KEY-----" | sudo tee -a dilithium3.pem

echo "-----BEGIN SIMULATED PQC PRIVATE KEY-----" | sudo tee falcon512.pem
echo "Algorithm: falcon512 (simulated)" | sudo tee -a falcon512.pem
echo "Key: $(openssl rand -hex 32)" | sudo tee -a falcon512.pem
echo "-----END SIMULATED PQC PRIVATE KEY-----" | sudo tee -a falcon512.pem

echo "-----BEGIN SIMULATED PQC PRIVATE KEY-----" | sudo tee sphincs.pem
echo "Algorithm: sphincs+ (simulated)" | sudo tee -a sphincs.pem
echo "Key: $(openssl rand -hex 32)" | sudo tee -a sphincs.pem
echo "-----END SIMULATED PQC PRIVATE KEY-----" | sudo tee -a sphincs.pem

```

## Phase 4 – Configure MySQL Databases**
```bash
sudo mysql -u root -p
```
```sql
CREATE DATABASE powerdns;
CREATE DATABASE pdns_dilithium;
CREATE DATABASE pdns_falcon;
CREATE DATABASE pdns_sphincs;

CREATE USER 'pdns'@'localhost' IDENTIFIED BY '<DB_PASSWORD>';
GRANT ALL PRIVILEGES ON *.* TO 'pdns'@'localhost';
FLUSH PRIVILEGES;
exit;
```
```bash
sudo mysql -u root -p powerdns < /usr/share/doc/powerdns/schema.mysql.sql
sudo mysql -u root -p pdns_dilithium < /usr/share/doc/powerdns/schema.mysql.sql
sudo mysql -u root -p pdns_falcon < /usr/share/doc/powerdns/schema.mysql.sql
sudo mysql -u root -p pdns_sphincs < /usr/share/doc/powerdns/schema.mysql.sql
```
## Phase 5 – Configure PowerDNS Instances**
```ini
# /etc/powerdns/pdns-dilithium.conf
launch=gmysql
gmysql-host=127.0.0.1
gmysql-user=pdns
gmysql-password=<DB_PASSWORD>
gmysql-dbname=pdns_dilithium
gmysql-dnssec=yes
local-address=14.194.176.205
local-port=5305

```
Repeat with respective database and port numbers for each algorithm.
| Algorithm |	Config | File	| Database	| Port |
|-----------|--------|------|----------|-------|
| Traditional |	pdns.conf	| powerdns	| 5300 |
| Dilithium3 |	pdns-dilithium.conf |	pdns_dilithium	| 5305 |
| Falcon512	pdns-falcon.conf	| pdns_falcon	| 5304 |
| SPHINCS+	pdns-sphincs.conf	| pdns_sphincs	| 5303 |

## Phase 6 – Populate DNS Zones**
```dns
$ORIGIN dilithium.iem.local.
$TTL 3600
@ IN SOA ns1.dilithium.iem.local. admin.dilithium.iem.local. (
  2024091801 ; Serial
  3600 ; Refresh
  1800 ; Retry
  604800 ; Expire
  86400 ; Minimum TTL
)
@ IN NS ns1.dilithium.iem.local.
ns1 IN A 14.194.176.205
www IN A 14.194.176.205
test IN A 14.194.176.205

```
```bash
sudo mysql -u pdns -p'<DB_PASSWORD>' pdns_dilithium <<'EOF'
INSERT INTO domains (name, type) VALUES ('dilithium.iem.local', 'MASTER');
SET @did = LAST_INSERT_ID();
INSERT INTO records (domain_id, name, type, content, ttl) VALUES
(@did, 'dilithium.iem.local', 'SOA', 'ns1.dilithium.iem.local admin.dilithium.iem.local 2024091801 3600 1800 604800 86400', 3600),
(@did, 'dilithium.iem.local', 'NS', 'ns1.dilithium.iem.local', 3600),
(@did, 'ns1.dilithium.iem.local', 'A', '14.194.176.205', 3600),
(@did, 'www.dilithium.iem.local', 'A', '14.194.176.205', 3600),
(@did, 'test.dilithium.iem.local', 'A', '14.194.176.205', 3600);
EOF

```
Repeat for Falcon, SPHINCS+, and baseline iem.local.

## Phase 7 – Enable DNSSEC on All Zones**
For baseline zone:
```bash
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-dilithium secure-zone dilithium.iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-falcon secure-zone falcon.iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns-sphincs secure-zone sphincs.iem.local
```
For PQC zones:
```bash
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns secure-zone iem.local
sudo pdnsutil --config-dir=/etc/powerdns --config-name=pdns rectify-zone iem.local
```
Confirm:
```bash
sudo pdnsutil list-zone-keys dilithium.iem.local
```

## Phase 8 – Start PowerDNS Instances**
For baseline zone:
```bash
sudo /usr/sbin/pdns_server --config-dir=/etc/powerdns --config-name=pdns --daemon=no --guardian=no &
sudo /usr/sbin/pdns_server --config-dir=/etc/powerdns --config-name=pdns-dilithium --daemon=no --guardian=no &
sudo /usr/sbin/pdns_server --config-dir=/etc/powerdns --config-name=pdns-falcon --daemon=no --guardian=no &
sudo /usr/sbin/pdns_server --config-dir=/etc/powerdns --config-name=pdns-sphincs --daemon=no --guardian=no &
```
Enable via systemd:
```bash
sudo systemctl daemon-reload
sudo systemctl enable pdns pdns-dilithium pdns-falcon pdns-sphincs
sudo systemctl start pdns pdns-dilithium pdns-falcon pdns-sphincs

```
Check:
```bash
sudo netstat -tulpn | grep 530
```

## 🧠 VM 103 – DNS Client Setup (No Resolver)

Hostname: iem-ubuntu-dns-client

IP Address: 14.194.176.204

Role: DNS Client querying PQC-enabled PowerDNS server directly

Server: 14.194.176.205

## Phase 1 – Install DNS Client Tools**
```bash
sudo apt update
sudo apt install dnsutils -y
```
## Phase 2 – Network Verification**
```bash
ping 14.194.176.205
```
Ensure ports are open:
```bash
nc -zv 14.194.176.205 5300
nc -zv 14.194.176.205 5303
nc -zv 14.194.176.205 5304
nc -zv 14.194.176.205 5305
```
## Phase 3 - DNS Resolution Testing**
```bash
dig @14.194.176.205 -p 5305 dilithium.iem.local SOA
dig @14.194.176.205 -p 5304 falcon.iem.local SOA
dig @14.194.176.205 -p 5303 sphincs.iem.local SOA

dig @14.194.176.205 -p 5305 www.dilithium.iem.local A 
dig @14.194.176.205 -p 5304 www.falcon.iem.local A 
dig @14.194.176.205 -p 5303 www.sphincs.iem.local A
```
DNSSEC Response Validation
```bash
# Test each port for DNSSEC
for port in 5300 5303 5304 5305; do
  echo "Port $port:"
  case $port in
    5300) domain="iem.local" ;;
    5303) domain="sphincs.iem.local" ;;
    5304) domain="falcon.iem.local" ;;
    5305) domain="dilithium.iem.local" ;;
  esac
  dig @14.194.176.205 -p $port $domain SOA +dnssec +multiline
  echo ""
done
```
---

## 🧩 Implementation Phases

|    Phase    |                    Description                  |                                Status                              |
|-------------|-------------------------------------------------|--------------------------------------------------------------------|
| **Phase 1** | Install `liboqs` and `OQS-OpenSSL` PQC toolkits |                            ✅ Completed                            |
| **Phase 2** |     Generate simulated PQC keys (`.pem`)        |                            ✅ Completed                            |
| **Phase 3** |      MySQL database setup for PowerDNS          |  ⚙️ *Completed locally for `iem.local`; pending `.IN` delegation*  |
| **Phase 4** |    PowerDNS multi-instance configuration        | ⚙️ *Operational for local test zones; `.IN` extension in progress* |
| **Phase 5** |   Systemd service isolation and automation      |                            ✅ Completed                            |
| **Phase 6** |      PQC zone signing and verification          |                            ✅ Completed                            |
| **Phase 7** |      Latency & performance benchmarking         |                         ✅ Completed (local)                       |
| **Phase 8** |   Delegated `.IN` validation & IETF feedback    |                         ⏳ Planned (future phase)                  |

---

## 🌐 Local Testbed Configuration

| Port |          Domain       |  Algorithm |      Database    |        Description       |
|------|-----------------------|------------|------------------|--------------------------|
| 5300 |       `iem.local`     |  RSA/ECDSA |    `powerdns`    |   Baseline DNSSEC zone   |
| 5305 | `dilithium.iem.local` | Dilithium3 | `pdns_dilithium` |  PQC lattice-based zone  |
| 5304 |   `falcon.iem.local`  | Falcon512  |   `pdns_falcon`  | Compact lattice PQC zone |
| 5303 |   `sphincs.iem.local` |  SPHINCS+  |   `pdns_sphincs` |    Hash-based PQC zone   |

Each runs in isolation under its own PowerDNS instance and MySQL database, controlled through systemd.

---



