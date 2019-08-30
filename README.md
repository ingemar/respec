# respec

No-nonsense *rspec* and *rubocop* re-runner.

## How it works

`respec` parses your `git status` and try to figure out relevant specs to run.
If you change a file in the `app/` or `lib/` directories it tries to find a
corresponding spec file to run. Changed files in `spec/` are also included.

## Installation

Check out this directory and make an `alias` to the binaries in
your `.bash_profile` or whatever.

Example:
```bash
alias respec="~/tools/respec/bin/respec"
alias recop="~/tools/respec/bin/recop"
```

## FAQ

**
