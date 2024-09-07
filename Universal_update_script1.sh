#!/bin/bash

echo "===========================================
        Welcome to the Update Script        
============================================
 This script is designed to automatically    
 update your system by detecting and using  
 the appropriate package manager (APT, YUM, 
 DNF, or Pacman). It also updates Flatpak   
 and Snap packages if installed.            
--------------------------------------------
       Keep your system up-to-date easily!  
============================================"

# record starting time
start_time=$(date +%s)

# 检查并更新APT系统
update_apt() {
    echo "Updating APT packages..."
    sudo apt update && sudo apt dist-upgrade -y
    sudo apt autoremove -y
    sudo apt clean
}

# check YUM
update_yum() {
    echo "Updating YUM packages..."
    sudo yum update -y
    sudo yum autoremove -y
    sudo yum clean all
}

# check DNF
update_dnf() {
    echo "Updating DNF packages..."
    sudo dnf update -y
    sudo dnf autoremove -y
    sudo dnf clean all
}

# check Pacman
update_pacman() {
    echo "Updating Pacman packages..."
    sudo pacman -Syu --noconfirm
    sudo pacman -Sc --noconfirm
}

# check Flatpak
update_flatpak() {
    if command -v flatpak &> /dev/null; then
        echo "Updating Flatpak packages..."
        flatpak update -y
    fi
}

# check Snap
update_snap() {
    if command -v snap &> /dev/null; then
        echo "Updating Snap packages..."
        sudo snap refresh
    fi
}

# detect package manager
if command -v apt &> /dev/null; then
    update_apt
elif command -v yum &> /dev/null; then
    update_yum
elif command -v dnf &> /dev/null; then
    update_dnf
elif command -v pacman &> /dev/null; then
    update_pacman
else
    echo "Unknown package manager. Please update manually."
    exit 1
fi

# update Flatpak & Snap
update_flatpak
update_snap

# record ending time
end_time=$(date +%s)

# cauculate elapesd
elapsed_time=$((end_time - start_time))

# formate time record
formatted_time=$(printf '%02d:%02d:%02d' $((elapsed_time / 3600)) $(((elapsed_time % 3600) / 60)) $((elapsed_time % 60)))

echo "============================================"
echo "         System update completed!           "
echo "============================================"
echo "Elapsed Time: $formatted_time"
echo "============================================"
