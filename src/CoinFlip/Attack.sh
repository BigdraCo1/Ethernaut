#!/bin/bash

# Navigate up two directories
cd ..
cd ..

# Load environment variables from .env file
source .env

# Prompt for the TARGET value
read -p "Enter the TARGET value: " TARGET

# Create the contract using Forge and capture the output
DEPLOY_OUTPUT=$(forge create --rpc-url "$SEPOLIA_RPC_URL" --constructor-args "$TARGET" --private-key "$PRIVATE_KEY" src/CoinFlip/CallCoinFlip.sol:CallCoinFlip)

# Extract the deployment address from the output
CURRENT=$(echo "$DEPLOY_OUTPUT" | grep "Deployed to" | awk '{print $NF}')

# Print the deployment address
echo "Contract deployed to address: $CURRENT"

# Initialize variables
TARGET_VALUE="0x000000000000000000000000000000000000000000000000000000000000000a"
LAST_BLOCK=$(cast block-number --rpc-url "$SEPOLIA_RPC_URL")

# Function to get current block number
get_block_number() {
    cast block-number --rpc-url "$SEPOLIA_RPC_URL"
}

# Loop until consecutiveWins equals the target value
while true; do
    # Get the current block number
    CURRENT_BLOCK=$(get_block_number)
    echo "Current Block: $CURRENT_BLOCK, Last Block: $LAST_BLOCK"
    
    # Check if the current block number is different from the last one
    if [ "$CURRENT_BLOCK" != "$LAST_BLOCK" ]; then
        # Call the consecutiveWins function
        CONSECUTIVE_WINS=$(cast call "$TARGET" "consecutiveWins()" --rpc-url "$SEPOLIA_RPC_URL")
        
        # Print the result
        echo "Consecutive Wins: $CONSECUTIVE_WINS"
        
        # Check if the result matches the target value
        if [ "$CONSECUTIVE_WINS" == "$TARGET_VALUE" ]; then
            echo "Target value reached: $CONSECUTIVE_WINS"
            break
        fi
        
        # Interact with the deployed contract
        if ! cast send "$CURRENT" "byPassWinning()" --private-key "$PRIVATE_KEY" --rpc-url "$SEPOLIA_RPC_URL"; then
            echo "Error sending transaction. Check contract function and arguments."
        fi
        
        # Update the last block number
        LAST_BLOCK="$CURRENT_BLOCK"
    fi

    # Sleep for a short period before the next check
    sleep 10
done
