# Profiles

A profile is a project-type template. It holds what differs between kinds of software: stack defaults, extra questions, architecture rules, definition-of-done additions, CI, cloud environment settings, accounts, and the milestone 1 starter tasks. Everything that's the same for every project lives in `seed/templates/` instead.

Milestone 0 picks one or more profiles in stage 2 and folds them into the project's docs. A project can combine profiles (a web app with a backend API); `generic` is the base for anything no profile covers.

## Available profiles

| Profile | When to use | Maturity |
| :- | :- | :- |
| `web-app` | A browser-based app or PWA with a visual UI, built and previewed on every PR; optionally wrapped for app stores later. | **Proven**: taken from a real project. |
| `generic` | Anything else: CLI tools, libraries, services, scripts. Asks the questions a specific profile would answer. | Baseline. |

Profiles still to write (add them when a real project needs one): `cli-tool`, `library`, `backend-api`, `mobile-native`, `data-pipeline`, `browser-extension`.

## What a profile contains

```
seed/profiles/<name>/
  PROFILE.md      # required: the sections in _template/PROFILE.md
  files/          # optional: files copied into the project in M0 stage 10, at the same paths
```

Keep `files/` to things that are the same in every project of that type (CI workflow, install script, a deploy doc skeleton). Anything that depends on the project's choices is described in `PROFILE.md` for milestone 1 task 1 to create.

## Adding a profile

1. Copy `_template/` to `<name>/` and fill in every section.
2. Prefer lessons from a real project: what the first tasks were, which hosts the cloud environment needed, which versions had to be pinned, what went wrong. Mark the maturity honestly in the table above ("Draft: not yet used on a project").
3. Add it to the table above.
4. After a project uses it, fold back what you learned (see `seed/README.md`) and update its maturity.
