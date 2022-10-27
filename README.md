# ScopeLift Foundry Template

A simple, opinionated template for [Foundry](https://github.com/foundry-rs/foundry) projects.

## Overview

Features:

- `foundry.toml` configured with `default`, `lite`, and `ci` profiles.
- `foundry.toml` configured with a `fmt` configuration (which you can of course change).
- CI configured to verify contracts are within the size limit.
- CI configured to run tests with the `ci` profile.
- CI configured to run `slither`, integrated with GitHub's [code scanning](https://docs.github.com/en/code-security/code-scanning). _Note that code scanning integration [only works](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/setting-up-code-scanning-for-a-repository) for public repos, or private repos with GitHub Enterprise Cloud and a license for GitHub Advanced Security._
- CI configured to run [scopelint](https://github.com/ScopeLift/scopelint), which:
  - Verifies formatting of solidity (with `forge fmt`) and TOML (with `taplo`) files.
  - Validates test names follow a convention of `test(Fork)?(Fuzz)?_(Revert(If_|When_){1})?\w{1,}`.
  - Validates constants and immutables are in `ALL_CAPS`.
  - Validates function names and visibility in forge scripts to 1 public `run` method per script.
  - Validates internal functions in `src/` start with a leading underscore.

Configuration:

- Make sure to set any desired [branch protections](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches) on your repo.
- You can [configure](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#defining-the-severities-causing-pull-request-check-failure) which level of slither results cause PR check failures.
  By default, only alerts with the severity level of `Error` or security severity level of `Critical` or `High` will cause a pull request check failure, and a check will still succeed with alerts of lower severities.

## Development

This project uses [Foundry](https://github.com/foundry-rs/foundry).

If this project needs something other than the vanilla commands like `forge test`, or needs environment variables or RPC URLs, mention that here.

## Other stuff

Create other sections/content as needed.
