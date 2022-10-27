// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Script.sol";

import {L5EthernautFactory} from "src/Ethernaut/L5.factory.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address level = address(new L5EthernautFactory());
        vm.stopBroadcast();
        console.log("level5", level);
    }
}
