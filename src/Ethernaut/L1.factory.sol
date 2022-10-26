// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChallengeFactory} from "../ChallengeFactory.sol";

import {Fallout} from "./L1.fallout.sol";

contract L1EthernautFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["Fallout"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Fallout());
        _challengePlayer[_challenge] = _player;
        ret = new address[](1);
        ret[0] = _challenge;
    }

    function deployValue() external pure override returns (uint256) {
        return 0;
    }

    function contractNames() external view override returns (string[] memory) {
        return _contractnames;
    }

    function isComplete(address[] calldata _challenges) external view override returns (bool) {
        address _player = _challengePlayer[_challenges[0]];
        if (_player == address(0)) {
            return false;
        }
        // @dev to win this challenge you must drain the contract and be the owner
        return _challenges[0].balance == 0 && Fallout(payable(_challenges[0])).owner() == payable(_player);
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "ipfs://QmfYoC9ckT8urA4ix3hJvWf1invVGMdzaRhzswUoyAQvBE";
    }

    function name() external pure override returns (string memory) {
        return "Fallout";
    }

    function description() external pure override returns (string memory) {
        return "Fallout, challenge made by Alejandro Santander, https://github.com/ajsantander";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmXaRasjDTBMWfuQ2ge9fsqWWoS2x6MRFbhLFPoRvvjuDw";
    }
}
