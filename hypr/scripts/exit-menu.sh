#!/bin/bash

# Hyprland Exit Menu Script
# Requires: wofi, systemctl, hyprctl

# Menu options
options="🔒 Lock\n💤 Idle\n🚪 Logout\n🔄 Restart\n⏻ Shutdown"

# Show menu and get selection
chosen=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 200 --height 300)

case $chosen in
"🔒 Lock")
  # Lock screen - replace with your preferred lock command
  hyprlock
  ;;
"💤 Idle")
  # Put system to sleep/suspend
  systemctl suspend
  ;;
"🚪 Logout")
  # Exit Hyprland session
  hyprctl dispatch exit
  ;;
"🔄 Restart")
  # Restart system
  systemctl reboot
  ;;
"⏻ Shutdown")
  # Shutdown system
  systemctl poweroff
  ;;
*)
  # Do nothing if no option selected or ESC pressed
  exit 0
  ;;
esac
