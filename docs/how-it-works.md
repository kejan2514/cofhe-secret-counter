# How CoFHE Secret Counter Works

## Overview

CoFHE Secret Counter is a simple educational project that demonstrates how encrypted values can be stored and updated inside a smart contract.

Unlike a traditional Solidity counter, the value is not stored as a publicly readable integer. The counter remains encrypted while the smart contract performs operations on it.

## Traditional Counter

A normal Solidity counter may use a public value:

```solidity
uint256 public counter;
