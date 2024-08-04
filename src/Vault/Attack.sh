#!/bin/bash

# Navigate up two directories
cd ..
cd ..

# Load environment variables from .env file
source .env

# Prompt for the TARGET value
read -p "Enter the TARGET value: " TARGET

PASSWORD=$(cast storage "$TARGET" 1 --rpc-url "$SEPOLIA_RPC_URL")
echo "Password: $PASSWORD"

if ! cast send "$TARGET" "unlock(bytes32)" "$PASSWORD" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending transaction. Check contract function and arguments."
fi
