# Check if server is already started
if screen -list | grep -q "lobby"; then
    echo "Server is already started!  Press screen -r lobby to open it"
    exit 1
fi

screen -S "lobby" -d -m sh lobby-server.sh