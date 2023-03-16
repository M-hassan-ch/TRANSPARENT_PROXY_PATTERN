// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./StorageSlot.sol";

contract TestStorageSlot{
    bytes32 public constant SlOT = keccak256("Test_Slot");

    function getSlotValue() view public returns(address){
        return StorageSlot.getAddressSlot(SlOT).value;
    } 

    function writeToSlot(address _address) public{
        StorageSlot.getAddressSlot(SlOT).value = _address;
    }
}