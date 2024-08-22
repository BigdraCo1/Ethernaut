// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solver {
    
    /*
    PUSH1 0x2a => 0x602a
    PUSH0 0x => 0x5F
    MSTORE => 0x52
    PUSH1 0x20 => 0x6020
    PUSH0 0x => 0x5F
    RETURN => 0xF3
    0x602a5F5260205FF3
    */
    
    constructor() {
        assembly {
            mstore(0x0, 0x602a5F5260205FF3)

            // 0x602a5F5260205FF3 8 bytes => 0x08 
            // 32 - 8 = 24 => 0x18

            return(0x0, 0x18)
        }
    }
}