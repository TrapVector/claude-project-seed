# Starting a cloud session

Each task in `docs/plan.md` runs as its own cloud session. The rules every session follows are in `CLAUDE.md`; the method is in `docs/workflow.md`. This page is how you start and steer sessions.

## Start one

At claude.ai/code (or the desktop app's Code tab, or the mobile app):

1. Pick the repo and the `<!-- FILL: environment name -->` environment under the message box.
2. Pick the model: <!-- FILL: from docs/workflow.md "Models and effort" -->.
3. Send:

   > Do task N from docs/plan.md.

For work that isn't in the plan, paste a brief from `docs/task-brief-template.md` instead.

The session asks its "Ask first" questions straight away. Answer them, then you can leave it: it builds, tests, opens a draft PR and sends a final message with the PR and preview links.

## Prompts worth keeping

See `docs/workflow.md` → "Prompts worth keeping".

## Rules of thumb

- One task per session. Start a fresh session for the next task rather than continuing an old one: it's cheaper and starts with a clean context.
- <!-- FILL: parallel limit from docs/workflow.md, e.g. "Run at most two sessions at once until you trust the loop." -->
- Track open work on GitHub's pull request list, not in the session list.
- Archive a session once its PR is merged.
- If a session keeps stopping to ask the same thing, the answer belongs in `CLAUDE.md`: tell it to add it.
