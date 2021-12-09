# Check if server is already started
if screen -list | grep -q "bungee"; then
    echo "Server is already started!  Press screen -r bungee to open it"
    exit 1
fi

screen -S "bungee" -d -m sh bungee-server.sh