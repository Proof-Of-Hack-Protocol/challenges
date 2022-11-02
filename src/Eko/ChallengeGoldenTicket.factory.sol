// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {GoldenTicket} from "./ChallengeGoldenTicket.sol";

contract ChallengeGoldenTicketFactory is ChallengeFactory {
    mapping(address => address) private _challengePlayer;
    string[] _contractnames = ["GoldenTicket"];

    function deploy(address _player) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "Dont send ether");
        address _challenge = address(new GoldenTicket());
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
        // @dev to win this challenge you must drain the contract
        address _player = _challengePlayer[_challenges[0]];
        return GoldenTicket(_challenges[0]).hasTicket(_player);
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/the-golden-ticket";
    }

    /// @dev optional to give a link to a readme or plain text
    function readme() external pure returns (string memory) {
        return "Mint your ticket to the eko party, if you are patient and lucky enough.";
    }

    function name() external pure override returns (string memory) {
        return "Golden Ticket";
    }

    function description() external pure override returns (string memory) {
        return "Proud owner of the golden ticket";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmdwGmeeweZya62pCsGJrmqstxtkwTq4rwFHEJ9LQEjm4P";
    }
}
