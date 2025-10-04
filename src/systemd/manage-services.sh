#!/bin/bash
# Manage all PowerDNS services

ACTION=$1

if [ -z "$ACTION" ]; then
    echo "Usage: $0 {start|stop|restart|status|enable|disable}"
    exit 1
fi

SERVICES="pdns pdns-dilithium pdns-falcon pdns-sphincs"

case "$ACTION" in
    start|stop|restart|status|enable|disable)
        for service in $SERVICES; do
            echo "=== $ACTION $service ==="
            sudo systemctl $ACTION $service
            echo ""
        done
        ;;
    *)
        echo "Invalid action: $ACTION"
        echo "Usage: $0 {start|stop|restart|status|enable|disable}"
        exit 1
        ;;
esac
