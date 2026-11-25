# Local fallback

Use this when you want a hands-on session on your own machine, or if cloud sessions can't do something. Cloud sessions don't need any of this. Check the Claude Code docs for current details; the settings below are the shape, not gospel.

## 1. One-time machine setup

<!-- FILL: for the owner's OS (macOS, Linux, or Windows with WSL2), install git, the project's runtime (from CLAUDE.md §Stack) and Claude Code, clone the repo and install dependencies, e.g.:

```bash
mkdir -p ~/code && cd ~/code
git clone <repo URL> <name>
cd <name> && <install command> && <test browser install, if any>
```

On WSL: keep the repo under `~/code`, not under `/mnt/c`. It's faster and the sandbox works cleanly there. Linux/WSL sandboxing needs `bubblewrap` and `socat` (`sudo apt-get install -y bubblewrap socat`). -->

## 2. User settings: `~/.claude/settings.json`

Applies to every project on this machine.

```json
{
  "permissions": {
    "defaultMode": "auto",
    "blockReadsOutsideWorkingDirectories": true
  }
}
```

## 3. Local-only sandbox: `.claude/settings.local.json` in the repo

Put the sandbox here, not in the committed `.claude/settings.json`: cloud sessions read the committed file, and a sandbox that must be available would stop them starting. `.claude/settings.local.json` is in `.gitignore`.

```json
{
  "sandbox": {
    "enabled": true,
    "failIfUnavailable": true,
    "allowUnsandboxedCommands": false,
    "network": {
      "allowedDomains": [
        "github.com",
        "*.github.com"
      ]
    }
  }
}
```

<!-- FILL: add the package registry and other hosts from setup/cloud-environment.md to allowedDomains. -->

After restarting Claude Code, run `/sandbox` and check it reports no missing dependencies.

## 4. Getting your attention while away

```bash
tmux new -s <name>
cd ~/code/<name>
claude --remote-control "<name>"
```

Then in `/config`, turn on push notifications. Stop the machine sleeping while plugged in, or the session goes offline.

## 5. Don't

- Don't use `--dangerously-skip-permissions` outside a container.
- Don't put sandbox settings in the committed `.claude/settings.json`.
