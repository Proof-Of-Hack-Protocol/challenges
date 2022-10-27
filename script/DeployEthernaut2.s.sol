// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Script.sol";

import {L2EthernautFactory} from "src/Ethernaut/L2.factory.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address level = address(new L2EthernautFactory());
        vm.stopBroadcast();
        console.log("level2", level);
    }
}
