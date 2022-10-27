// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChallengeFactory} from "../ChallengeFactory.sol";

import {CoinFlip} from "./L2.coinflip.sol";

contract L2EthernautFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["CoinFlip"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new CoinFlip());
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
        return _challenges[0].balance == 0 && CoinFlip(_challenges[0]).consecutiveWins() >= 10;
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "ipfs://QmPE8a2FttGnjP2WKX9BRqHPmCM8mBdT8pQ3DWjL3sQk89";
    }

    function name() external pure override returns (string memory) {
        return "CoinFlip";
    }

    function description() external pure override returns (string memory) {
        return "CoinFlip, challenge made by Kyle Riley, https://github.com/syncikin";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmbcUJqoTvRxABGwy3DUmMtULMZGHnAAA95WwNLTYiLsJG";
    }
}
