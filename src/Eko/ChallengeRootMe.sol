// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title RootMe
/// @author https://twitter.com/tinchoabbate
/// @notice Anon, can you trick the machine to get root access?
/// @custom:url https://www.ctfprotocol.com/tracks/eko2022/rootme
contract RootMe {
    bool public victory;

    mapping(string => bool) public usernames;
    mapping(bytes32 => address) public accountByIdentifier;

    constructor() {
        register("ROOT", "ROOT");
    }

    modifier onlyRoot() {
        require(accountByIdentifier[_getIdentifier("ROOT", "ROOT")] == msg.sender, "Not authorized");
        _;
    }

    function register(string memory username, string memory salt) public {
        require(usernames[username] == false, "Username already exists");

        usernames[username] = true;

        bytes32 identifier = _getIdentifier(username, salt);
        accountByIdentifier[identifier] = msg.sender;
    }

    function _getIdentifier(string memory user, string memory salt) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(user, salt));
    }

    /**
     * @notice Allows root account to perform any change in the contract's storage
     * @param storageSlot storage position where data will be written
     * @param data data to be written
     */
    function write(bytes32 storageSlot, bytes32 data) external onlyRoot {
        assembly {
            // stores `data` in storage at position `storageSlot`
            sstore(storageSlot, data)
        }
    }
}
