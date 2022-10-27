// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChallengeFactory} from "../ChallengeFactory.sol";

import {Telephone} from "./L3.telephone.sol";

contract L3EthernautFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["Telephone"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Telephone());
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
        // @dev to win this challenge you must get ownership
        return Telephone(_challenges[0]).owner() == _player;
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "";
    }

    function name() external pure override returns (string memory) {
        return "Telephone";
    }

    function description() external pure override returns (string memory) {
        return "Telephone, challenge made by Kyle Riley, https://github.com/syncikin";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmPP1KJb78xw3do1RAjCgkdYPkVxaTSwtDj5LJXZDVghST";
    }
}
