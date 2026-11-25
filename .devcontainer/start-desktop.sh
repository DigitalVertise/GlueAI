#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="${HOME}/.codespaces-desktop"
mkdir -p "$LOG_DIR"

if pgrep -x Xvfb >/dev/null && pgrep -f "websockify.*6080" >/dev/null; then
  echo "Linux desktop services already appear to be running."
  exit 0
fi

pkill -x Xvfb 2>/dev/null || true
pkill -x x11vnc 2>/dev/null || true
pkill -f "websockify.*6080" 2>/dev/null || true

Xvfb :0 -screen 0 1600x900x24 -ac +extension RANDR >"$LOG_DIR/xvfb.log" 2>&1 &
sleep 2

dbus-launch --exit-with-session startxfce4 >"$LOG_DIR/xfce.log" 2>&1 &
sleep 4

x11vnc -display :0 -forever -shared -localhost -nopw -rfbport 5900 >"$LOG_DIR/x11vnc.log" 2>&1 &
sleep 2

websockify --web=/usr/share/novnc 6080 localhost:5900 >"$LOG_DIR/novnc.log" 2>&1 &

echo "Desktop started. Open the private forwarded port 6080 and choose Connect."
