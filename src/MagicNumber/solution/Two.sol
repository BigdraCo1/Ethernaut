// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solver {
    constructor() {}

    function whatIsTheMeaningOfLife() public pure returns (uint8){
        assembly {
            mstore(0x0, 0x2a)
            return(0x0, 0x2)
        }
    }
}