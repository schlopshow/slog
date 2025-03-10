#!/bin/sh
export PS4='+ $(date "+%Y-%m-%d %H:%M:%S") [$$] '

# Prompt user for input
echo "Enter log location (home/current): "
read USERINPUT

# Normalize input (convert to lowercase for comparison)
USERINPUT=$(echo "$USERINPUT" | tr '[:upper:]' '[:lower:]')

# Validate input
# We are using grep to with the ^ sign to ensure that it is either home or current
if echo "$USERINPUT" | grep -Eq "^(home|current)$"; then
    if [ "$USERINPUT" = "home" ]; then
        LOG_PATH="$HOME/commands.log"
    else
        LOG_PATH="$(pwd)/commands.log"
    fi

    # Start logging
    script -f "$(pwd)/terminal.log" | tee -a "$LOG_PATH" &
    set -o functrace
    exec > >(tee -a "$(pwd)/terminal.log") 2>&1
    set -x
else
    echo "Invalid input. Please enter 'home' or 'current'. Exiting."
    exit 1
fi
