// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {Laboratory} from "./ChallengePhoenixtto.sol";

contract ChallengePhoenixttoFactory is ChallengeFactory {
    string[] _contractnames = ["Laboratory"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        address _challenge = address(new Laboratory());
        Laboratory(_challenge).mergePhoenixDitto();
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
        Laboratory _target = Laboratory(_challenges[0]);

        return _target.isCaught();
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/phoenixtto";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return "A wild Phoenixtto appears, capture the Phoenixtto, if you can...";
    }

    function name() external pure override returns (string memory) {
        return "Phoenixtto";
    }

    function description() external pure override returns (string memory) {
        return
        "Born in a crossover of harry potter, pokemon and solidity. with the ability of resurrection with a copy of other bytecode";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmV2mwRVwYrg3AzvcrG2NPhY5JzoSY3i88T3ec6CzJXWKj";
    }
}
