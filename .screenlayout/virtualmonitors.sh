#!/bin/sh
set -eu
LOG="$HOME/.local/share/xrandr-virtual.log"
mkdir -p "$(dirname "$LOG")"
# log everything
{
  echo "=== $(date) ==="
  echo "[0] xrandr --query:"
  xrandr --query

  # If both HDMI-0 and DP-2 are connected at 2560-wide, likely PBP still on
  if xrandr --query | grep -q '^HDMI-0 connected .*2560x1440' && \
     xrandr --query | grep -q '^DP-2 connected .*2560x1440' ; then
    echo "PBP/PIP appears ON (two 2560x1440 inputs). Aborting split."
    exit 1
  fi

  echo "[1] Forcing HDMI-0 off"
  xrandr --output HDMI-0 --off || true

  echo "[2] Set DP-2 5120x1440@240"
  xrandr --output DP-0 --mode 5120x1440 --rate 240 --primary --pos 0x0 || true
  sleep 0.2
  xrandr --output DP-0 --mode 5120x1440 --rate 240 --primary --pos 0x0

  echo "[3] Check dimensions (xdpyinfo):"
  xdpyinfo | grep -E 'dimensions|resolution' || true

  if [ "$(xdpyinfo | awk '/dimensions:/{print $2}')" != "5120x1440" ]; then
    echo "Did not reach 5120x1440; bailing before virtual split."
    exit 1
  fi

  echo "[4] Delete prior monitor-objects"
  xrandr --delmonitor LEFT  2>/dev/null || true
  xrandr --delmonitor RIGHT 2>/dev/null || true

  echo "[5] Create LEFT/RIGHT"
  xrandr --setmonitor LEFT  2560/597x1440/336+0+0      DP-0
  xrandr --setmonitor RIGHT 2560/597x1440/336+2560+0   none

  echo "[6] listmonitors:"
  xrandr --listmonitors

  echo "[7] Xinerama heads:"
  # requires xorg-xdpyinfo (usually installed)
  xdpyinfo -ext XINERAMA 2>/dev/null | sed -n '1,120p' || true
} >>"$LOG" 2>&1
