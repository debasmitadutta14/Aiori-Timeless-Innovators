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

---

## 🧩 Implementation Phases

| Phase | Description | Status |
|--------|--------------|--------|
| **Phase 1** | Install `liboqs` and `OQS-OpenSSL` PQC toolkits | ✅ Completed |
| **Phase 2** | Generate simulated PQC keys (`.pem`) | ✅ Completed |
| **Phase 3** | MySQL database setup for PowerDNS | ⚙️ *Completed locally for `iem.local`; pending `.IN` delegation* |
| **Phase 4** | PowerDNS multi-instance configuration | ⚙️ *Operational for local test zones; `.IN` extension in progress* |
| **Phase 5** | Systemd service isolation and automation | ✅ Completed |
| **Phase 6** | PQC zone signing and verification | ✅ Completed |
| **Phase 7** | Latency & performance benchmarking | ✅ Completed (local) |
| **Phase 8** | Delegated `.IN` validation & IETF feedback | ⏳ Planned (future phase) |

---

## 🌐 Local Testbed Configuration

| Port | Domain | Algorithm | Database | Description |
|------|---------|------------|-----------|--------------|
| 5300 | `iem.local` | RSA/ECDSA | `powerdns` | Baseline DNSSEC zone |
| 5305 | `dilithium.iem.local` | Dilithium3 | `pdns_dilithium` | PQC lattice-based zone |
| 5304 | `falcon.iem.local` | Falcon512 | `pdns_falcon` | Compact lattice PQC zone |
| 5303 | `sphincs.iem.local` | SPHINCS+ | `pdns_sphincs` | Hash-based PQC zone |

Each runs in isolation under its own PowerDNS instance and MySQL database, controlled through systemd.

---

## 🧪 Verification & Testing

### 1. **DNSSEC Response Validation**
```bash
dig @14.194.176.205 -p 5300 iem.local SOA +dnssec
dig @14.194.176.205 -p 5305 dilithium.iem.local SOA +dnssec
dig @14.194.176.205 -p 5304 falcon.iem.local SOA +dnssec
dig @14.194.176.205 -p 5303 sphincs.iem.local SOA +dnssec
