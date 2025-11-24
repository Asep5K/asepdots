import sys
sys.dont_write_bytecode = True
from pathlib import Path
import subprocess

ICONS = str(Path.home()/".local/share/profiles/Iuno.webp")

# -------------------- Utility Functions --------------------
def kill(name: str):
    try:
        subprocess.run(["pkill", "-x", name], check=False)
    except Exception:
        pass
        notify("IUNO", "stop", str(e))

def restart_waybar():
    """Restart waybar cuma kalau lagi jalan."""
    process_name = "waybar"
    
    # cek apakah waybar lagi jalan
    waybar_running = any(proc.info["name"] == process_name for proc in psutil.process_iter(["name"]))
    
    if waybar_running:
        try:
            kill(name=process_name)  # hentikan waybar
            subprocess.Popen([process_name])  # jalankan ulang
        except Exception:
            pass
    else:
        print("Waybar tidak sedang berjalan, tidak di-restart.")

def notify(title: str, exc: str, message: str):
    subprocess.run(["notify-send", "-i", str(ICONS), "-a", exc, title, message])

def reload_hyprctl():
    subprocess.run(["hyprctl", "reload"])