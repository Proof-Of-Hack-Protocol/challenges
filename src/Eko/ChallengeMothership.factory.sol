// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ChallengeFactory} from "../ChallengeFactory.sol";
import {Mothership} from "./ChallengeMothership.sol";

contract ChallengeMothershipFactory is ChallengeFactory {
    string[] _contractnames = ["Mothership"];

    function deploy(address) external payable override returns (address[] memory ret) {
        require(msg.value == 0, "dont send ether");
        Mothership mothership = new Mothership();

        ret = new address[](1);
        ret[0] = address(mothership);
    }

    function deployValue() external pure override returns (uint256) {
        return 0;
    }

    function contractNames() external view override returns (string[] memory) {
        return _contractnames;
    }

    function isComplete(address[] calldata _challenges) external view override returns (bool) {
        return Mothership(_challenges[0]).hacked();
    }

    function path() external pure returns (string memory) {
        return "/tracks/eko2022/hack-the-mothership";
    }

    /// @dev optional to give a link to a readme
    function readme() external pure returns (string memory) {
        return
        "A big alien fleet is near the Earth! You and a small group of scientist have been working on a global counteroffensive against the invader. Your objetive is to hack the Mothership instance (change the hacked bool to true).";
    }

    function name() external pure override returns (string memory) {
        return "Alien Invasion";
    }

    function description() external pure override returns (string memory) {
        return
        "A big alien fleet is near the Earth!.\n You and a small group of scientist have been working on a global counteroffensive against the invader.\n We've recovered some of the ship's sourcecode and we need to find a way to hack it!\n You have studied the code and you found out that you need to hack the mothership if you want to survive\n Your objetive is to hack the Mothership instance (change the hacked bool to true).\n Good luck, the earth's future depends on you!";
    }

    function image() external pure override returns (string memory) {
        return "ipfs://QmZ4Um1w7XfqSwaedMhXpb1bMXSy9vuYio62o3wKRopc4v";
    }
}
