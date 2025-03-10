#!/bin/sh
export PS4='+ $(date "+%Y-%m-%d %H:%M:%S") [$$] '

# Prompt user for input
echo -n "Enter log location (home/current): "
read USERINPUT

# Normalize input (convert to lowercase for comparison)
USERINPUT=$(echo "$USERINPUT" | tr '[:upper:]' '[:lower:]')

# Validate input
if echo "$USERINPUT" | grep -Eq "^(home|current)$"; then
    if [ "$USERINPUT" = "home" ]; then
        LOG_DIR="$HOME"
    else
        LOG_DIR="$(pwd)"
    fi

    TERMINAL_LOG="$LOG_DIR/terminal.log"
    COMMANDS_LOG="$LOG_DIR/commands.log"

    # Start logging without script output
    script -q -f "$TERMINAL_LOG" &> /dev/null &
    set -o functrace
    exec > >(tee -a "$TERMINAL_LOG") 2>&1
    set -x
else
    echo "Invalid input. Please enter 'home' or 'current'. Exiting."
    exit 1
fi
