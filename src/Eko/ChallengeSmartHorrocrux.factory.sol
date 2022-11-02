// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {SmartHorrocrux} from "./ChallengeSmartHorrocrux.sol";

contract ChallengeSmartHorrocruxFactory is ChallengeFactory {
    string[] _contractnames = ["SmartHorrocrux"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 2, "Pay me 2 wei");
        address _challenge = address(new SmartHorrocrux{value: 2}());
        ret = new address[](1);
        ret[0] = _challenge;
    }

    function deployValue() external pure override returns (uint256) {
        return 2; // 2 wei is needed
    }

    function contractNames() external view override returns (string[] memory) {
        return _contractnames;
    }

    function isComplete(address[] calldata _challenges) external view override returns (bool) {
        // @dev to win this challenge you must detroy the contract
        address _contract = _challenges[0];

        uint256 size;
        assembly {
            size := extcodesize(_contract)
        }
        return size == 0;
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/smart-horrocrux";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return
        "Some security researchers have recently found an eighth Horrocrux, it seems that Voldemort has link to a smart contract, can you destroy it?";
    }

    function name() external pure override returns (string memory) {
        return "Philosopher's NFT";
    }

    function description() external pure override returns (string memory) {
        return
        "This NFT is part of the series of challenges proposed by the Blockchain Space of Ekoparty 2022. Congratulations on solving it!";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmXr17Np2Li2ZQ8wgKx39bH3HVMrxczfuw9hW419efg3hZ";
    }
}
