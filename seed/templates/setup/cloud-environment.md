# Cloud environment setup

Do this once, before milestone 1 task 1. Every session on this repo then uses it. Configure it at claude.ai/code → environment selector (under the message box) → **New environment**. Settings move around in the product; if a step here doesn't match what you see, ask a session "How do I set up a cloud environment?" and it can read the current documentation.

If a session offers to create or update the environment for you (some sessions have tools for this, and show you an approval prompt with the exact settings), that's equivalent to the steps below.

## 1. Name

`<!-- FILL: e.g. project-node22 -->`

## 2. Network access

<!-- FILL: from the profile. Usually: choose **Custom**, tick **Also include default list of common package managers**, and add these lines to **Allowed domains**:

```
<hosts the profile lists, e.g. the test browser's download hosts>
```

Explain each host in a line. "If an install still fails, the error names the host it tried; add that host here." -->

## 3. Environment variables

<!-- FILL: non-secret variables only, with a line each on why. Common ones:

```
CI=true
BASH_DEFAULT_TIMEOUT_MS=600000
BASH_MAX_TIMEOUT_MS=1200000
```

`CI=true` makes tools behave non-interactively. The timeouts give builds and end-to-end runs room (the default is 2 minutes per command). -->

Secrets don't go here as plain variables. <!-- FILL: where they go, or "No secrets in milestone 1." -->

## 4. Setup script

<!-- FILL: from the profile. Runs when a session's machine is built fresh, before Claude starts. Use it to pre-install heavy, rarely changing things (system libraries, a browser for tests). Project dependencies are installed by the SessionStart hook (`scripts/cloud-install.sh`) instead, so they follow the lockfile. -->

## 5. Check it works

<!-- FILL: after task 1 is merged, start a throwaway session on the repo with this environment and ask:

> Run `<check command>` and show me <one of the screenshots it produced / the test summary>.

What a pass looks like, and what to check if it fails. -->

## What runs in the cloud

Each session gets a fresh Linux machine with common runtimes, git and Docker. It can install packages, build, run tests and headless browsers, and look at screenshots. It can't test on your real devices or tell you whether the thing is good to use: that's your job on the preview builds.
<!-- FILL: profile-specific limits, e.g. "It can't run Safari/WebKit as on a real iPhone." -->
