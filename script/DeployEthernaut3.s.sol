// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Script.sol";

import {L3EthernautFactory} from "src/Ethernaut/L3.factory.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address level = address(new L3EthernautFactory());
        vm.stopBroadcast();
        console.log("level3", level);
    }
}
