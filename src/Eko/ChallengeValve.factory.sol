// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {Valve} from "./ChallengeValve.sol";

contract ChallengeValveFactory is ChallengeFactory {
    string[] _contractnames = ["Valve"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Valve());
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
        Valve _target = Valve(_challenges[0]);

        return _target.open();
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/gas-valve";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return
        "The evil Dr. N. Gas has created a machine to suck all the air out of the atmosphere. You must deactivate it before it's too late!";
    }

    function name() external pure override returns (string memory) {
        return "Gas Valve";
    }

    function description() external pure override returns (string memory) {
        return "Congratulations, you mastered gas forwarding and stopped Dr. Gas evil plan!";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmYGneGS5SCqptKjW2Rv82tj4YtwomRdqXoQU7yVTsegXn";
    }
}
