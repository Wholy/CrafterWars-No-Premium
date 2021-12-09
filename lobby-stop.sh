# Check if server is running
if ! screen -list | grep -q "lobby"; then
  echo "Server is not currently running!"
  exit 1
fi

# Get an optional custom countdown time (in minutes)
CountdownTime=1
while getopts ":t" opt; do
  case $opt in
    t)
      case $string in
        ''|*[!0-9]*) 
          echo "Countdown time must be a whole number in minutes."
          exit 1
          ;;
        *) 
          CountdownTime=$OPTARG >&2 
          ;;
      esac
      ;;
    \?)
      echo "Invalid option: -$OPTARG; countdown time must be a whole number in minutes." >&2
      ;;
  esac
done

# Stop the server
while [ $CountdownTime -gt 0 ]; do
  if [ $CountdownTime -eq 1 ]; then
    screen -Rd lobby -X stuff "say Stop server 60 min... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "3600 seconds"
    sleep 1800;
    screen -Rd lobby -X stuff "say Stop server 30 min... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "1800 seconds"
    sleep 900;
    screen -Rd lobby -X stuff "say Stop server 15 min... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "900 seconds"
    sleep 300;
    screen -Rd lobby -X stuff "say Stop server 10 min... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "600 seconds"
    sleep 300;
    screen -Rd lobby -X stuff "say Stop server 5 min... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "300 seconds"
    sleep 240;
    screen -Rd lobby -X stuff "say Stop server 60 seconds... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "60 seconds"
    sleep 30;
    screen -Rd lobby -X stuff "say Stop server 30 seconds... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "30 seconds"
    sleep 20;
    screen -Rd lobby -X stuff "say Stop server 10 seconds... PONGASE EN UN LUGAR SEGURO$(printf '\r')"
    echo "10 seconds"
    sleep 10;
    break
  fi
  echo "Waiting for $CountdownTime more minutes ..."
done
echo "Stopping Minecraft server ..."
screen -Rd lobby -X stuff "say Stopping server (stop.sh called)...$(printf '\r')"
screen -Rd lobby -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 20 ]; do
  if ! screen -list | grep -q "lobby"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

# Force quit if server is still open
if screen -list | grep -q "lobby"; then
  echo "Minecraft server still hasn't stopped after 20 seconds, closing screen manually"
  screen -S lobby -X quit
fi

echo "Minecraft server lobby stopped."