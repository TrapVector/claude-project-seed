# Claude project seed

A starting point for building software with Claude Code, one cloud session per task. It turns an idea into a project that Claude can build task by task, with you reviewing pull requests and preview builds.

You don't fill in a pile of templates up front. You start one Claude Code session and say **"Let's set up milestone 0 together."** Claude interviews you in stages and writes the project's docs as you agree them:

- `CLAUDE.md`: the rules every session follows (stack, commands, architecture, ask-vs-decide, definition of done)
- `docs/spec.md`: what you're building and how it behaves
- `docs/workflow.md`: how tasks are planned, run (including in parallel) and reviewed
- `docs/before-you-start.md`: the accounts, environment and secrets you need to set up, and when
- `docs/roadmap.md`: milestones M1 onwards, each with a goal and an exit check
- `docs/plan.md`: milestone 1, broken into tasks with acceptance criteria
- `docs/decisions.md`: every decision made so far, and who made it
- `setup/`: guides for you (cloud environment, starting sessions, local fallback)

Milestone 0 produces documents only. Milestone 1, task 1 is always "scaffold and CI".

## Using it

1. **Make the project repo.** On this seed's GitHub page, click **Use this template → Create a new repository**. You get a fresh repo with no shared history. (If you have the seed as a zip instead: make an empty repo, unzip into it, commit, push to `main`.)
2. **Install the Claude GitHub App** on the new repo (github.com/apps/claude), so sessions can push branches and open pull requests.
3. **Optional: write your brief.** Put the idea in your own words in `docs/brief.md` and commit it. Anything you leave blank, Claude asks about. Nothing else needs filling in first.
4. **Start a session** at claude.ai/code (or the desktop or mobile app): pick the repo, the default environment is fine for milestone 0, then send:

   > Let's set up milestone 0 together.

5. **Talk it through.** Claude works through the stages in `seed/m0-playbook.md`, asking a few questions at a time with a recommended answer for each. It commits as it goes, so you can stop and resume in a new session ("Continue milestone 0").
6. **Merge the pull request** when Claude reports milestone 0 done. The seed's own files (`seed/`) are deleted in that PR, so the project holds only its own docs.
7. Do the "before milestone 1" items in `docs/before-you-start.md`, then start milestone 1 with "Do task 1 from docs/plan.md".

## What's in here

| Path | Purpose |
| :- | :- |
| `CLAUDE.md` | Bootstrap rules: tells Claude this is an unconfigured seed and how to run milestone 0. Replaced at the end of M0. |
| `docs/brief.md` | Optional: your idea in your own words. |
| `seed/m0-playbook.md` | The staged interview Claude follows. |
| `seed/questions.md` | Question bank for each stage. |
| `seed/templates/` | The project docs, with `<!-- FILL -->` sections. |
| `seed/profiles/` | Project-type templates (stack defaults, CI, cloud environment notes, M1 starter tasks). |
| `seed/why-it-works.md` | The practices this seed is built on, and where they came from. |
| `seed/check.sh` | M0's definition of done: every required doc exists and nothing is left unfilled. |
| `.claude/settings.json`, `scripts/cloud-install.sh` | Cloud session hook and a force-push block. Milestone 0 tailors the install script to the stack. |

## Improving the seed

See `seed/README.md`. In short: improvements you discover in a project (a new rule in its `CLAUDE.md`, a gotcha in its decisions log) are copied back here by hand, and new project types become new profiles.
