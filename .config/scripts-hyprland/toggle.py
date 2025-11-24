#!/usr/bin/env python3

"""
Script toggle aplikasi sederhana.
Kalau aplikasi belum jalan → dijalankan.
Kalau aplikasi sudah jalan → dihentikan.
Dilengkapi notifikasi desktop (notify-send).
"""

import sys
sys.dont_write_bytecode = True
import os
import subprocess
from datetime import datetime 
from pathlib import Path
from zoneinfo import ZoneInfo
from iuno import ICONS, kill

# ----------------------------------------------------
# Konfigurasi
# ----------------------------------------------------

# ----------------------------------------------------
# Fungsi utilitas
# ----------------------------------------------------

def notify(title: str, exc: str ,message: str):
    """
    Kirim notifikasi desktop menggunakan `notify-send`.

    Args:
        title (str): Judul notifikasi
        message (str): Isi pesan notifikasi
    """
    subprocess.run(["notify-send", "-i", str(ICONS), "-a", exc, title, message])


def toggle_app(app_name: str):
    """
    Toggle aplikasi berdasarkan nama proses.

    Jika aplikasi tidak berjalan → dijalankan.
    Jika aplikasi sudah berjalan → dihentikan.

    Args:
        app_name (str): Nama executable aplikasi (harus persis dengan hasil `pgrep -x`)
    """
    # Cek apakah proses sedang berjalan
    running = subprocess.run(
        ["pgrep", "-x", app_name],
        stdout=subprocess.DEVNULL
    ).returncode == 0

    if not running:
        # Jalankan aplikasi (tanpa output di terminal)
        try:
            subprocess.Popen(
                [app_name],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )
            notify("DAEMON MANAGER", "run", f"{app_name} successfully activated ✔")
        except Exception as e:
            notify("DAEMON MANAGER", "stop", str(e))
    else:
        # Hentikan proses aplikasi
        try:
            kill(name=app_name)
            # subprocess.run(["pkill", "-x", app_name])
            notify("DAEMON MANAGER", "stop", f"{app_name} successfully killed 💀😹")
        except Exception as e:
            notify("DAEMON MANAGER", "stop", str(e))

def toggle_time():
    time = datetime.now(ZoneInfo("Asia/Jakarta")).strftime("DATE:%d:%m:%Y\nTIME:%H:%M %Z")
    notify("DATE & TIME", "run", time)
# -------------------- Bagian utama --------------------

if __name__ == "__main__":
    # Pastikan pengguna memberikan argumen aplikasi
    kill(name="mako")
    if len(sys.argv) < 2:
        print("Usage: toggle.py <app_name>")
        sys.exit(1)

    app_name = sys.argv[1]
    if app_name == "time":
        toggle_time()
    else:
        toggle_app(app_name)
