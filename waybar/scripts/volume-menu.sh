#!/bin/bash
# volume-menu.sh – controles rápidos de volumen usando fuzzel + pamixer

sink_vol=$(pamixer --get-volume 2>/dev/null || echo 0)
sink_mute=$(pamixer --get-mute 2>/dev/null || echo false)
src_vol=$(pamixer --default-source --get-volume 2>/dev/null || echo 0)
src_mute=$(pamixer --default-source --get-mute 2>/dev/null || echo false)

if [ "$sink_mute" = "true" ]; then
    spk_label="󰝟  Altavoz: SILENCIADO"
else
    spk_label="󰕾  Altavoz: ${sink_vol}%"
fi

if [ "$src_mute" = "true" ]; then
    mic_label="  Micro: SILENCIADO"
else
    mic_label="  Micro: ${src_vol}%"
fi

separator="──────────────────"
opt_up="  Subir volumen (+10%)"
opt_down="  Bajar volumen (-10%)"
opt_mute_spk="󰝟  Silenciar/activar altavoz"
opt_mute_mic="  Silenciar/activar micrófono"
opt_adv="  Configuración avanzada (pavucontrol)"

menu=$(printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n' \
    "$spk_label" "$mic_label" "$separator" \
    "$opt_up" "$opt_down" "$opt_mute_spk" "$opt_mute_mic" "$opt_adv")

chosen=$(printf '%s' "$menu" | fuzzel --dmenu -p " Volumen ")
[ -z "$chosen" ] && exit 0

case "$chosen" in
    "$opt_up")       pamixer -i 10 ;;
    "$opt_down")     pamixer -d 10 ;;
    "$opt_mute_spk") pamixer -t ;;
    "$opt_mute_mic") pamixer --default-source -t ;;
    "$opt_adv")      pavucontrol & ;;
esac
