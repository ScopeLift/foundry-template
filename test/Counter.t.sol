// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.35;

// forge-lint: disable-start(unused-import)
// scopelint: ignore-import-next-line
import {console2} from "forge-std/Test.sol";
// forge-lint: disable-end(unused-import)

import {Test} from "forge-std/Test.sol";
import {Deploy} from "script/Deploy.s.sol";
import {Counter} from "src/Counter.sol";

contract CounterTest is Test, Deploy {
  Counter counter;

  function setUp() public {
    counter = Deploy.run();
  }
}

contract Increment is CounterTest {
  function test_NumberIsIncremented() public {
    counter.increment();
    assertEq(counter.number(), 1);
  }
}

contract SetNumber is CounterTest {
  function testFuzz_NumberIsSet(uint256 _newNumber) public {
    counter.setNumber(_newNumber);
    assertEq(counter.number(), _newNumber);
  }
}
