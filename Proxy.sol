// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Proxy{
    address public implementation;
    address public admin;

    constructor(){
        admin = msg.sender;
    }

    function upgradeTo(address impl) public{
        implementation = impl;
    }

    function _delegate() private{
        (bool res, ) = implementation.delegatecall(msg.data);
        require(res, "tx failed");
    }

    fallback() external payable{
        _delegate();
    }

    receive() external payable{
        _delegate();
    }

}