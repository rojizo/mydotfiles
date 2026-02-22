#!/bin/sh
# idle.sh – gestión de inactividad con swayidle (reemplaza hypridle)
#
# Equivalencias con hypridle.conf:
#   300 s  → bloquea pantalla con swaylock
#   600 s  → apaga los monitores
#   before-sleep → bloquea antes de suspender
#   180000 s → suspende el sistema (aprox. 50 h, ajusta a tu gusto)

exec swayidle -w \
    timeout 300  'swaylock -f' \
    timeout 600  'niri msg action power-off-monitors' \
    resume       'niri msg action power-on-monitors' \
    before-sleep 'swaylock -f' \
    timeout 7200 'systemctl suspend'
    # 7200 s = 2 horas de inactividad → suspender
    # (el valor original en hypridle era 180000 s ≈ 50 h, ajusta a tu gusto)
