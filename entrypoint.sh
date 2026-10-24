#!/bin/bash
set -e

cd /vpn
openvpn --config /vpn/client.ovpn &
OVPN_PID=$!

for i in $(seq 1 60); do
  ip addr show tun0 2>/dev/null | grep -q "inet " && break
  sleep 1
done

if ! ip addr show tun0 2>/dev/null | grep -q "inet "; then
  echo "tun0 не поднялся, проверь логи OpenVPN" >&2
  exit 1
fi

sockd -f /etc/danted.conf &

wait -n
exit 1

