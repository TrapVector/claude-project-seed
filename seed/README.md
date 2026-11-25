# The seed's own files

Everything in `seed/` exists to run milestone 0 and is deleted at the end of it. Nothing outside `seed/` should refer to it once milestone 0 is merged.

| File | Purpose |
| :- | :- |
| `m0-playbook.md` | The stages Claude follows in milestone 0, and the exit criteria. |
| `questions.md` | Question bank per stage. Profiles add their own. |
| `why-it-works.md` | The practices the project docs must carry, and the problem each solves. |
| `templates/` | The project docs, at the paths they're copied to. Sections to fill are marked `<!-- FILL: guidance -->`; the owner's name is `{{OWNER}}`. |
| `profiles/` | Project-type templates. See `profiles/README.md`. |
| `check.sh` | Milestone 0's definition of done. |
| `VERSION` | The seed's version, recorded in each project's decisions log. |

## Working on the seed itself

Improve the seed in sessions on the seed repo, not in a project. Ideas come from:

- **Seed feedback** in each milestone 0 final message (a missing question, a profile that didn't fit).
- **A project's `CLAUDE.md` after a few milestones**: rules added by corrections ("always give the preview link") are candidates for `templates/CLAUDE.md` if they'd apply to every project, or for a profile if they're type-specific.
- **A project's decisions log**: gotchas (tool quirks, host settings, pinned versions) belong in the profile's "Known gotchas"; workflow lessons belong in `why-it-works.md` and `templates/docs/workflow.md`.

Rules for changes:

- Keep the seed general. Anything project-specific belongs in a profile or in the project.
- Every template section marked `<!-- FILL` must be fillable from the playbook's questions. If you add a section, add the question that fills it, in the stage that writes it.
- Test a change by making a throwaway repo from the template and running "Let's set up milestone 0 together" with a made-up project.
- Bump `VERSION` (minor for new profiles or sections, patch for wording) and add a line to the changelog below.

## Changelog

- **0.1.0** — first version, from the WordGameNew project's milestone 0 kit and workflow (CLAUDE.md, plan, decisions log, setup guides, cloud install hook). Profiles: `web-app` (proven), `generic` (baseline).
