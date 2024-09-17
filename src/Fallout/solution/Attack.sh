#!/bin/bash

# Navigate up two directories
cd ..
cd ..
cd ..

# Load environment variables from .env file
source .env

# Prompt for the TARGET value
read -p "Enter the TARGET value: " TARGET

if ! cast send "$TARGET" "Fal1out()" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending transaction. Check contract function and arguments."
fi