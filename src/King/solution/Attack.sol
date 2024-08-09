// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClaimKing {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAll() public {
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    function sendMoney(address payable _target) public payable  {
        (bool success, ) = _target.call{value: msg.value}("");
        require(success, "Send money failed");    
    }

    receive() external payable {
        revert();
    }
}