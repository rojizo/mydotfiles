#!/bin/bash
# led_control.sh - controla la retroiluminación de teclado o pantalla
# Uso: led_control.sh up   → sube brillo
#       led_control.sh down → baja brillo

BRIGHTNESSCTL="/usr/bin/brightnessctl"

# Comprobar argumento
if [ "$1" != "up" ] && [ "$1" != "down" ]; then
    echo "Uso: $0 up|down"
    exit 1
fi

# Detectar dispositivo
if [ -e /sys/class/leds/smc::kbd_backlight ]; then
    DEVICE="smc::kbd_backlight"
    STEP="+25"
    STEP_DOWN="25-"
elif [ -e /sys/class/backlight/intel_backlight ]; then
    DEVICE="intel_backlight"
    STEP="+10%"
    STEP_DOWN="10%-"
else
    echo "No se detectó LED compatible"
    exit 1
fi

# Ejecutar comando según argumento
if [ "$1" = "up" ]; then
    $BRIGHTNESSCTL --device="$DEVICE" s $STEP
else
    $BRIGHTNESSCTL --device="$DEVICE" s $STEP_DOWN
fi
