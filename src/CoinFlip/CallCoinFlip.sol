// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { CoinFlip } from '../CoinFlip';

contract callCoinFlip {
    CoinFlip coinFlip ;

    constructor(address _address) {
        coinFlip = CoinFlip(_address);
    }

    function byPassWinning() public {
        coinFlip.consecutiveWins = 10;
    }
}