// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/// @title Trickster
/// @author https://twitter.com/mattaereal
/// @notice We might have spotted a honeypot... Anon, can you manage to obtain the real jackpot?
/// @custom:url https://www.ctfprotocol.com/tracks/eko2022/trickster
contract Jackpot {
    address private jackpotProxy;
    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function initialize(address _jackpotProxy) public payable {
        jackpotProxy = _jackpotProxy;
    }

    modifier onlyJackpotProxy() {
        require(msg.sender == jackpotProxy);
        _;
    }

    function claimPrize(uint256 amount) external payable onlyJackpotProxy {
        payable(msg.sender).transfer(amount * 2);
    }

    fallback() external payable {}

    receive() external payable {}
}

contract JackpotProxy {
    address private owner;
    address private jackpot;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() payable {
        owner = msg.sender;
        address _proxy = address(new Jackpot());
        initialize(_proxy);
        payable(_proxy).transfer(address(this).balance);
    }

    function initialize(address _jackpot) public onlyOwner {
        jackpot = _jackpot;
    }

    function claimPrize() external payable {
        require(msg.value > 0, "zero deposit");
        (bool success,) = jackpot.call{value: msg.value}(abi.encodeWithSignature("claimPrize(uint)", msg.value));
        require(success, "failed");
        payable(msg.sender).transfer(address(this).balance);
    }

    function balance() external view returns (uint256) {
        return jackpot.balance;
    }

    receive() external payable {}
}
