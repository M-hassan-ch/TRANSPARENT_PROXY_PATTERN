// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "Proxy.sol";

contract ProxyAdmin{
    address public owner;
    Proxy proxyContract;
    address payable proxyAddr;

    constructor(){
        owner = msg.sender;
    }

    function init(address payable addr) public onlyOwner{
        proxyAddr = addr;
        proxyContract = Proxy(addr);
    }

    modifier onlyOwner(){
        require(owner == msg.sender, "Unauthorised");
        _;
    }

    function changeProxyAdmin(address _admin) public onlyOwner {
        proxyContract.setAdmin(_admin);
    }

    function setImplementaion(address _address) onlyOwner public{
        proxyContract.setImplementaion(_address);
    }

    function getImplementation() public view onlyOwner returns (address){
        return proxyContract.getImplementaion();
    }

    function duplicate() public onlyOwner returns(address){
        return proxyContract.duplicate();
    }

    function getAdmin() public view onlyOwner returns (address){
        (bool ok, bytes memory res) = proxyAddr.staticcall(abi.encodeCall(Proxy.getAdmin, ()));
        require(ok, "call failed");
        return abi.decode(res, (address));
    }
}