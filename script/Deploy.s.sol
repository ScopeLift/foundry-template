// SPDX-License-Identifier: UNLICENSED
// slither-disable-start reentrancy-benign

pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {Counter} from "src/Counter.sol";

contract Deploy is Script {
  function run() public returns (Counter _counter) {
    vm.broadcast();
    _counter = new Counter();
  }
}
