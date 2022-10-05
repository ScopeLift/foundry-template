// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Counter {
  uint public number;

  function setNumber(uint newNumber) public {
    number = newNumber;
  }

  function increment() public {
    number++;
  }
}
