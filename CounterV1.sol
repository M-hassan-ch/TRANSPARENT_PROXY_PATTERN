// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CounterV1{
    uint public count;

    function inc() public{
        count += 1;
    }
}