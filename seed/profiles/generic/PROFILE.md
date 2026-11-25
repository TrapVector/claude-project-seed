# Profile: generic

**Maturity:** Baseline. Use it alone when no specific profile fits, or as the base under one.

## When to use

Any project no specific profile covers: a CLI tool, library, service, script collection, game engine, data job. It asks the questions a specific profile would have answered, so milestone 0 ends with the same set of docs. If a project uses `generic` alone, say so in the final message's seed feedback: it's a sign the seed needs a new profile.

## Questions to add

**Stage 3 (spec):**
- Who or what calls it: people, other programs, a schedule?
- What does it take in and give out? Show one real example of each.
- What does "it worked" look like from the outside? (This becomes the end-to-end test.)

**Stage 5 (stack):**
- Language and runtime, and why. Default: whatever the owner can read best, among languages with strong tooling that run headless in a Linux container.
- How is it distributed: a package registry, a binary download, a container image, a deployed service, not at all?
- Which platforms and versions must it support?

**Stage 6 (workflow):**
- How will the owner check each task's outcome without reading code? (A demo command, sample output in the PR, a preview deploy, a test report.)

**Stage 7 (before you start):**
- Does publishing or deploying need an account (package registry, cloud provider, container registry)? When?

## Stack defaults

Propose per project. Prefer, in order: what the owner can read; tools with a single type checker, linter and test runner that all run from one command; tools Claude knows well; no service accounts until a milestone needs them.

## Commands

Whatever the stack, there must be one **check** command that runs every gate (format check, lint, type check, unit tests, end-to-end or integration tests, any content validation) and exits non-zero on the first failure. Common shapes: `npm run check`, `make check`, `just check`, `./scripts/check.sh`, `cargo xtask check`.

## Architecture rules

Seed-wide rules only (pure core, injectable clock and RNG, platform and service adapters). Name the folders to suit the language's conventions.

## Definition of done additions

- An end-to-end test that runs the real thing the way a user does (runs the CLI binary, calls the service over HTTP, imports the published package), for every new user-facing flow.
- For output a person reads (CLI output, generated files, reports): the PR description includes a sample.

## Cloud environment

- Network: package registries are usually allowed by default; add any toolchain download hosts the stack needs (the install error names them).
- Variables: `CI=true`, and raise `BASH_DEFAULT_TIMEOUT_MS` / `BASH_MAX_TIMEOUT_MS` if builds or tests take more than two minutes.
- Install script: replace `scripts/cloud-install.sh` with one that installs dependencies only when the lockfile changed (see `web-app/files/scripts/cloud-install.sh` for the pattern: a hash of the lockfile stored next to the dependencies).

## Before you start

GitHub App and branch protection (seed-wide), plus whatever publishing or deploying needs, scheduled for the milestone that first needs it.

## Milestone 1 starter tasks

### 1. Scaffold and CI
**Depends on:** nothing. **Touches:** the whole repo.
- The project skeleton in the agreed stack, with the formatter, linter, type checker and test runner configured strictly.
- Every command in `CLAUDE.md` exists and works; the check command passes on the empty project.
- `scripts/cloud-install.sh` installs dependencies in cloud sessions (only when the lockfile changes); `.gitignore` covers build and test output.
- A GitHub Actions workflow runs the check command on every PR and on `main`, and uploads test reports as artifacts.
- Lint rules enforcing the architecture rules in `CLAUDE.md`, with a failing example proven in a test or noted in the PR.
- A placeholder entry point with one end-to-end test.
- **Done when:** a PR shows a green CI check and the artifacts are downloadable.

### 2. Release or deploy path *(parallel ok, if needed in M1)*
- However the thing reaches its users (package, binary, service), make it repeatable from `main`, with the owner connecting any account.
- **Ask first:** where it's published or hosted. Do not create accounts.

## Files

None. Write the CI workflow and install script in milestone 1 task 1 for the chosen stack.

## Known gotchas

- Pin exact versions of anything whose download is cached outside the lockfile (browsers, toolchains), or cloud sessions and CI drift apart.
- Keep Markdown out of the code formatter, or it reformats the hand-written docs and contract files.
