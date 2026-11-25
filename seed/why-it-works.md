# Why this works

The practices behind this seed, drawn from a project built this way (a daily puzzle game: 12+ milestone tasks, each one cloud session and one PR, in about a week, with the owner spending their time on reviews and content rather than code). Each practice says what problem it solves, so you can tell when one should be bent rather than followed blindly.

Milestone 0 must carry every practice here into the project's docs, unless the owner decides otherwise and it's logged.

## 1. The repo is the memory

Every session starts cold. Anything agreed in a conversation and not written down is lost by the next task. So:

- **`CLAUDE.md` holds the standing rules**, short enough to read every session: stack, commands, architecture rules, ask-vs-decide, definition of done, never-list.
- **`docs/spec.md` holds behaviour**, written as rules that each become a test.
- **`docs/decisions.md` is an append-only log** of every judgment call, with who made it and when to revisit it. It stops sessions re-asking settled questions and stops them silently reversing earlier choices.
- **Owner's answers are logged too** ("Task 5: owner's answers on the play screen"), not left in a chat transcript.
- **Corrections that apply beyond the current task go into `CLAUDE.md` in the same PR.** The rule "always give the preview link" and the branch-naming permission both started as one-off corrections.

## 2. Small tasks with explicit acceptance criteria

- **One task = one session = one branch = one PR.** Small PRs are reviewable on a phone; a fresh session per task is cheaper and avoids stale context.
- **Every task has "Done when"**: observable outcomes, not activities. Sessions stop when it's met, not when they run out of ideas.
- **"Ask first" lists in the plan** let a session collect all the owner's decisions up front, then work unattended.
- **Tasks are added as needs appear** (task 3a appeared when an open question showed a gap), numbered so they slot in without renumbering.
- **Stop after the task.** Sessions don't drift into the next one.

## 3. One command defines done

A single `check` command runs every gate: types, lint, unit and component tests, content validation, end-to-end tests. It runs identically in a cloud session and in CI. "Done" isn't a feeling; it's `check` passing plus the review items below. Rules that are easy to break silently (pure logic has no UI imports; no platform branching outside adapters) are enforced by lint, not by review.

## 4. Ask vs decide is written down

The most valuable section of `CLAUDE.md`. It splits decisions into:

- **Stop and ask:** product rules, anything a user sees or reads, contract changes, new dependencies, accounts, money, personal data.
- **Decide and log:** internal structure, naming, test approach, invisible implementation details.
- **Never:** merge to `main`, force-push, delete owner content, skip or disable tests to go green, change CI without asking, create accounts.

Without it, sessions either ask about everything (the owner becomes the bottleneck) or decide things they shouldn't (the owner loses control of the product).

## 5. Spec review in rounds, with numbered open questions

The spec was drafted by the owner, then reviewed by Claude in three rounds before any feature code. Each round: Claude lists ambiguities as numbered questions (O1, O2, …), the owner answers in a batch, answers go into the spec and the decisions log. Numbering never restarts, so "O13" means the same thing everywhere. Contract docs (the puzzle data format) were marked DRAFT until approved, then frozen as v1; changing them needs the owner's approval.

## 6. Architecture that keeps tests deterministic and the future cheap

- **Pure core logic** in its own folder with no UI or I/O imports; every spec rule gets a unit test there.
- **Injectable clock and randomness**, so date- and luck-dependent behaviour is tested exactly (streaks across month ends, midnight rollovers).
- **Platform features behind adapters** (an interface, a real implementation, a fake for tests), so later platforms (app stores, native features, ads, payments) don't need a rewrite, and the cloud container can test everything.

## 7. The owner reviews outcomes, not code

- **Preview builds on every PR**, opened on the owner's own phone. The final message always gives the preview link.
- **Screenshots at fixed viewports**, saved by the end-to-end tests and looked at by Claude before finishing, and uploaded by CI. Saved, not pixel-diffed: font rendering differs between machines and diffs fail randomly.
- **A fixed final-message format**: what changed, PR link, preview link, check summary, what was checked in screenshots, what the owner needs to decide.
- **Keep the PR green** after opening it: CI failures are the session's to fix.

## 8. Clear boundaries between people and Claude

- **Owned content** (the puzzle files) belongs to a human; code may read and validate it, never modify it. Test fixtures live elsewhere.
- **Claude never creates accounts or handles secret values.** The owner connects services; Claude writes the config and the exact dashboard steps (`docs/deploy.md`), with a test guarding the config files.
- **If something is unreachable, stop and say exactly what's missing.** Don't mock or work around a missing domain, package or secret: the workaround hides the problem.

## 9. Standing permissions remove friction

Cloud sessions are told to push only to a randomly named branch. That conflicted with the project's `m0/<task>-<name>` convention, so every session stopped to check, until the convention was written into `CLAUDE.md` as a standing permission. Anywhere sessions keep stopping to ask the same thing, write the answer down once.

## 10. Environment set up once, reproducibly

A named cloud environment (network allowlist for the test browser's download hosts, timeouts raised for builds), a setup script that pre-warms heavy installs, and a `SessionStart` hook that installs dependencies only when the lockfile changed. Tool versions that must match a cached download (the test browser) are pinned exactly.

## 11. Parallel work without collisions

Tasks marked *(parallel ok)* ran alongside others. What made that safe, and what this seed adds:

- Contracts agreed first, so parallel tasks build against the same interface.
- Each task lists what it **Touches**, so two parallel tasks don't edit the same files.
- The decisions log is append-only and set to `merge=union` in `.gitattributes`, so when a session merges `main` in locally, parallel entries are both kept (the original project hit exactly this conflict). GitHub's web conflict check ignores the setting, which is why sessions merge `main` locally before finishing.
- Each session branches from the latest `main` and merges `main` in before finishing.
- Start with at most two sessions at once; add more as trust grows.

## 12. Things that didn't work, or came late

- A coordinator "project" session was planned and dropped because it wasn't available; nothing depended on it. Keep the workflow working with plain sessions.
- The branch-name friction (§9) and the preview-link rule (§7) cost several sessions before being written down. The seed starts with both.
- Merge conflicts in the decisions log between parallel PRs (§11).
