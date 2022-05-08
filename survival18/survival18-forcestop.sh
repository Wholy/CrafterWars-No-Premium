# Check if server is running
if ! screen -list | grep -q "survival18"; then
  echo "Server is not currently running!"
  exit 1
fi

# Get an optional custom countdown time (in minutes)
CountdownTime=0
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
    screen -Rd survival18 -X stuff "say Stopping server in 60 seconds...$(printf '\r')"
    echo "60 seconds"
    sleep 30;
    screen -Rd survival18 -X stuff "say Stopping server in 30 seconds...$(printf '\r')"
    echo "30 seconds"
    sleep 20;
    screen -Rd survival18 -X stuff "say Stopping server in 10 seconds...$(printf '\r')"
    echo "10 seconds"
    sleep 10;
    break
  fi
  echo "Waiting for $CountdownTime more minutes ..."
done
echo "Stopping Minecraft server ..."
screen -Rd survival18 -X stuff "say Stopping server (stop.sh called)...$(printf '\r')"
screen -Rd survival18 -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 20 ]; do
  if ! screen -list | grep -q "survival18"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

# Force quit if server is still open
if screen -list | grep -q "survival18"; then
  echo "Minecraft server still hasn't stopped after 20 seconds, closing screen manually"
  screen -S survival18 -X quit
fi

echo "Minecraft server survival18 stopped."