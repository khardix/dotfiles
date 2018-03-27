#!/usr/bin/zsh

killall -q polybar; while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

readonly primary_monitor="$(xrandr -q|grep -w 'primary'|awk '{print $1}')"
readonly monitor_count=$(xrandr -q|grep -w 'connected'|wc -l)

export PRIMARY_MONITOR=${primary_monitor:-eDP-1-1}
export ETH="$(basename /sys/class/net/en*(onY1))"  # first ethernet device
export WLN="$(basename /sys/class/net/wl*(onY1))"  # first wifi device

if [[ "$monitor_count" -gt 1 ]]; then
    polybar center &!
    polybar left &!
    polybar right &!
else
    polybar single &!
fi
