#!/bin/bash

# Define color codes
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[36m'
RESET='\e[0m'

# Detecting Operating System
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_NAME="$NAME"
    OS_VERSION="$VERSION"
elif type lsb_release >/dev/null 2>&1; then
    OS_NAME=$(lsb_release -si)
    OS_VERSION=$(lsb_release -sr)
else
    OS_NAME=$(uname -s)
    OS_VERSION=$(uname -r)
fi

echo -e "${CYAN}Operating System Detected: ${YELLOW}$OS_NAME $OS_VERSION${RESET}"
echo -e "${BLUE}------------------------------------------------${RESET}"

# Fun Download Banner
echo -e "${RED}Initializing Google Chrome Installation...${RESET}"
echo -e "${BLUE}------------------------------------------------${RESET}"

echo -e "${YELLOW}Fetching the following package:${RESET}"
echo -e "${CYAN}- Google Chrome Stable${RESET}"
echo -e "${BLUE}------------------------------------------------${RESET}"

# Fake Download Simulation
duration=20  # Total fake download time (seconds)
increment=$(echo "scale=2; $duration / 100" | bc)

start_time=$(date +%s)
for i in {1..100}; do
    speed=$(( (RANDOM % 900) + 600 ))  # Random KB/s between 600 and 1500
    echo -ne "\r${GREEN}[ $(printf '%-50s' $(printf '#%.0s' $(seq 1 $((i/2))))) ] $i% [$speed KB/s]${RESET}"
    sleep $increment
done

echo -e "\n${GREEN}Download Simulation Complete!${RESET}"
echo -e "${BLUE}------------------------------------------------${RESET}"

# Real Installation (for Ubuntu/Debian)
echo -e "${YELLOW}Installing Google Chrome...${RESET}"
sleep 2

if [[ "$OS_NAME" =~ Ubuntu|Debian ]]; then
    echo -e "${CYAN}Step 1: Downloading .deb package${RESET}"
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome.deb

    echo -e "${CYAN}Step 2: Installing via dpkg${RESET}"
    sudo dpkg -i /tmp/google-chrome.deb >/dev/null 2>&1 || sudo apt -f install -y >/dev/null

    echo -e "${GREEN}Google Chrome has been installed successfully!${RESET}"
else
    echo -e "${RED}This script currently supports only Ubuntu/Debian systems for actual installation.${RESET}"
fi

echo -e "${BLUE}------------------------------------------------${RESET}"
echo -e "${CYAN}To launch Chrome, run: ${YELLOW}google-chrome${RESET}"
