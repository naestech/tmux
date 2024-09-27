#!/bin/bash
song=$(osascript -e 'tell application "Spotify" to if player state is playing then artist of current track & " - " & name of current track')
if [ -z "$song" ]; then
    echo "No song playing"
else
    echo "$song"
fi
