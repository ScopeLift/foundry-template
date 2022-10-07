# ScopeLift Foundry Template

_Work in progress, not ready for use_

A simple, opinionated template for [Foundry](https://github.com/foundry-rs/foundry) projects.

## Overview

Features:

- `foundry.toml` configured with `default`, `lite`, and `ci` profiles.
- `foundry.toml` configured witha `fmt` configuration.
- CI configured to verify contracts are're within the size limit.
- CI configured to run tests with the `ci` profile.
- CI configured to run `slither`, integrated with GitHub's [code scanning](https://docs.github.com/en/code-security/code-scanning).
- CI configured to run [scopelint](https://github.com/ScopeLift/scopelint), which:
  - Verifies formatting of solidity and TOML files.
  - Verifies test names follow a naming convention of `test(Fork)?(Fuzz)?_(Revert(If_|When_){1})?\w{1,}`
  - More stuff coming soon, see scopelint README for details.

## Development

This project uses [Foundry](https://github.com/foundry-rs/foundry).

If this project needs something other than the vanilla commands like `forge test`, or needs environment variables or RPC URLs, mention that here.

## Other stuff

Create other sections/content as needed.
