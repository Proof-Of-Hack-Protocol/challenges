// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {House} from "./ChallengeHiddenKitty.sol";

contract ChallengeHiddenKittyFactory is ChallengeFactory {
    string[] _contractnames = ["House"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new House());
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
        return House(_challenges[0]).catFound();
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/hidden-kittycat";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "Lucas is a scientist who has lost his cat in a big house that has 2^256 rooms, can you find it?";
    }

    function name() external pure override returns (string memory) {
        return "The Lost Kitty";
    }

    function description() external pure override returns (string memory) {
        return
        "I've found Lucas' cat and all I got was this NFT. https://www.ctfprotocol.com/tracks/eko2022/hidden-kittycat";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmQHvL3sqxsCvFvWtWowk3EjCcRKH5YicLVUPqUEDUwpBc";
    }
}
