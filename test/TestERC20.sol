// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

// solhint-disable no-empty-blocks

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestERC20 is ERC20 {
    constructor() ERC20("Test ERC20", "TERC") { }

    function mint(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }
}

contract MalfunctioningERC20 is TestERC20 {
    // _update is doing nothing so that a transfer seems to have gone through,
    // but the internal state of the ERC20 contract is not updated - i.e. no transfer really happened
    function _update(address from, address to, uint256 value) internal override virtual {
        // Do nothing 😱
    }
}