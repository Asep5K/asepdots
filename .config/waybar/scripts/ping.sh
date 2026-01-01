#!/usr/bin/env bash


hape="$(arp -a | awk -F '[()]' '{print $2}')"
# Ubah host di sini kalo mau (misal 8.8.8.8 atau google.com)
# if [ -n "$hape" ]; then
    # HOST="$hape"
# else
    HOST="8.8.8.8"
# fi

# Ping 1x, timeout 1 detik, lalu ambil latency-nya
ping_time="$(ping -c 1 -W 1 "$HOST" | awk -F 'time=' 'NF>1{print $2}')"

if [[ -n "$ping_time" ]]; then
    echo "Ping: $ping_time"
else
    echo "No connection"
fi
