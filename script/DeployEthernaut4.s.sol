// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Script.sol";

import {L4EthernautFactory} from "src/Ethernaut/L4.factory.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address level = address(new L4EthernautFactory());
        vm.stopBroadcast();
        console.log("level4", level);
    }
}
