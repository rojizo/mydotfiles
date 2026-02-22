#!/bin/bash
# network-menu.sh – selector de red WiFi usando fuzzel + nmcli

# Actualizar lista de redes (sin bloquear)
nmcli device wifi rescan 2>/dev/null &

# Construir lista de redes disponibles (sin duplicados, ordenadas por señal)
wifi_list=$(nmcli -t -f SSID,SIGNAL,IN-USE device wifi list --rescan no 2>/dev/null | \
    awk -F: '!seen[$1]++ && $1 != "" {
        if ($3 == "*") printf "● %s (%s%%)\n", $1, $2
        else           printf "○ %s (%s%%)\n", $1, $2
    }')

# Opciones extra
separator="──────────────────"
opt_on="󰖩  Activar WiFi"
opt_off="󰖪  Desactivar WiFi"
opt_adv="  Ajustes avanzados (nmtui)"

menu=$(printf '%s\n%s\n%s\n%s\n%s' "$wifi_list" "$separator" "$opt_on" "$opt_off" "$opt_adv")
chosen=$(printf '%s\n' "$menu" | fuzzel --dmenu -p "WiFi  ")
[ -z "$chosen" ] && exit 0

case "$chosen" in
    "$opt_on")  nmcli radio wifi on ;;
    "$opt_off") nmcli radio wifi off ;;
    "$opt_adv") foot -- nmtui & ;;
    "$separator") exit 0 ;;
    *)
        # Extraer SSID (quitar indicador ● / ○ y señal al final)
        ssid=$(printf '%s' "$chosen" | sed -e 's/^[●○] //' -e 's/ ([0-9]*%)$//')
        if ! nmcli device wifi connect "$ssid" 2>/dev/null; then
            # Si falla (p.ej. red nueva que requiere contraseña), abrir nmtui
            foot -- nmtui &
        fi
        ;;
esac
