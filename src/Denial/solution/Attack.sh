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
DEPLOY_OUTPUT=$(forge create --rpc-url "$HOLESKY_RPC_URL" --constructor-args "$TARGET" --private-key "$PRIVATE_KEY" src/Denial/solution/Attack.sol:Attack)

# Extract the deployment address from the output
CURRENT=$(echo "$DEPLOY_OUTPUT" | grep "Deployed to" | awk '{print $NF}')

# Print the deployment address
echo "Contract deployed to address: $CURRENT"