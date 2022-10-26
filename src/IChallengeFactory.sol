// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// bad name, this is the factory interface that a challenge level should have

interface IChallengeFactory {
    // @notice create challenges contract
    function deploy(address player) external payable returns (address[] memory);

    function deployValue() external view returns (uint256);

    // @notice return name of the contract challenges
    function contractNames() external view returns (string[] memory);

    /// @notice Will true if player has complete the challenge
    function isComplete(address[] calldata) external view returns (bool);

    // @notice return name for rendering the nft
    function name() external view returns (string memory);

    // @notice return name for rendering the nft
    function description() external view returns (string memory);

    // @notice return image for rendering the nft
    function image() external view returns (string memory);
}
