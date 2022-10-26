// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Script.sol";

import {L0EthernautFactory} from "src/Ethernaut/L0.factory.sol";
import {L1EthernautFactory} from "src/Ethernaut/L1.factory.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address level0 = address(new L0EthernautFactory());
        address level1 = address(new L1EthernautFactory());
        vm.stopBroadcast();
        console.log("level0", level0);
        console.log("level1", level1);
    }
}
