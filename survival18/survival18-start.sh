#!/bin/sh
# Check if server is already started
if screen -list | grep -q "survival18"; then
    echo "Server is already started!  Press screen -r survival18 to open it"
    exit 1
fi

screen -S "survival18" -d -m sh survival18-server.sh