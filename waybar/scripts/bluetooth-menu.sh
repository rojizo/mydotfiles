#!/bin/bash
# bluetooth-menu.sh – gestor de Bluetooth usando fuzzel + bluetoothctl

bt_powered=$(bluetoothctl show 2>/dev/null | awk '/Powered:/{print $2}')

if [ "$bt_powered" != "yes" ]; then
    chosen=$(printf '󰂯  Activar Bluetooth\n' | fuzzel --dmenu -p "󰂲 Bluetooth ")
    [ "$chosen" = "󰂯  Activar Bluetooth" ] && bluetoothctl power on
    exit 0
fi

# Construir lista de dispositivos emparejados con su estado de conexión
device_entries=""
while IFS= read -r line; do
    mac=$(printf '%s' "$line" | awk '{print $2}')
    name=$(printf '%s' "$line" | cut -d' ' -f3-)
    if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
        device_entries+="󰂱  $name (conectado)\n"
    else
        device_entries+="󰂯  $name\n"
    fi
done < <(bluetoothctl devices 2>/dev/null)

separator="──────────────────"
opt_off="󰂲  Desactivar Bluetooth"
opt_scan="  Buscar dispositivos nuevos"

menu=$(printf '%b%s\n%s\n%s\n' "$device_entries" "$separator" "$opt_off" "$opt_scan")
chosen=$(printf '%s\n' "$menu" | fuzzel --dmenu -p "󰂯 Bluetooth ")
[ -z "$chosen" ] && exit 0

case "$chosen" in
    "$opt_off")  bluetoothctl power off ;;
    "$opt_scan") foot -- sh -c 'bluetoothctl scan on' & ;;
    "$separator") exit 0 ;;
    *"(conectado)"*)
        # Desconectar dispositivo activo
        name=$(printf '%s' "$chosen" | sed 's/^󰂱  //' | sed 's/ (conectado)$//')
        mac=$(bluetoothctl devices 2>/dev/null | awk -v n="$name" '{nm=""; for(i=3;i<=NF;i++) nm=(nm ? nm" ":"")"" $i; if(nm==n){print $2; exit}}')
        [ -n "$mac" ] && bluetoothctl disconnect "$mac"
        ;;
    "󰂯  "*)
        # Conectar dispositivo emparejado
        name=$(printf '%s' "$chosen" | sed 's/^󰂯  //')
        mac=$(bluetoothctl devices 2>/dev/null | awk -v n="$name" '{nm=""; for(i=3;i<=NF;i++) nm=(nm ? nm" ":"")"" $i; if(nm==n){print $2; exit}}')
        [ -n "$mac" ] && bluetoothctl connect "$mac"
        ;;
esac
