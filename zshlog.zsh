#!/bin/zsh
export PS4='+ $(date "+%Y-%m-%d %H:%M:%S") [$$] '

read -r "?Enter log location (home/current): " USERINPUT

# Normalize input (convert to lowercase for comparison)
USERINPUT=$(echo "$USERINPUT" | tr '[:upper:]' '[:lower:]')

# the =~ is a regex operator and the carrot sign ^ ensures that only home or current would be accepted

if [[ "$USERINPUT" =~ ^(home|current)$ ]]; then
    if [[ "$USERINPUT" == "home" ]]; then
        LOG_PATH="$HOME/commands.log"
    else
        LOG_PATH="$(pwd)/commands.log"
    fi

    script -f "$(pwd)/terminal.log" &> >(tee -a "$LOG_PATH")
    set -o functrace
    exec > >(tee -a "$(pwd)/terminal.log") 2>&1
    set -x
else
    echo "Invalid input. Please enter 'home' or 'current'. Exiting."
    exit 1
fi
