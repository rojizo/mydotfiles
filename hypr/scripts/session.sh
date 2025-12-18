#!/bin/sh

hyprpm reload

sleep 0.5

MONITOR_COUNT=$(hyprctl monitors | grep -c "Monitor")

if [ "$MONITOR_COUNT" -gt 1 ]; then
    for CURRENT_ID in $(seq 0 $((MONITOR_COUNT - 1))); do
        hyprctl dispatch focusmonitor $CURRENT_ID
        hyprctl dispatch split-workspace 1
    done
fi

hyprctl dispatch focusmonitor 0

sleep 0.5

# Cargamos la sesión anterior
uwsm app -- hyprsession

