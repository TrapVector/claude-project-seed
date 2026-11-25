#!/bin/bash
# Installs project dependencies and the Playwright browser in Claude Code cloud sessions.
# Runs from the SessionStart hook in .claude/settings.json. Does nothing on local machines.

if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR" || exit 1

# Nothing to install until milestone 1 task 1 (scaffold) creates package.json.
if [ ! -f package.json ]; then
  exit 0
fi

hashes=node_modules/.cloud-install.sha256

if ! sha256sum --check --status "$hashes" 2>/dev/null; then
  rm -f "$hashes"
  if [ -f package-lock.json ]; then
    npm ci || npm install
  else
    npm install
  fi
  if [ -d node_modules ]; then
    sha256sum scripts/cloud-install.sh package.json package-lock.json > "$hashes" 2>/dev/null || rm -f "$hashes"
  fi
fi

# Playwright Chromium matching the project's Playwright version.
# Fast no-op when the environment setup script already installed the same version.
if [ -x node_modules/.bin/playwright ]; then
  npx playwright install chromium || echo "WARNING: Playwright browser install failed; check the environment's network allowlist (see setup/cloud-environment.md)."
fi

exit 0
