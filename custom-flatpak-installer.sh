#!/bin/bash

# --- Flatpak Batch Installer ---
# This script iterates through a list of Flatpak application IDs and installs them one by one.
# It installs them for the current user.
# If an application is already installed, it will be skipped, and the script will continue.

# --- TUI Setup ---
# Set up colors and styles for a richer terminal output.
bold=$(tput bold)
blue=$(tput setaf 4)
green=$(tput setaf 2)
red=$(tput setaf 1) # Retained for potential future error messages
reset=$(tput sgr0)

# Create a divider line that spans the width of the terminal.
width=$(tput cols 2>/dev/null || echo 80) # Default to 80 cols if tput fails
divider_char="─"
divider=""
for ((i=0; i<width; i++)); do
    divider="$divider$divider_char"
done

# List of Flatpak applications to install. You can add or remove IDs from this list.
FLATPAKS_TO_INSTALL="com.bitwarden.desktop \
com.dec05eba.gpu_screen_recorder \
com.github.ADBeveridge.Raider \
com.github.Matoking.protontricks \
com.github.huluti.Curtail \
com.github.marhkb.Pods \
com.github.marktext.marktext \
com.github.mtkennerly.ludusavi \
com.github.rafostar.Clapper \
com.github.sdv43.whaler \
com.heroicgameslauncher.hgl \
com.mattjakeman.ExtensionManager \
com.obsproject.Studio \
com.rafaelmardojai.Blanket \
com.saivert.pwvucontrol \
com.steamgriddb.SGDBoop \
com.steamgriddb.steam-rom-manager \
com.termius.Termius \
com.usebottles.bottles \
com.valvesoftware.Steam \
com.vixalien.sticky \
com.vysp3r.ProtonPlus \
de.haeckerfelix.Fragments \
de.nicokimmel.shadowcast-electron \
dev.fredol.open-tv \
dev.lizardbyte.app.Sunshine \
io.github.ellie_commons.jorts \
io.github.fastrizwaan.WineCharm \
io.github.fastrizwaan.WineZGUI \
io.github.giantpinkrobots.varia \
io.github.nokse22.Exhibit \
io.github.realmazharhussain.GdmSettings \
io.github.ryubing.Ryujinx \
io.github.shiftey.Desktop \
io.github.zaedus.spider \
io.gitlab.adhami3310.Converter \
io.gitlab.librewolf-community \
io.kapsa.drive \
it.mijorus.gearlever \
net.davidotek.pupgui2 \
net.lutris.Lutris \
net.nokyan.Resources \
net.pcsx2.PCSX2 \
net.rpcs3.RPCS3 \
net.shadps4.shadPS4 \
nl.g4d.Girens \
org.DolphinEmu.dolphin-emu \
org.cryptomator.Cryptomator \
org.duckstation.DuckStation \
org.gnome.Calculator \
org.gnome.Calendar \
org.gnome.Characters \
org.gnome.Connections \
org.gnome.Contacts \
org.gnome.DejaDup \
org.gnome.Firmware \
org.gnome.Fractal \
org.gnome.GHex \
org.gnome.Geary \
org.gnome.Logs \
org.gnome.Loupe \
org.gnome.Maps \
org.gnome.NautilusPreviewer \
org.gnome.Papers \
org.gnome.SimpleScan \
org.gnome.TextEditor \
org.gnome.Weather \
org.gnome.World.PikaBackup \
org.gnome.baobab \
org.gnome.clocks \
org.gnome.font-viewer \
org.gnome.gitlab.somas.Apostrophe \
org.jdownloader.JDownloader \
org.mozilla.Thunderbird \
org.onlyoffice.desktopeditors \
org.videolan.VLC \
org.virt_manager.virt-manager \
org.winehq.Wine \
page.codeberg.libre_menu_editor.LibreMenuEditor \
page.tesk.Refine \
so.libdb.dissent"

# Convert the string of apps to an array to easily get the total count.
read -ra FLATPAK_ARRAY <<< "$FLATPAKS_TO_INSTALL"
total=${#FLATPAK_ARRAY[@]}
current=0

# Loop through each application ID in the list defined above.
for flatpak_app in "${FLATPAK_ARRAY[@]}"; do
  current=$((current + 1))
  progress="[${current}/${total}]"
  
  # --- TUI Header for each package ---
  echo ""
  echo "${blue}${bold}${divider}${reset}"
  echo "${blue}${bold}📦 Attempting to install for user: ${green}${flatpak_app} ${blue}(${progress})${reset}"
  echo "${blue}${bold}${divider}${reset}"
  
  # The 'flatpak install' command will check if the app is already installed.
  # The --user flag ensures it is installed for the current user. Flatpak defaults to user, but this makes it explicit.
  # The '-y' flag automatically confirms any prompts.
  flatpak install --user -y flathub "$flatpak_app"
done

echo ""
echo "${green}${bold}${divider}${reset}"
echo "${green}${bold}✅ All user installations attempted. Script finished.${reset}"
echo "${green}${bold}${divider}${reset}"
