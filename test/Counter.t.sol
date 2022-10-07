// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Test.sol";
import {Counter} from "src/Counter.sol";

contract CounterTest is Test {
  Counter public counter;

  function setUp() public {
    counter = new Counter();
    counter.setNumber(0);
  }

  function testIncrement1() public {
    counter.increment();
    assertEq(counter.number(), 1);
  }

  function test_SetNumber(uint x) public {
    counter.setNumber(x);
    assertEq(counter.number(), x);
  }
}
