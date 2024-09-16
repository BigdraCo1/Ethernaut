const { ethers } = require('ethers');
require('dotenv').config();

// Load environment variables
const privateKey = process.env.PRIVATE;
const providerUrl = process.env.URL;
const contractAddress = process.env.TARGET;
console.log(providerUrl);
if (!providerUrl) {
    console.error('Provider URL is not defined.');
    process.exit(1);
}

// Initialize ethers provider and wallet
const provider = new ethers.JsonRpcProvider(providerUrl);
const wallet = new ethers.Wallet(privateKey, provider);

// Define the contract ABI
const minimalABI = [
    {
        "constant": false,
        "inputs": [],
        "name": "pwn",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    }
];

// Initialize the contract
const contract = new ethers.Contract(contractAddress, minimalABI, wallet);

async function callPwn() {
    try {
        // Call the 'pwn' function and specify the gas limit
        const tx = await contract.pwn({
            gasLimit: 2000000,  // Optional: specify gas limit
        });

        // Wait for the transaction to be mined
        const receipt = await tx.wait();

        console.log('Transaction hash:', receipt.transactionHash);
        console.log('Transaction receipt:', receipt);
    } catch (error) {
        console.error('Error:', error);
    }
}

callPwn();
