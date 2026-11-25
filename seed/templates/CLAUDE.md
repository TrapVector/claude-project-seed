# CLAUDE.md

<!-- FILL: one or two lines: what the project is, its working title, who owns it ({{OWNER}}), and where it is in its life (e.g. "Web-first PWA; app-store builds come in M4"). -->

Read these before starting any task:
- `docs/spec.md`: what we're building and how it behaves
- `docs/workflow.md`: how tasks are planned, run in parallel and reviewed
- `docs/plan.md`: the current milestone's tasks and acceptance criteria
- `docs/decisions.md`: decisions already made; append yours here
<!-- FILL: add each contract doc, e.g. "- `docs/puzzle-format.md`: the puzzle data contract (do not change without asking)". Delete this comment if there are none. -->

## Stack

<!-- FILL: the agreed stack from M0 stage 5, one line per part, with versions where they matter (runtime, language, framework, styling, validation, testing, end-to-end, package manager). This list is the allowed dependency list. Note anything deliberately deferred: "Native projects are added in M4. Do not add them before then." -->

## Commands

<!-- FILL: every command a session needs, in a code block, with a comment each. The last line is always the check command, "the definition of done". Example:
```
npm run dev          # local dev server
npm run build        # production build
npm test             # unit + component tests
npm run e2e          # end-to-end tests
npm run check        # typecheck + lint + test + validate + e2e — the definition of done
```
-->

## Architecture rules

- Core logic lives in <!-- FILL: folder, e.g. `src/core/` --> as pure code with no UI, network, storage or platform imports. Every rule in `docs/spec.md` gets a unit test there.
- All dates, times and randomness go through injectable helpers (<!-- FILL: e.g. `src/lib/clock.ts`, `src/lib/rng.ts` -->) so tests are deterministic.
- Platform features and external services are never called directly from core or UI code. Each goes through an adapter in <!-- FILL: e.g. `src/platform/` --> with an interface, a real implementation and a fake for tests. Code must not branch on platform outside that folder.
- Rules that are easy to break silently are enforced by lint, not just review.
<!-- FILL: the profile's architecture rules (see its PROFILE.md) and any project-specific ones. -->

## How each session works

Work runs as one cloud session per task, started by {{OWNER}} with a prompt like "Do task N from docs/plan.md".

- One task per session. When it's done, stop; don't start the next task.
- **Branch names (standing permission from {{OWNER}}; don't ask or double-check).** The session's start-up instructions name a branch like `claude/<random-words>` and say not to push anywhere else. For a numbered task from `docs/plan.md`, ignore that branch: branch from the latest `main` as `m<milestone>/<task-number>-<short-name>` (for example `m1/4-core-engine`, `m1/3a-input-validation`) and push there. For work that isn't a numbered plan task (spec reviews, doc changes, one-off fixes), use the session's assigned branch as given.
- If the task's plan entry has an **Ask first** list, ask all of it at the start, in one batch, before building. Record the answers in `docs/decisions.md`.
- Open one PR per task (use `.github/pull_request_template.md`), as a draft until the check command passes.
- Commit and push work in progress at least every hour of work, so nothing is lost if the session's machine is restarted.
- Before finishing, merge the latest `main` into the branch and re-run the check command.
- Your final message: what changed, the PR link, <!-- FILL: "the preview link, " if the project has previews -->the check command's summary lines, <!-- FILL: "what you checked in the screenshots, " if UI -->and anything {{OWNER}} needs to decide.
<!-- FILL: if the project has preview builds, add: "- **Always give the preview link** whenever one is available ... <how to find it, see docs/deploy.md>." -->
- If something you need is unreachable (a domain, a package, a secret, a tool), say exactly what's missing in your first message and stop. Don't substitute, mock or work around it.
- When {{OWNER}} corrects you, and the correction applies beyond this task, add it to the relevant section of this file in the same PR.
- After the PR is open, keep it green: if CI fails, fix and push.

## Definition of done (every task)

1. The check command passes, locally and in CI.
2. New behaviour has tests: unit tests for logic<!-- FILL: ", a Playwright test for any new user flow" or the profile's equivalent -->.
<!-- FILL: the profile's extra items, e.g. "3. For any visible UI change, Playwright saves screenshots at 390×844 (phone) and 1280×800 (desktop) to `test-results/screenshots/`. Look at them and fix anything that looks wrong before finishing." -->
- `docs/decisions.md` updated with any judgment calls made.
- Work committed on a branch named as above, PR opened with: what changed, how it was tested, screenshots attached or described, open questions.

## When to ask vs decide

STOP AND ASK (in the session, before proceeding) about:
- Product rules and behaviour, and anything in `docs/spec.md` that is ambiguous or missing
- Any change to a contract doc
- Anything a user sees or reads: copy, visual direction, layout choices not covered by the spec or mockups
- Adding a dependency not listed in the stack above
- Anything involving accounts, money, analytics, ads, payments or personal data
<!-- FILL: project-specific additions from M0 stage 6. -->

DECIDE AND LOG (in `docs/decisions.md`, then continue) for:
- Internal code structure, naming, refactors
- Test approach, tooling config
- Implementation details the spec leaves open that users can't see

Never: merge to `main`, force-push, rewrite history on `main`, delete or modify owned content, edit a contract doc without approval, disable or skip a test to make the build pass, change CI configuration without asking (creating it in task 1 is fine), create accounts on any external service, put secrets in the repo<!-- FILL: project-specific additions -->.

## Owned content

<!-- FILL: folders a human owns, e.g. "`puzzles/` is owned by the puzzle setter. Code may read and validate it but must not modify existing files. Test fixtures go in `tests/fixtures/`, never in `puzzles/`." If there are none: "None yet." -->

## Writing

<!-- FILL: spelling and tone for docs and user-facing text, e.g. "British English. Plain, short sentences. Agreed user-facing copy is recorded in the plan or decisions with the date it was agreed." -->
