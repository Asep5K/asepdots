#!/usr/bin/env python3

import sys
sys.dont_write_bytecode = True
import os, time, json, shutil
import psutil, subprocess, concurrent.futures
from pathlib import Path
from iuno import ICONS, kill
# -------------------- Konfigurasi --------------------
theme = str(Path.home() / ".config/rofi/themes/power_menu.rasi")

daemons = ("waybar", "swww-daemon", "wl-paste", "hyprland-dialog", "ssh-agent", "hypridle")
apps = ("code-oss", "brave", "footclient", "Telegram", "spotify", "electron", "yazi", "hyprland-dialog")

# -------------------- Utility --------------------
def run(cmd, **kwargs):
    return subprocess.run(cmd, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kwargs)

def notify(title, msg):
    run(["notify-send", "-i", ICONS, title, msg])

def is_running(name: str) -> bool:
    """Cek apakah proses dengan nama tertentu masih berjalan."""
    for proc in psutil.process_iter(["name", "cmdline"]):
        try:
            if name in (proc.info["name"] or "") or name in " ".join(proc.info["cmdline"] or []):
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied):
            continue
    return False

def ensure_killed(name: str, use_f: bool = False, retries: int = 5, delay: float = 0.5) -> bool:
    """Pastikan proses benar-benar mati (ulang pkill beberapa kali)."""
    flag = "-f" if use_f else "-x"
    for _ in range(retries):
        run(["pkill", flag, name])
        time.sleep(delay)
        if not is_running(name):
            return True
    return False  # masih hidup setelah retries

def parallel_kill(names, use_f=False):
    """Kill beberapa proses parallel, tanpa SIGKILL."""
    results = {}
    with concurrent.futures.ThreadPoolExecutor() as executor:
        future_to_name = {executor.submit(ensure_killed, n, use_f): n for n in names}
        for future in concurrent.futures.as_completed(future_to_name):
            name = future_to_name[future]
            results[name] = future.result()
    return results

# -------------------- Fungsi utama --------------------
def rofi_kill():
    run(["pkill", "-x", "rofi"], check=False)

def kill_apps():
    results = parallel_kill(apps, use_f=False)
    for app, killed in results.items():
        if not killed:
            notify("power controls", f"App {app} masih hidup!")

def kill_daemons():
    results = parallel_kill(daemons, use_f=True)
    for d, killed in results.items():
        if not killed:
            notify("power controls", f"Daemon {d} masih hidup!")

def get_window_count(class_name: str) -> int:
    result = run(["hyprctl", "clients"]).stdout
    return result.count(f"class: {class_name}")

def confirm(prompt: str) -> bool:
    result = run([
        "rofi", "-dmenu", "-p", prompt, "-theme", theme
    ], input=" Yes\n No")
    return "Yes" in result.stdout

# -------------------- Power Actions --------------------
def close_windows():
    kill_apps()

    subprocess.run(["swww", "clear-cache"])

    # time.sleep(3)
    # Tutup semua window Hyprland
    tmp = Path("/tmp/hypr")
    tmp.mkdir(parents=True, exist_ok=True)
    clients_json = json.loads(run(["hyprctl", "-j", "clients"]).stdout or "[]")
    commands = "".join([f"dispatch closewindow address:{c['address']}; " for c in clients_json])
    run(["hyprctl", "--batch", commands])
    notify("power controls", "Closing Applications...")

    kill_daemons()
    time.sleep(1)

    # Pastikan semua window udah gak ada
    count = run(["hyprctl", "clients"]).stdout.count("class:")
    if count == 0:
        notify("power controls", "Closed Applications.")
    else:
        notify("power controls", "Beberapa app masih hidup. Tidak shutdown/reboot.")
        exit(1)

def lock():
    if not is_running("hypridle"):
        subprocess.Popen(["hypridle"])
    run(["loginctl", "lock-session"])

def poweroff():
    if confirm("Shutdown?"):
        close_windows()
        run(["systemctl", "poweroff"])

def reboot():
    if confirm("Reboot?"):
        close_windows()
        run(["systemctl", "reboot"])

def logout():
    if confirm("Logout?"):
        kill_daemons()
        kill_apps()
        run(["hyprctl", "dispatch", "exit", "0"])

def suspend():
    lock()
    run(["systemctl", "suspend"])

def screen_off():
    kill(name="hypridle")
    subprocess.Popen(["hypridle", "-c", str(Path.home()/".config/hypr/hyproff.conf")])


# -------------------- Menu --------------------
def main():
    rofi_kill()
    options = " Shutdown\n Reboot\n Lock\n Sleep\n Screen Off\n Logout"
    result = run(["rofi", "-dmenu", "-p", "====== POWER MENU ======", "-theme", theme],
                 input=options).stdout.strip()

    actions = {
        " Shutdown": poweroff,
        " Reboot": reboot,
        " Lock": lock,
        " Sleep": suspend,
        " Screen Off": screen_off,
        " Logout": logout
    }

    if result in actions:
        actions[result]()
    elif result:
        notify("Running command", result)
        run(["bash", "-c", result])
arg = sys.argv[1] if len(sys.argv) > 1 else None

# -------------------- Entry Point --------------------
if __name__ == "__main__":
    
    if arg == "shutdown":
        poweroff()
    elif arg == "reboot":
        reboot()
    elif arg == "lock":
        lock()
    elif arg == "sleep":
        suspend()
    elif arg == "screenoff":
        screen_off()
    elif arg == "logout":
        logout()
    else:
        main()
