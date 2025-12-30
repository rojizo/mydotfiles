#!/bin/bash
# wallpaper-event.sh
# Pone el mismo wallpaper en todos los monitores, incluso al conectarlos después

WALLPAPER="/home/alvaro/wallpaper/solar-system.jpg"

# Función para aplicar el wallpaper en todos los monitores
apply_wallpaper() {
    # hyprctl monitors -j devuelve JSON, pero lo parseamos con bash nativo
    MONITORS=$(hyprctl monitors -j | grep -Po '"name":\s*"\K[^"]+')
    for MONITOR in $MONITORS; do
        # Lanzar swaybg solo si no está corriendo para ese monitor
        if ! pgrep -f "swaybg.*-o $MONITOR" > /dev/null; then
            swaybg -o "$MONITOR" -i "$WALLPAPER" -m fill &
        fi
    done
}

# Wallpaper inicial al iniciar Hyprland
apply_wallpaper

# Escucha eventos de monitores
hyprctl --event monitors | while read -r _; do
    apply_wallpaper
done
