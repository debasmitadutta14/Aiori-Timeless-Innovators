#!/bin/bash
# Baseline performance test (unsigned)

echo "=== Baseline Performance Test (Unsigned) ==="

ITERATIONS=1000
PORT=5300
DOMAIN="iem.local"

echo "Running $ITERATIONS queries to port $PORT..."
start_time=$(date +%s%N)

for i in $(seq 1 $ITERATIONS); do
    dig @14.194.176.205 -p $PORT $DOMAIN A +noedns > /dev/null 2>&1
done

end_time=$(date +%s%N)
elapsed=$((($end_time - $start_time) / 1000000))

echo "Baseline test complete!"
echo "Total time: ${elapsed}ms"
echo "Average time per query: $((elapsed / ITERATIONS))ms"
