// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {RootMe} from "./ChallengeRootMe.sol";

contract ChallengeRootMeFactory is ChallengeFactory {
    string[] _contractnames = ["RootMe"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new RootMe());
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
        return RootMe(_challenges[0]).victory();
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/rootme";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "Can you trick the machine to get root access?";
    }

    function name() external pure override returns (string memory) {
        return "Root access";
    }

    function description() external pure override returns (string memory) {
        return "This NFT gives you root access";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmSrH6mpzbq1e3sNioeaYw8GbPU8JAviS36dLnqsQ5hTJ2";
    }
}
