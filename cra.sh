#!/bin/bash

TOPIC="astrochat-1"
SERVER="https://ntfy.sh/$TOPIC"
USER_NAME="${USER:-$(whoami)}"

echo "Connected."
echo "You are: $USER_NAME"
echo "----------------------"

curl -sN "$SERVER/raw" | while read -r line; do
  echo "$line"
done &

while read -r msg; do
  [ -z "$msg" ] && continue
  curl -s -X POST "$SERVER" -d "[$USER_NAME] $msg" > /dev/null
done
