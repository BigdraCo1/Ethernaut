// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMagicNum {
    function setSolver(address _solver) external;
}

contract Attack {
    /*
    MSTORE(0x0, 0x602a60005260206000f3) -> PUSH10 0x602a60005260206000f3 | PUSH1 0x00 | MSTORE -> 0x690602a60005260206000f3600052
    RETURN(0x16, 0x0a) -> PUSH1 0x0a | PUSH1 0x16 | RETURN -> 600a6016f3

    PUSH1 0x2a => 0x602a
    PUSH1 0x00 => 0x6000
    MSTORE => 0x52
    PUSH1 0x20 => 0x6020
    PUSH1 0x00 => 0x6000
    RETURN => 0xf3
    0x602a60005260206000f3 -> 10byte
    */   
    constructor(IMagicNum target) {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            let bytecodeLength := mload(bytecode) // Load the length of the bytecode
            let bytecodePtr := add(bytecode, 0x20) // Skip the length prefix
            addr := create(0, bytecodePtr, bytecodeLength)
        }
        require(addr != address(0), "Contract deployment failed");
        target.setSolver(addr);
    }
}