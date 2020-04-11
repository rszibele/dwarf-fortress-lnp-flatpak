#!/usr/bin/env bash
notify-send "Legends Browser is being launched. Please wait..."
$(sleep 1 && xdg-open "http://localhost:58881") &
./legendsbrowser-original.sh
