#!/bin/sh
# Check if server is already started
if screen -list | grep -q "survival"; then
    echo "Server is already started!  Press screen -r survival to open it"
    exit 1
fi

screen -S "survival" -d -m sh survival-server.sh
