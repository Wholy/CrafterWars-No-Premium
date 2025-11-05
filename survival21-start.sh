#!/bin/sh
# Check if server is already started
if screen -list | grep -q "survival21"; then
    echo "Server is already started!  Press screen -r survival21 to open it"
    exit 1
fi

screen -S "survival21" -d -m sh survival21-server.sh