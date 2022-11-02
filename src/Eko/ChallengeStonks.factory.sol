// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {Stonks} from "./ChallengeStonks.sol";

contract ChallengeStonksFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["Stonks"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Stonks(_player));
        ret = new address[](1);
        ret[0] = _challenge;
        _challengePlayer[_challenge] = _player;
    }

    function deployValue() external pure override returns (uint256) {
        return 0;
    }

    function contractNames() external view override returns (string[] memory) {
        return _contractnames;
    }

    function isComplete(address[] calldata _challenges) external view override returns (bool) {
        // @dev to win this challenge you must drain the contract
        address _player = _challengePlayer[_challenges[0]];
        Stonks _target = Stonks(_challenges[0]);

        return _target.balanceOf(_player, _target.TSLA()) == 0 && _target.balanceOf(_player, _target.GME()) == 0;
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/stonks";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return
        "You have infiltrated in a big investment firm (name say something about arrows), your task is to loss all their money";
    }

    function name() external pure override returns (string memory) {
        return "The Stonks";
    }

    function description() external pure override returns (string memory) {
        return "You have mastered the stonks market.";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmeY5WXdV6aEg6A6UjQgbqxLKy1MAURRikBN4UhwynBm9c";
    }
}
