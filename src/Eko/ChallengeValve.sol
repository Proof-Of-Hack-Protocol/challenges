// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface INozzle {
    function insert() external returns (bool);
}

/// @title Gas Valve
/// @author https://twitter.com/bahurum
/// @notice The evil Dr. N. Gas has created a machine to suck all the air out of the atmosphere. Anon, you must deactivate it before it's too late!
/// @custom:url https://www.ctfprotocol.com/tracks/eko2022/gas-valve
contract Valve {
    bool public open;
    bool public lastResult;

    function useNozzle(INozzle nozzle) public returns (bool) {
        try nozzle.insert() returns (bool result) {
            lastResult = result;
            return result;
        } catch {
            lastResult = false;
            return false;
        }
    }

    function openValve(INozzle nozzle) external {
        open = true;
        (bool success,) = address(this).call(abi.encodeWithSelector(this.useNozzle.selector, nozzle));
        require(!success);
    }
}
