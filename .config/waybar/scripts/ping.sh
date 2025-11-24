#!/usr/bin/env bash

# Ubah host di sini kalo mau (misal 8.8.8.8 atau google.com)
HOST="8.8.8.8"
# HOST=$(hostname -i)

# Ping 1x, timeout 1 detik, lalu ambil latency-nya
ping_time=$(ping -c 1 -W 1 $HOST | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')

if [[ -n "$ping_time" ]]; then
    echo "Ping: $ping_time ms"
else
    echo "No connection"
fi
