# Milestone 0 playbook

You (Claude) are running milestone 0 with the project's owner. The goal is a project that later sessions can build without you: every rule, decision and plan they need is written down in the repo, because **the next session starts cold and knows only what's in the repo**.

Milestone 0 ends with documents. No application code, no dependencies, no scaffold.

## Exit criteria

Milestone 0 is done when:

1. These files exist, filled in, with no `<!-- FILL` markers or `{{PLACEHOLDERS}}` left: `CLAUDE.md`, `README.md`, `docs/spec.md`, `docs/workflow.md`, `docs/before-you-start.md`, `docs/roadmap.md`, `docs/plan.md`, `docs/decisions.md`, `docs/task-brief-template.md`, `setup/cloud-environment.md`, `setup/starting-sessions.md`, `.github/pull_request_template.md`, `.claude/settings.json`, `scripts/cloud-install.sh`. Plus any contract docs (stage 4) and profile files (stage 10).
2. Every open question in `docs/spec.md` that milestone 1 depends on is answered. Questions for later milestones may stay open, numbered, with the milestone they block.
3. Every milestone 1 task has a **Done when** the owner agreed to, and task 1 is "scaffold and CI".
4. `bash seed/check.sh` passes, then `seed/` and `docs/brief.md` are deleted.
5. The pull request is open and marked ready, and the owner has the final message (see stage 10).

## How to run the interview

- **Stages in order.** Each stage below names its inputs, what to ask, and what to write. Don't jump ahead to the stack or plan before the owner has said what they're building.
- **A few questions at a time.** Ask 3 to 5 related questions per turn, never a wall of 20. Use the multiple-choice question tool when the session has one and the answer fits a short list; put your recommended option first and say why in one line. Open questions ("describe the idea") go in plain text.
- **Recommend, don't survey.** For every choice, give a recommendation and its main trade-off. The owner can always answer "you decide": then decide, and log it as your decision.
- **Draft, then review.** For stages that produce a document, write a draft from what you know, then ask numbered review questions about it (O1, O2, …), as a spec review round. Repeat rounds until the owner is happy. Two or three rounds is normal for the spec.
- **Write it down as you go.** When something is agreed, put it in its document straight away and log it in `docs/decisions.md` (who decided: owner, or Claude). Don't keep agreements in the conversation only.
- **Commit and push after every stage**, with a message like `M0 stage 3: spec draft, review round 1`. Update the progress checklist in the PR description.
- **Read what's there first.** `docs/brief.md` may already answer some questions; don't ask them again, confirm them in one line.
- **Use the owner's words.** Keep their terms for things in their domain. Ask before inventing names for anything a user will see.
- **Don't pad.** A small project gets short docs. A section that doesn't apply says "Not applicable: <reason>" in one line, rather than being invented. Remove template guidance comments once a section is filled in.
- **Facts about tools and services change.** When a stage depends on current details (prices, free tiers, a service's setup steps, the cloud environment's settings), check the current documentation if the session can reach it, and say when you couldn't.

## Resuming

If `m0/setup` already exists: check it out, read `git log` and the PR description's checklist, read every doc written so far, tell the owner in two or three lines where things stand, and continue from the first unfinished stage.

---

## Stage 0. Orient

**Do:**
1. Create the branch `m0/setup` from `main` (see `CLAUDE.md`).
2. Read `docs/brief.md`, `seed/why-it-works.md`, `seed/profiles/README.md`, and skim the templates.
3. Check the repo: is there a GitHub remote, and can you push? If pushing fails, say exactly what's missing (usually the Claude GitHub App on the repo) and stop.
4. Copy `seed/templates/docs/decisions.md` to `docs/decisions.md` and add the first entry: started from the seed (version from `seed/VERSION`), on today's date.

**Ask** (stage 0 in `seed/questions.md`): the owner's name as it should appear in the docs, their role and how much time they have, how they like questions batched, spelling and tone for docs and copy.

**Then:** commit, push, open the draft PR titled "Milestone 0: project setup" using the checklist below as its body, and tell the owner the plan in a few lines: the stages, roughly how long, that they can stop any time and resume.

