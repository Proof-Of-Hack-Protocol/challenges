// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Stonks
/// @author https://twitter.com/eugenioclrc
/// @notice You have infiltrated in a big investment firm (name says something about arrows), your task is to loose all their money
/// @custom:url https://www.ctfprotocol.com/tracks/eko2022/stonks
contract Stonks {
    mapping(address => mapping(uint256 => uint256)) private _balances;

    // stock tickers
    uint256 public constant TSLA = 0;
    uint256 public constant GME = 1;

    ///@dev price oracle 1 TSLA stonk is 50 GME stonks
    uint256 public constant ORACLE_TSLA_GME = 50;

    constructor(address _player) {
        ///@dev the trader starts with 200 TSLA shares & 1000 GME shares
        _balances[_player][TSLA] = 20;
        _balances[_player][GME] = 1_000;
    }

    /// @notice Buy TSLA stonks using GME stonks
    /// @param amountGMEin amount of GME to spend
    /// @param amountTSLAout amount of TSLA to buy
    function buyTSLA(uint256 amountGMEin, uint256 amountTSLAout) external {
        require(amountGMEin / ORACLE_TSLA_GME == amountTSLAout, "Invalid price");
        _balances[msg.sender][GME] -= amountGMEin;
        _balances[msg.sender][TSLA] += amountTSLAout;
    }

    /// @notice Sell TSLA stonks for GME stonks
    /// @param amountTSLAin amount of GME to spend
    /// @param amountGMEout amount of TSLA to buy
    function sellTSLA(uint256 amountTSLAin, uint256 amountGMEout) external {
        require(amountTSLAin * ORACLE_TSLA_GME == amountGMEout, "Invalid price");
        _balances[msg.sender][TSLA] -= amountTSLAin;
        _balances[msg.sender][GME] += amountGMEout;
    }

    function balanceOf(address _owner, uint256 _ticker) external view returns (uint256) {
        return _balances[_owner][_ticker];
    }
}
