#!/bin/bash
# Performance measurement script (as in PDF)
# This script performs simple repeated queries to measure response behaviour.

OUTPUT_DIR="/var/log/pqc-measurements"
mkdir -p "$OUTPUT_DIR"

# Baseline test (unsigned)
echo "=== Baseline (unsigned) test on port 5300 ===" | tee "$OUTPUT_DIR/baseline.log"
for i in {1..100}; do
  dig @14.194.176.205 -p 5300 iem.local A +noedns +time=2 >> "$OUTPUT_DIR/baseline.log"
done

# DNSSEC test (signed)
echo "=== DNSSEC test on port 5300 (with +dnssec) ===" | tee "$OUTPUT_DIR/dnssec.log"
for i in {1..100}; do
  dig @14.194.176.205 -p 5300 iem.local A +dnssec +time=2 >> "$OUTPUT_DIR/dnssec.log"
done

# Algorithm-specific testing (ports 5303,5304,5305)
for port in 5303 5304 5305; do
    case $port in
       5303) domain="sphincs.iem.local" ;;
       5304) domain="falcon.iem.local" ;;
       5305) domain="dilithium.iem.local" ;;
    esac
    echo "=== Testing port $port (domain $domain) ===" | tee "$OUTPUT_DIR/port_$port.log"
    for i in {1..100}; do
      dig @14.194.176.205 -p $port $domain A +dnssec +time=2 >> "$OUTPUT_DIR/port_$port.log"
    done
done

echo "Measurements completed. Logs in $OUTPUT_DIR"
