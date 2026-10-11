#!/bin/bash

set -e

echo "=========================================="
echo " Instalando Configuración Personalizada ML4W"
echo "=========================================="

# 1. Actualizar el sistema e instalar paquetes base necesarios
echo "[+] Instalando dependencias base con pacman..."
sudo pacman -Syu --needed --noconfirm \
    git \
    hyprland \
    waybar \
    rofi-wayland \
    swaync \
    hyprpaper \
    hypridle \
    hyprlock \
    power-profiles-daemon \
    pavucontrol \
    playerctl \
    alacritty \
    kitty \
    qalculate-gtk

# 2. Respaldar configuración de Hyprland previa si existe
if [ -d "$HOME/.config/hypr" ] && [ ! -d "$HOME/.config/hypr/.git" ]; then
    echo "[+] Respaldando configuración anterior en ~/.config/hypr_backup..."
    mv "$HOME/.config/hypr" "$HOME/.config/hypr_backup_$(date +%Y%m%d_%H%M%S)"
fi

# 3. Descargar tus dotfiles personalizados desde GitHub
if [ ! -d "$HOME/.config/hypr/.git" ]; then
    echo "[+] Clonando repositorio desde GitHub..."
    git clone https://github.com/fuentes17/hyprland-ml4w-linux.git "$HOME/.config/hypr"
fi

# 4. Habilitar servicios de sistema esenciales
echo "[+] Activando servicios del sistema..."
sudo systemctl enable --now power-profiles-daemon.service

# 5. Otorgar permisos de ejecución a los scripts
echo "[+] Permisos de ejecución configurados."
chmod +x $HOME/.config/hypr/scripts/* 2>/dev/null || true

echo "=========================================="
echo " ¡Instalación completada con éxito!"
echo " Reinicia el sistema o inicia sesión en Hyprland."
echo "=========================================="
