#!/bin/sh
# Idle / lock — reemplaza hypridle para niri
# Apaga pantalla a los 5 min, bloquea a los 10 min, suspende a los 30 min.

exec swayidle -w \
    timeout 300  'brightnessctl -s set 10' \
         resume  'brightnessctl -r' \
    timeout 600  'swaylock -f' \
    timeout 1800 'systemctl suspend' \
    before-sleep 'swaylock -f'
