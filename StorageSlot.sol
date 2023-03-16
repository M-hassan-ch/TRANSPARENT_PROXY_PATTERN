// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library StorageSlot{
    struct AddressSlot{
        address value;
    }

    function getAddressSlot(bytes32 slot) public pure returns(AddressSlot storage r){
        assembly{
            r.slot := slot
        }
    }
}