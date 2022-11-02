// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {JackpotProxy} from "./ChallengeTrickster.sol";

contract ChallengeTricksterFactory is ChallengeFactory {
    string[] _contractnames = ["JackpotProxy"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0.0001 ether, "Please pay 0.0001 ether");
        address _challenge = address(new JackpotProxy{value: msg.value}());
        ret = new address[](1);
        ret[0] = _challenge;
    }

    function deployValue() external pure override returns (uint256) {
        return 0.0001 ether;
    }

    function contractNames() external view override returns (string[] memory) {
        return _contractnames;
    }

    function isComplete(address[] calldata _challenges) external view override returns (bool) {
        // @dev to win this challenge you must drain the contract
        return JackpotProxy(payable(_challenges[0])).balance() == 0;
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/trickster";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "This challenge is not what it seems. Remember, a lazy being works twice as hard.";
    }

    function name() external pure override returns (string memory) {
        return "Trickster";
    }

    function description() external pure override returns (string memory) {
        return "Managed to see the real jackpot.";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmTduBAPtCDFJbrVYzdE7igYrx6A8C6XRTbL4Z5rPcQYBG";
    }
}
