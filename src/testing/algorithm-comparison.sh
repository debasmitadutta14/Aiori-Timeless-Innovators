#!/bin/bash
# Compare performance across all algorithm ports

echo "=== Algorithm Performance Comparison ==="

ITERATIONS=100

declare -A PORTS
PORTS[5300]="Traditional"
PORTS[5305]="Dilithium3"
PORTS[5304]="Falcon512"
PORTS[5303]="SPHINCS+"

declare -A DOMAINS
DOMAINS[5300]="iem.local"
DOMAINS[5305]="dilithium.iem.local"
DOMAINS[5304]="falcon.iem.local"
DOMAINS[5303]="sphincs.iem.local"

echo "Running $ITERATIONS queries per port..."
echo ""

for port in 5300 5305 5304 5303; do
    algorithm=${PORTS[$port]}
    domain=${DOMAINS[$port]}
    
    echo "Testing $algorithm (Port $port)..."
    
    start_time=$(date +%s%N)
    for i in $(seq 1 $ITERATIONS); do
        dig @14.194.176.205 -p $port $domain A +dnssec > /dev/null 2>&1
    done
    end_time=$(date +%s%N)
    
    elapsed=$((($end_time - $start_time) / 1000000))
    avg=$((elapsed / ITERATIONS))
    
    echo "  Total time: ${elapsed}ms"
    echo "  Average per query: ${avg}ms"
    echo ""
done
