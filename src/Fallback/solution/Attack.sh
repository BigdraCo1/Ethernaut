#!/bin/bash

# Navigate up two directories
cd ..
cd ..
cd ..

# Load environment variables from .env file
source .env

# Prompt for the TARGET value
read -p "Enter the TARGET value: " TARGET

# Interact with the deployed contract
if ! cast send "$TARGET" "contribute()" --private-key "$PRIVATE_KEY" --value 0.0001ether --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending transaction. Check contract function and arguments."
fi

if ! cast send "$TARGET" --private-key "$PRIVATE_KEY" --value 0.0001ether --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending transaction. Check contract function and arguments."
fi

if ! cast send "$TARGET" "withdraw()" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending transaction. Check contract function and arguments."
fi
