// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {Pelusa} from "./ChallengePelusa.sol";

contract ChallengePelusaFactory is ChallengeFactory {
    string[] _contractnames = ["Pelusa"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Pelusa());
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
        // @dev to win this challenge you must drain the contract
        Pelusa _target = Pelusa(_challenges[0]);

        return _target.goals() == 2;
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/pelusa";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "Help Diego to make his second goal";
    }

    function name() external pure override returns (string memory) {
        return "Mexico 1986";
    }

    function description() external pure override returns (string memory) {
        return "Diego wants to celebrate with you his goal";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmQtDc92oczTAyJufkffB1ckLJGYw5g5ab5aetTvYSqCzA";
    }
}
