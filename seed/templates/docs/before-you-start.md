# Before you start

Everything {{OWNER}} must set up that Claude can't: accounts, settings, secrets and devices. Grouped by when it's needed. Claude never creates accounts or handles secret values; it writes the config and tells you exactly where to click.

Tick items off as you go (edit this file, or tell a session "I've done X; tick it off").

## Before milestone 1, task 1

<!-- FILL: always includes the GitHub and cloud environment items below; add the profile's. Each item: what, why, exact steps, how to check it worked. -->

- [ ] **GitHub: Claude GitHub App** installed on this repo (github.com/apps/claude). *Check:* a session can push a branch and open a PR. (Already done if milestone 0 opened a PR.)
- [ ] **GitHub: protect `main`.** Settings → Branches → add a rule (or ruleset) for `main`: require a pull request before merging. *Check:* pushing directly to `main` is refused.
- [ ] **Cloud environment.** Create it as described in `setup/cloud-environment.md`, and select it for every session on this repo. *Check:* the check in that guide's last section.
<!-- FILL: e.g. "- [ ] **Node 22 locally** (only if you'll work locally): see setup/local-setup.md." -->

## Before specific tasks

<!-- FILL: items a particular task needs, e.g.
- [ ] **Task 2 — Cloudflare account** connected to GitHub (Workers & Pages → Create → Import a repository). Claude writes the config and `docs/deploy.md`; you click through the dashboard. Free tier is enough.
If none: "None." -->

## Before later milestones

<!-- FILL: e.g. app-store developer accounts (M4: Apple Developer Program, yearly fee; Google Play Console, one-off fee), payment provider, analytics, domain. Note lead times (app-store accounts can take days to approve). If none yet: "None yet; added when each milestone is planned." -->

## Secrets

<!-- FILL: every secret the project uses: what it is, which milestone needs it, where it lives (cloud environment settings, CI secrets, hosting dashboard), and who can see it. Never in the repo, never pasted into a chat. If none yet: "None in milestone 1." -->

## Devices for testing

<!-- FILL: the real devices {{OWNER}} will check builds on (e.g. "iPhone with Safari, Android phone with Chrome, Windows desktop with Chrome"), and what the cloud can't test (e.g. real Safari, whether it's fun). -->
