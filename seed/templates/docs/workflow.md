# Workflow

How work is planned, run and reviewed on this project. `CLAUDE.md` holds the rules every session must follow; this doc explains the method behind them, for {{OWNER}} and for sessions planning work. When the two disagree, `CLAUDE.md` wins; fix this doc.

## The loop

1. **Plan.** Each milestone in `docs/roadmap.md` gets a plan in `docs/plan.md`: numbered tasks, each one session's work, each with **Done when**.
2. **Start.** {{OWNER}} starts a cloud session per task: "Do task N from docs/plan.md". For work not in the plan, a brief from `docs/task-brief-template.md`.
3. **Ask first.** The session reads the docs, asks every question on the task's **Ask first** list (plus anything the spec leaves open) in one batch, and logs the answers.
4. **Build.** The session works unattended: branch, code, tests, the check command, screenshots, WIP commits every hour, a draft PR.
5. **Review.** {{OWNER}} reviews the outcome: <!-- FILL: how, from M0 stage 6, e.g. "the preview build on a phone, then the screenshots and PR description; the diff only for contract or architecture changes" -->. Feedback goes back in the same session ("The toast overlaps the keyboard on the phone screenshot; fix and push to the same PR"), or as a PR comment.
6. **Merge.** {{OWNER}} merges when satisfied. Claude never merges.
7. **Learn.** Corrections that apply beyond the task go into `CLAUDE.md` in the same PR. New tasks discovered along the way are added to the plan (as `3a`, `3b` … so nothing renumbers).

## Planning tasks

- **Size.** One task is something {{OWNER}} can review in one sitting, and a session can finish in roughly one to two hours of work. Split anything bigger.
- **Acceptance criteria are outcomes**, not activities: "a player can reach the bug form from every screen in one tap", not "add bug links".
- **Ask first** lists the decisions only {{OWNER}} can make, so the session collects them up front. If {{OWNER}} answers some while planning, write the answers into the task ("Agreed YYYY-MM-DD: …").
- **Depends on / parallel ok / Touches.** Every task says which tasks must land before it, whether it can run alongside the previous one, and which folders or files it changes.
- **Contracts before consumers.** A data format, API or schema that several tasks rely on is agreed (and its validator built) before the tasks that use it.
- **Milestones end with an exit check**: measurable, with a go/no-go if the next milestone depends on it.

## Running sessions in parallel

Parallel sessions multiply throughput, but each one also multiplies review load and the chance of collisions.

- **How many.** <!-- FILL: from M0 stage 6. Default: "At most two at once until the loop is trusted; then up to four, all marked parallel ok." -->
- **Only tasks marked *(parallel ok)*** run alongside others, and only if their **Touches** don't overlap.
- **Shared files.** `docs/decisions.md` is append-only and set to `merge=union`, so when a session merges `main` into its branch, both sides' entries are kept. Other shared files (`CLAUDE.md`, `docs/plan.md`, config) are edited by one open PR at a time where possible; if two must, the second merges `main` in and resolves conflicts before finishing.
- **Branch from the latest `main`, merge `main` in before finishing**, re-run the check command after the merge.
- **Track work on GitHub's pull request list**, not the session list. Archive a session once its PR is merged.
- **Don't run two sessions on the same task.** To try two approaches, give them different task numbers and say which one wins.

## Within a session: subagents

A session may use subagents for work that fits in a separate context: a code review of its own diff before opening the PR, a broad search, independent research, or checking screenshots. Subagents don't take separate plan tasks; that's what separate sessions are for.

## Spec review rounds

Before feature work, and again whenever the spec changes a lot:

1. Claude reads the spec as if it had to build from it, and lists every ambiguity, contradiction, missing rule and untestable statement as numbered open questions in the spec (O1, O2 …; numbers are never reused).
2. {{OWNER}} answers in a batch.
3. Claude puts the answers into the spec, strikes the questions through with the date, and logs the round in `docs/decisions.md` ("Spec review, round N").
4. Repeat until nothing the current milestone needs is open.

Spec review is not a numbered task, so it uses the session's assigned branch.

## Models and effort

<!-- FILL: from M0 stage 6, e.g. "Default model for routine tasks; the strongest model for the core engine, contract design, and anything with tricky state. Say it in the prompt or the brief." -->

## Prompts worth keeping

- **Start a task:** "Do task N from docs/plan.md."
- **Plan first (bigger tasks):** "Do task N from docs/plan.md. Plan first and wait for my go-ahead before writing code."
- **Send back:** "<what's wrong, where>. Fix and push to the same PR."
- **Make a correction stick:** "Also add this rule to CLAUDE.md in this PR."
- **Status check:** "Summarise where you are, what's left and anything blocking."
- **Spec review:** "Review docs/spec.md for M<n> and ask me the open questions."
- **Plan the next milestone:** "Plan milestone N in docs/plan.md from the roadmap. Ask me what you need."

## Between milestones

At the end of a milestone: run its exit check, record the results (and go/no-go) in `docs/decisions.md`, move the finished plan to `docs/plans/m<n>.md`, and plan the next milestone in `docs/plan.md` in its own session.
