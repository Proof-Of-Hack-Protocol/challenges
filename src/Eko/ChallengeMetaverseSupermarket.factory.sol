// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {InflaStore} from "./ChallengeMetaverseSupermarket.sol";

interface IERC721 {
    function balanceOf(address) external view returns (uint256);
}

contract ChallengeMetaverseSupermarketFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["MetaverseSupermarket"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new InflaStore(_player));

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
        return IERC721(address(InflaStore(_challenges[0]).meal())).balanceOf(_challengePlayer[_challenges[0]]) >= 10;
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/metaverse-supermarket";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return
        "We are all living in the Inflation Metaverse, a digital world dominated by the INFLA token. You are out of INFLAs and you are starving, can you defeat the system?";
    }

    function name() external pure override returns (string memory) {
        return "Inflation Metaverse - CTF Protocol EKO2022";
    }

    function description() external pure override returns (string memory) {
        return "I have defeat the system, what about you anon?";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmbRSMY7So4bPGf78JCedZ9t6AQJodHsJUhnserLbfgNrr";
    }
}
