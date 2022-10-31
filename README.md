# ScopeLift Foundry Template

A simple, opinionated template for [Foundry](https://github.com/foundry-rs/foundry) projects.

_**Please read the full README before using this template.**_

## Usage

To use this template, use one of the below approaches:

1. Run `forge init --template ScopeLift/foundry-template` in an empty directory.
2. Click [here](https://github.com/ScopeLift/foundry-template/generate) to generate a new repository from this template.
3. Click the "Use this template" button from this repo's [home page](https://github.com/ScopeLift/foundry-template).

It's also recommend to install [scopelint](https://github.com/ScopeLift/scopelint), which is used in CI.
You can run this locally with `scopelint fmt` and `scopelint check`.
Note that these are supersets of `forge fmt` and `forge fmt --check`, so you do not need to run those forge commands when using scopelint.

## Overview

This template is designed to be a simple but powerful configuration for Foundry projects.

The `foundry.toml` config file comes with:

- A `fmt` configuration.
- `default`, `lite`, and `ci` profiles.

Both of these can of course be modified.
The `default` and `ci` profiles use the same solc build settings, which are intended to be the production settings, but the `ci` profile is configured to run deeper fuzz and invariant tests.
The `lite` profile turns the optimizer off, which is useful for speeding up compilation times during development.

It's recommended to keep the solidity configuration of the `default` and `ci` profiles in sync, to avoid accidentally deploying contracts with suboptimal configuration settings when running `forge script`.
This means you can change the solc settings in the `default` profile and the `lite` profile, but never for the `ci` profile.

Robust CI is also included, with a GitHub Actions workflow that does the following:

- Runs tests with the `ci` profile.
- Verifies contracts are within the [size limit](https://eips.ethereum.org/EIPS/eip-170) of 24576 bytes.
- Runs `slither`, integrated with GitHub's [code scanning](https://docs.github.com/en/code-security/code-scanning). See the [Configuration](#configuration) section to learn more.

The CI also runs [scopelint](https://github.com/ScopeLift/scopelint) to verify formatting and best practices:

- Checks that Solidity and TOML files have been formatted.
  - Solidity checks use the `foundry.toml` config.
  - Currently the TOML formatting cannot be customized.
- Validates test names follow a convention of `test(Fork)?(Fuzz)?_(Revert(If_|When_){1})?\w{1,}`. [^naming-convention]
- Validates constants and immutables are in `ALL_CAPS`.
- Validates internal functions in `src/` start with a leading underscore.
- Validates function names and visibility in forge scripts to 1 public `run` method per script. [^script-abi]

## Configuration

After creating a new repository from this template, make sure to set any desired [branch protections](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches) on your repo.

In [`ci.yml`](.github/workflows/ci.yml), you'll notice Slither is configured as follows:

```yml
slither-args: --filter-paths "./lib|./test" --exclude naming-convention
```

This means Slither is not run on the `lib` or `test` folders, and the `naming-convention` check is disabled.
This `slither-args` field is where you can change the Slither configuration for your project.

For more information on configuration Slither, see [the documentation](https://github.com/crytic/slither/wiki/Usage). For more information on configuring the slither action, see the [slither-action](https://github.com/crytic/slither-action) repo.

### GitHub Code Scanning

As mentioned, the Slither CI step is integrated with GitHub's [code scanning](https://docs.github.com/en/code-security/code-scanning) feature.
This means when your jobs execute, you'll see two related checks:

1. `CI / slither-analyze`
2. `Code scanning results / Slither`

The first check is the actual Slither analysis.
You'll notice in the [`ci.yml`](.github/workflows/ci.yml) file that this check has a configuration of `fail-on: none`.
This means this step will _never_ fail CI, no matter how many findings there are or what their severity is.
Instead, this check outputs the findings to a SARIF file[^sarif] to be used in the next check.

The second check is the GitHub code scanning check.
The `slither-analyze` job uploads the SARIF report to GitHub, which is then analyzed by GitHub's code scanning feature in this step.
This is the check that will fail CI if there are Slither findings.

By default when you create a repository, only alerts with the severity level of `Error` will cause a pull request check failure, and checks will succeed with alerts of lower severities.
However, you can [configure](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#defining-the-severities-causing-pull-request-check-failure) which level of slither results cause PR check failures.

It's recommended to conservatively set the failure level to `Any` to start, and to reduce the failure level if you are unable to sufficiently tune Slither or find it to be too noisy.

Findings are shown directly on the PR, as well as in your repo's "Security" tab, under the "Code scanning" section.
Alerts that are dismissed are remembered by GitHub, and will not be shown again on future PRs.

Note that code scanning integration [only works](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/setting-up-code-scanning-for-a-repository) for public repos, or private repos with GitHub Enterprise Cloud and a license for GitHub Advanced Security.

## Development

This project uses [Foundry](https://github.com/foundry-rs/foundry).

If this project needs something other than the vanilla commands like `forge test`, or needs environment variables or RPC URLs, mention that here.

## Other stuff

Create other sections/content as needed.

[^naming-convention]:
    A rigorous test naming convention is important for ensuring that tests are easy to understand and maintain, while also making filtering much easier.
    For example, one benefit is filtering out all reverting tests when generating gas reports.

[^script-abi]: Limiting scripts to a single public method makes it easier to understand a script's purpose, and facilitates composability of simple, atomic scripts.
[^sarif]:
    [SARIF](https://sarifweb.azurewebsites.net/) (Static Analysis Results Interchange Format) is an industry standard for static analysis results.
    You can read learn more about SARIF [here](https://github.com/microsoft/sarif-tutorials) and read about GitHub's SARIF support [here](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning).
