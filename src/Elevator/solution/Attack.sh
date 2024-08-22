#!/bin/bash

# Navigate up two directories
cd ..
cd ..
cd ..

# Load environment variables from .env file
source .env

# Prompt for the TARGET value
read -p "Enter the TARGET value: " TARGET

# Create the contract using Forge and capture the output
DEPLOY_OUTPUT=$(forge create --rpc-url "$SEPOLIA_RPC_URL" --constructor-args "$TARGET" --private-key "$PRIVATE_KEY" src/Elevator/solution/Attack.sol:Attack)

# Extract the deployment address from the output
CURRENT=$(echo "$DEPLOY_OUTPUT" | grep "Deployed to" | awk '{print $NF}')

# Print the deployment address
echo "Contract deployed to address: $CURRENT"

# Interact with the deployed contract
if ! cast send "$CURRENT" "solver()" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending transaction. Check contract function and arguments."
fi

