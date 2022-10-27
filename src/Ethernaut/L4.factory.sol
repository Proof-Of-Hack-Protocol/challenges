// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChallengeFactory} from "../ChallengeFactory.sol";

import {Token} from "./L4.token.sol";

contract L4EthernautFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["Token"]; // name

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Token(_player));
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
        return Token(_challenges[0]).balanceOf(_player) > Token(_challenges[0]).totalSupply();
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "";
    }

    function name() external pure override returns (string memory) {
        return "Token";
    }

    function description() external pure override returns (string memory) {
        return "Token, challenge made by Alejandro Santander, https://github.com/ajsantander";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmcVFnhruhsihvCVEyk2JbkeCza7w8cHUJK88hGbtobDF5";
    }
}