PR checklist (keep it updated):

```
- [ ] 0. Orient
- [ ] 1. Vision and goals
- [ ] 2. Project type and profile
- [ ] 3. Spec (review rounds: 0)
- [ ] 4. Contracts and owned content
- [ ] 5. Tech stack
- [ ] 6. Workflow and rules
- [ ] 7. Before you start
- [ ] 8. Roadmap
- [ ] 9. Milestone 1 plan
- [ ] 10. Finalise
```

## Stage 1. Vision and goals

**Ask:** stage 1 questions. What it is, who it's for, why it should exist, what success looks like and how it's measured, constraints (time, budget, platforms, skills), what's explicitly out, and whether it's confidential.

**Write:** `docs/spec.md` from `seed/templates/docs/spec.md`, sections 0 to 3 (confidentiality, overview, users, goals and success measures). If confidential, keep the notice in §0; otherwise delete §0.

## Stage 2. Project type and profile

**Read** `seed/profiles/README.md` and each profile's "When to use".

**Ask:** what kind of software it is (stage 2 questions), and confirm a profile. A project can combine profiles (for example `web-app` plus a backend), with `generic` as the base for anything not covered.

If no profile fits well, use `generic`, and tell the owner the seed would benefit from a new profile for this type: note it under "Seed feedback" in the final message.

**Write:** a decisions entry naming the profile(s) and why. Read the chosen `PROFILE.md` files fully now; they add questions to stages 3 to 9.

## Stage 3. Spec

**Ask:** stage 3 questions plus the profile's spec questions. Focus on behaviour: rules, flows, screens or interfaces, states, edge cases, errors, data kept, non-functional needs (accessibility, performance, privacy, security, offline).

**Write:** the rest of `docs/spec.md`. Then run review rounds:
1. Re-read the spec as if you were the session that has to build milestone 1 from it. List every ambiguity, contradiction, missing rule or untestable statement as numbered open questions in spec §"Open questions" (O1, O2, … numbering never restarts).
2. Ask them in batches. Record the answers in the spec, strike resolved ones through with the date (`~~O4 …~~ Resolved 2026-…: …`), and log each round in decisions as "Spec review, round N".
3. Stop when nothing milestone 1 needs is open. Remaining questions get "Blocks: M<n>".

Rules in the spec should be written so each one can become a named test.

## Stage 4. Contracts and owned content

A **contract** is anything other code, people or stored data depend on staying stable: a file format, an API, a database schema, a message format, a public CLI interface. **Owned content** is anything a human, not Claude, creates and owns (puzzle files, articles, translations, design assets).

**Ask:** stage 4 questions. Is there content a human will author? Is there a data format, API or schema that should be agreed before coding?

**Write:** for each contract, `docs/<name>-format.md` (or `-api.md`) from `seed/templates/docs/contract.md`, versioned, with validation rules numbered so each becomes a test. Mark it DRAFT until the owner approves, then v1. Owned-content folders and contract docs get listed in `CLAUDE.md` (stage 10) with "don't change without asking". If there are none, log that and move on.

## Stage 5. Tech stack

**Propose** a stack from the profile's defaults, adjusted to what the spec and constraints need. For each part: the choice, why, the main alternative, and the cost (money, lock-in, learning). Keep it boring where it can be: well-known, well-documented tools that Claude knows well and that run headless in a cloud container.

**Ask:** the owner to confirm or change each part. Also: languages they can read, where it runs, what they already pay for.

**Write:** the stack list (it becomes `CLAUDE.md` §Stack, and is the **allowed dependency list**: anything else needs asking), the commands (`check` and its parts), and a decisions entry per significant choice. Note which packages arrive with which milestone 1 task.

The single `check` command is the project's definition of done. It must run every automated gate (types, lint, tests, validation, end-to-end) and must run in CI and in a cloud session alike.

## Stage 6. Workflow and rules

**Read** `seed/templates/docs/workflow.md` and `seed/templates/CLAUDE.md`. These carry practices that are the same for every project; this stage tailors the parts that vary.

