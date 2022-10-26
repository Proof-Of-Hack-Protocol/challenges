// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChallengeFactory} from "../ChallengeFactory.sol";

import {Fallback} from "./L0.fallback.sol";

contract L0EthernautFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["Fallback"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Fallback());
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
        return _challenges[0].balance == 0 && Fallback(payable(_challenges[0])).owner() == payable(_player);
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "ipfs://QmXr6ppPapCepGhMBviDdF95j3LJEsP1ztDbRM54yXyhKY";
    }

    function name() external pure override returns (string memory) {
        return "Fallback";
    }

    function description() external pure override returns (string memory) {
        return "Fallback, challenge made by Alejandro Santander, https://github.com/ajsantander";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmXaRasjDTBMWfuQ2ge9fsqWWoS2x6MRFbhLFPoRvvjuDw";
    }
}
