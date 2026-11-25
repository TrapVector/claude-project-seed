# Deploys and preview builds

**Status:** draft from the web-app profile. Milestone 1 task 2 (preview deploys) replaces every `<angle-bracket>` value with the real one and removes this line.

Hosting: **Cloudflare Workers (static assets)**, Worker name `<worker-name>`, built by Cloudflare's GitHub integration (Workers Builds). No GitHub Actions secrets or deploy steps are involved; CI (`.github/workflows/ci.yml`) only runs `npm run check`.

| What | URL |
| --- | --- |
| Production (`main`) | `https://<worker-name>.<account-subdomain>.workers.dev` |
| Preview (any other branch / PR) | `https://<version-or-branch>-<worker-name>.<account-subdomain>.workers.dev` |

Each PR gets a comment and a check from Cloudflare with its preview link. The branch URL (branch name with `/` and other symbols turned into `-`) always shows the latest commit on that branch: that's the one sessions give in their final message.

## Config in the repo

- `wrangler.json`: Worker name, assets directory (`./dist`), single-page-app fallback (unknown paths serve `index.html`), preview URLs on, and an empty `previews` block that `npx wrangler preview` requires. The `name` must match the Worker name in the dashboard.
- `public/_headers`: Vite copies it into `dist/`; Cloudflare applies it. Hashed files under `/assets/` are cached for a year; `index.html` (and `sw.js` and the manifest, if it's a PWA) are revalidated on every load so new builds show up straight away.
- A unit test guards both files.

## Dashboard settings (owner, one-off)

Workers & Pages → `<worker-name>` → Settings → Build:

| Setting | Value |
| --- | --- |
| Git repository | `<owner>/<repo>` |
| Production branch | `main` |
| Build command | `npm run build` |
| Deploy command | `npx wrangler deploy` |
| Non-production branch deploy command | `npx wrangler preview` (needs the `previews` block in `wrangler.json`) |
| Builds for non-production branches | Enabled |
| Root directory | `/` (blank) |
| Build variable | `NODE_VERSION` = `<node major version>` (the build image also reads `.nvmrc`; this is a backup) |

Also check Settings → Domains & Routes: `workers.dev` and Preview URLs are both enabled.

The Cloudflare GitHub app must have access to the repo (GitHub → Settings → Applications → Cloudflare Workers and Pages).

## Rolling back

Workers & Pages → `<worker-name>` → Deployments → pick an earlier version → Deploy. Or revert the commit on `main`.

## Restricting previews later (optional)

To limit previews to named people: Zero Trust → Access → Applications → add a self-hosted app for `*-<worker-name>.<account-subdomain>.workers.dev` with an email allow-list (free for small teams).
