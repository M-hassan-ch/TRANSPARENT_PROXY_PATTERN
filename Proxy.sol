// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./StorageSlot.sol";

contract Proxy{
    bytes32 public constant IMPLEMENTATION_SOT = bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);
    bytes32 public constant ADMIN_SOT = bytes32(uint(keccak256("eip1967.proxy.admin")) - 1);

    constructor(){
        setAdmin(msg.sender);
    }

    function upgradeTo(address impl) public{
        setImplementaion(impl);
    }

    function setAdmin(address _address) public{
        StorageSlot.getAddressSlot(ADMIN_SOT).value = _address;
    }

    function setImplementaion(address _address) public{
        require(_address.code.length > 0, "should not be EOA");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SOT).value = _address;
    }

    function getAdmin() view public returns(address){
        return StorageSlot.getAddressSlot(ADMIN_SOT).value;
    } 

    function getImplementaion() view public returns(address){
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SOT).value;
    } 

    function _delegate(address _implementation) private{
         assembly {
            
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    fallback() external payable{
        _delegate(getImplementaion());
    }

    receive() external payable{
        _delegate(getImplementaion());
    }

}