// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import {Counter} from "src/Counter.sol";

contract Deploy is Script {
  Counter counter;

  function run() public {
    // Commented out for now until https://github.com/crytic/slither/pull/1461 is released.
    // vm.startBroadcast();
    counter = new Counter();
  }
}
