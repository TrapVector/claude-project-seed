#!/bin/bash
# Installs project dependencies in Claude Code cloud sessions.
# Runs from the SessionStart hook in .claude/settings.json. Does nothing on local machines.
#
# SEED STUB: milestone 0 replaces this with the chosen profile's install script
# (for example seed/profiles/web-app/files/scripts/cloud-install.sh).
# Until then there is nothing to install.

if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

exit 0