**Ask:** stage 6 questions: how they'll review (phone, desktop, PR diffs, preview builds), how many sessions they want running in parallel, what Claude must always ask about beyond the defaults, what Claude must never do, owned paths, model and effort preferences, how they want the final message of each task.

**Write:** `docs/workflow.md` (from the template, tailored) and the "When to ask vs decide", "Never" and "How each session works" sections of `CLAUDE.md` (draft it now in place; stage 10 finalises it). Add the profile's architecture rules and definition-of-done additions.

## Stage 7. Before you start

**Collect** everything the owner must set up that Claude can't: accounts (hosting, app stores, payments, analytics, domains), GitHub settings, the cloud environment (network allowlist, environment variables, setup script), secrets and where they live, local tools, devices for testing. Include the profile's list.

**Ask:** which accounts they already have, who pays, which domains to allow, and when each item is needed.

**Write:** `docs/before-you-start.md` from the template, grouped by when it's needed (before M1 task 1, before task N, before milestone N), each item with exact steps, who does it, and how to check it worked. Write `setup/cloud-environment.md` with the exact environment name, network hosts, variables and setup script. Never ask for secret values in chat: say where they go (environment settings, CI secrets) and that the owner enters them there.

If the session has environment tools (for example ones that propose or create a cloud environment for the owner to approve), offer to set up the environment that way, as well as writing the guide.

## Stage 8. Roadmap

**Ask:** stage 8 questions: the first thing a real person should be able to use, what comes after, what would make the owner stop or change direction, any dates.

**Write:** `docs/roadmap.md`. Milestones M1 onwards, each with: goal (one sentence a user would understand), scope in and out, exit check (measurable, including a go/no-go if relevant), and what's deliberately deferred and to which milestone. M1 should be the smallest thing that tests the riskiest assumption. Later milestones can be rough; they get planned in detail when they start.

## Stage 9. Milestone 1 plan

**Write:** `docs/plan.md` from the template. Tasks numbered 1, 2, …, each a single session's work (roughly an hour or two of Claude time, one PR). Task 1 is scaffold and CI, from the profile. Each task has:

- what to build, in enough detail that a cold session can do it,
- **Depends on** and *(parallel ok)* marks, and **Touches** (folders or files), so parallel tasks don't collide,
- **Ask first:** decisions the session must get from the owner before building (so it asks them all at the start, then works unattended),
- **Done when:** observable, testable acceptance criteria.

End with the milestone 1 exit check from the roadmap.

**Ask:** the owner to review the plan as a whole: order, size, anything missing. Revise.

## Stage 10. Finalise

1. Write `CLAUDE.md` from `seed/templates/CLAUDE.md`, filling every section from the decisions so far. Keep it short: it's read at the start of every session. Detail belongs in `docs/`.
2. Write the other templates into place if not already done: `docs/task-brief-template.md`, `setup/starting-sessions.md`, `setup/local-setup.md` (if the owner wants a local fallback), `.github/pull_request_template.md`, `README.md` (from `seed/templates/README.md`).
3. Copy the chosen profiles' `files/` into place (CI workflow, install script, deploy doc), adjusting names. If a file is only needed by a later task, leave it for that task and say so in the plan instead.
4. Move anything left in `docs/brief.md` into the spec, then delete it.
5. Run `bash seed/check.sh`. Fix everything it reports.
6. Add a final decisions entry: "Milestone 0 complete", listing the profile(s), seed version, and anything left open.
7. Delete `seed/`. Commit, push, mark the PR ready.
8. Final message to the owner:
   - what was set up (one line per doc),
   - the PR link,
   - **before milestone 1:** the items from `docs/before-you-start.md` they must do before task 1, in order,
   - the prompt to start milestone 1: "Do task 1 from docs/plan.md",
   - open questions still waiting on them,
   - **seed feedback:** anything about the seed that was missing, awkward or wrong in this session (a missing question, a profile that didn't fit), so the owner can improve the seed.

Then stop. Don't start milestone 1.
