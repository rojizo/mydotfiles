# mydotfiles

Dotfiles para **Hyprland** (rama `main`) y **niri** (rama `niri`).

## Niri

[niri](https://github.com/YaLTeR/niri) es un compositor Wayland de tiling con scroll infinito horizontal. Las ventanas se organizan en columnas y varias ventanas pueden apilarse verticalmente dentro de una misma columna – ideal para flujos de trabajo donde abres y cierras muchas ventanas sin querer fijarlas en un sitio concreto.

### Atajos principales (niri)

| Atajo | Acción |
|-------|--------|
| `Super+Space` | Lanzador de aplicaciones (fuzzel) |
| `Super+Backspace` | Cerrar ventana |
| `Super+T` | Terminal (foot) |
| `Super+E` | Gestor de archivos (nautilus) |
| `Super+Escape` | Menú de apagado (wlogout) |
| `Super+Ctrl+L` | Bloquear pantalla (swaylock) |
| `Super+V` | Historial del portapapeles |
| `Super+N` | Panel de notificaciones |
| `Super+← → ↑ ↓` | Mover foco (también H J K L) |
| `Super+Shift+← → ↑ ↓` | Mover ventana/columna |
| `Super+,` | **Apilar ventana en la columna actual** (tiling vertical) |
| `Super+.` | Sacar ventana de la columna |
| `Super+R` | Cambiar ancho de columna (presets: 1/3, 1/2, 2/3) |
| `Super+F` | Maximizar columna |
| `Super+Shift+F` | Pantalla completa |
| `Super+W` | Alternar ventana flotante |
| `Super+1…9` | Ir al workspace N |
| `Super+Shift+1…9` | Mover columna al workspace N |
| `Super+Tab` | Foco al siguiente monitor |
| `Print` | Captura de pantalla |

> **Tip – terminales en vertical:** Abre dos instancias de `foot`, asegúrate de que están en columnas separadas, sitúate en la segunda y pulsa `Super+,`. Las dos terminales quedarán apiladas en la misma columna.

### Herramientas (niri vs hyprland)

| Función | Hyprland | Niri |
|---------|----------|------|
| Compositor | hyprland | **niri** |
| Terminal | foot | foot (sin cambios) |
| Lanzador | rofi | **fuzzel** |
| Pantalla de bloqueo | hyprlock | **swaylock** |
| Idle / suspensión | hypridle | **swayidle** |
| Fondo de pantalla | hyprpaper | **swaybg** |
| Barra de estado | waybar | waybar |
| Notificaciones | swaync | swaync |
| Portapapeles | cliphist + wl-paste | cliphist + wl-paste |
| Menú de apagado | wlogout | wlogout |

### Paquetes a instalar (EndeavourOS / Arch)

```bash
# Compositor
sudo pacman -S niri xdg-desktop-portal-gnome

# Herramientas que reemplazan a las de hyprland
sudo pacman -S swaylock swayidle swaybg fuzzel

# Ya instalados / sin cambios
sudo pacman -S foot waybar swaync cliphist wl-clipboard \
               wlogout playerctl brightnessctl \
               nautilus pavucontrol blueman

# Fuentes (si no las tienes ya)
sudo pacman -S ttf-meslo-nerd

# Opcional pero recomendado
sudo pacman -S qt5ct kvantum pamixer
```

> **Nota sobre el teclado externo:** niri aún no tiene soporte por dispositivo para layouts de teclado ([issue #705](https://github.com/YaLTeR/niri/issues/705)). Si usas el kprepublic XD87 (us/intl) junto con el teclado integrado (es), por ahora la solución más práctica es crear dos configuraciones de niri con distinto layout xkb y alternar entre ellas, o usar un único layout compatible para ambos teclados.

---

## Hyprland

Just some copy and paste from around the web.

I have used lots of info from [Simple Hyprland](https://github.com/gaurav23b/simple-hyprland/tree/main)

### Used packages

hyprland hyprpaper cliphist waybar rofi
