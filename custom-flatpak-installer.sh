#!/bin/bash

# --- Flatpak Batch Installer ---
# This script iterates through a list of Flatpak application IDs and installs them one by one.
# It installs them system-wide, requiring root privileges.
# If an application is already installed, it will be skipped, and the script will continue.

# --- TUI Setup ---
# Set up colors and styles for a richer terminal output.
bold=$(tput bold)
blue=$(tput setaf 4)
green=$(tput setaf 2)
red=$(tput setaf 1)
reset=$(tput sgr0)

# --- Root Check ---
# System-wide installations require root privileges. This check ensures the script is run with sudo.
if [ "$EUID" -ne 0 ]; then
  echo "${red}${bold}Error: This script must be run as root (or with sudo) to perform system-wide installations.${reset}"
  exit 1
fi

# Create a divider line that spans the width of the terminal.
width=$(tput cols 2>/dev/null || echo 80) # Default to 80 cols if tput fails
divider_char="─"
divider=""
for ((i=0; i<width; i++)); do
    divider="$divider$divider_char"
done

# List of Flatpak applications to install. You can add or remove IDs from this list.
FLATPAKS_TO_INSTALL="com.usebottles.bottles \
com.valvesoftware.Steam \
com.obsproject.Studio \
com.github.tchx84.Flatseal \
com.mattjakeman.ExtensionManager \
net.davidotek.pupgui2 \
de.nicokimmel.shadowcast-electron \
org.DolphinEmu.dolphin-emu \
com.visualstudio.code \
org.onlyoffice.desktopeditors \
org.duckstation.DuckStation \
com.bitwarden.desktop \
io.gitlab.librewolf-community \
io.missioncenter.MissionCenter \
com.github.Matoking.protontricks \
it.mijorus.gearlever \
io.github.flattool.Warehouse \
com.vysp3r.ProtonPlus \
io.gitlab.adhami3310.Impression \
org.winehq.Wine \
io.github.flattool.Ignition \
com.github.PintaProject.Pinta \
net.pcsx2.PCSX2 \
net.nokyan.Resources \
org.jdownloader.JDownloader \
io.github.fastrizwaan.WineZGUI \
page.tesk.Refine \
com.github.mtkennerly.ludusavi \
nl.g4d.Girens \
net.rpcs3.RPCS3 \
io.github.shiftey.Desktop \
dev.lizardbyte.app.Sunshine \
org.gnome.World.PikaBackup \
org.virt_manager.virt-manager \
com.vixalien.sticky \
com.ranfdev.DistroShelf \
io.github.realmazharhussain.GdmSettings \
dev.fredol.open-tv \
de.haeckerfelix.Fragments \
com.steamgriddb.steam-rom-manager \
io.github.fastrizwaan.WineCharm \
org.cryptomator.Cryptomator \
io.gitlab.adhami3310.Converter \
org.gnome.FileRoller \
io.github.zaedus.spider \
io.github.giantpinkrobots.varia \
com.github.sdv43.whaler \
org.gnome.Geary \
org.gnome.gitlab.somas.Apostrophe \
io.github.ryubing.Ryujinx \
io.github.nokse22.Exhibit \
com.termius.Termius \
com.steamgriddb.SGDBoop \
net.shadps4.shadPS4 \
com.github.marhkb.Pods \
com.github.marktext.marktext \
com.github.huluti.Curtail \
so.libdb.dissent \
org.gnome.GHex \
io.github.ellie_commons.jorts \
io.kapsa.drive"

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
  echo "${blue}${bold}📦 Attempting system-wide install: ${green}${flatpak_app} ${blue}(${progress})${reset}"
  echo "${blue}${bold}${divider}${reset}"
  
  # The 'flatpak install' command will check if the app is already installed.
  # The --system flag ensures it is installed for all users.
  # The '-y' flag automatically confirms any prompts.
  flatpak install --system -y flathub "$flatpak_app"
done

echo ""
echo "${green}${bold}${divider}${reset}"
echo "${green}${bold}✅ All system-wide installations attempted. Script finished.${reset}"
echo "${green}${bold}${divider}${reset}"


