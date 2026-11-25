# Profile: web-app

**Maturity:** Proven. Taken from a daily puzzle game PWA built this way (React, TypeScript, Playwright screenshots, Cloudflare preview builds, Capacitor adapters for later app-store builds).

## When to use

A browser-based app with a visual UI that the owner checks on real devices: a web app, a PWA, a browser game, a tool with screens. Also the right start for "mobile app later": build web-first, keep platform features behind adapters, and wrap it with Capacitor in a later milestone. Combine with a backend profile if it needs a server from milestone 1; prefer no backend in milestone 1 if the riskiest assumption can be tested without one.

## Questions to add

**Stage 3 (spec):**
- Phone first, desktop first, or both equally? Smallest width to design for (default 360px)?
- Touch and physical keyboard both? Any drag, swipe or long-press interactions?
- Does it need to work offline or be installable (PWA)?
- Are there mockups or a design system? Who makes visual decisions?
- Animations: what should feel good? (They're tuned by feel in a polish task, with reduced motion respected.)
- Does any data need to stay hidden from someone opening dev tools (answers, prices, admin features)?

**Stage 5 (stack):**
- App-store builds later? (If yes: Capacitor plugins and adapters from milestone 1; native projects only in the milestone that ships them.)
- Any hosting account already? (Default: Cloudflare, free tier, previews per branch.)

**Stage 6 (workflow):**
- Which phone and browser will you check previews on?
- Is a public-but-unlisted preview URL OK, or must previews be restricted?

**Stage 7 (before you start):**
- Hosting account owner, and the GitHub integration for builds.
- App-store developer accounts and their lead times, if app stores are on the roadmap.

## Stack defaults

Propose these, then adjust to the spec:

- **Build:** Vite + React + TypeScript in strict mode, plus `noUncheckedIndexedAccess`. Alternative: Svelte or Vue if the owner reads them better.
- **Styling:** Tailwind CSS, with design tokens as CSS variables mapped into the theme (so high-contrast and dark themes are token swaps). Animation: `motion`, only if the spec has animation.
- **Validation:** Zod for any data loaded at runtime (content files, stored state, API responses).
- **Offline/installable:** `vite-plugin-pwa`, only if the spec needs it, installed in the task that uses it.
- **Platform features:** `@capacitor/core` and official plugins (preferences, share, haptics, app, network as needed) with web implementations, if app stores are on the roadmap. Otherwise plain web APIs, still behind adapters.
- **Unit and component tests:** Vitest + Testing Library (jsdom), coverage on.
- **End-to-end and screenshots:** Playwright, Chromium only, version pinned exactly. Accessibility: `@axe-core/playwright`.
- **Lint and format:** ESLint flat config (typescript-eslint strict, react-hooks) and Prettier, with `prettier --check` inside `lint`.
- **Package manager and runtime:** npm, current Node LTS pinned in `.nvmrc` and `engines`. (Bun had proxy problems in cloud sessions.)
- **Hosting:** Cloudflare Workers static assets via Workers Builds (Cloudflare's GitHub integration): production on `main`, a preview URL per branch, no deploy secrets in GitHub. Alternatives: Vercel or Netlify (same model); GitHub Pages has no per-PR previews.
- **Backend:** none in milestone 1 unless the spec needs one. Content as JSON files bundled at build time; player/user state on the device behind one storage module.

Install later-stack packages in the task that first uses them, not in task 1.

## Commands

```
npm run dev          # local dev server
npm run build        # production build
npm run typecheck    # tsc
npm run lint         # eslint + prettier --check
npm test             # vitest (unit + component), with coverage
npm run e2e          # playwright (builds, serves preview, runs tests)
npm run validate     # validates content files against their schema (if the project has content)
npm run check        # typecheck + lint + test + validate + e2e — the definition of done
```

## Architecture rules

Add to `CLAUDE.md`:

- Core logic is pure TypeScript in `src/<core>/` with no React or DOM imports. **Lint-enforced:** `no-restricted-imports` for `react*` and `no-restricted-globals` for `window`, `document`, `localStorage`, `navigator` in that folder.
- UI in `src/ui/`; it renders state and dispatches actions, nothing more.
- Storage access only through `src/lib/storage.ts`. Its API is async from day one (so a native storage plugin can replace it) and never throws: failures return `null`/`false`, and the app must work if storage fails. Stored values are validated by the caller.
- Platform features never get called directly from core or UI code: each goes through a Capacitor plugin or an adapter in `src/platform/` (interface, web implementation, test fake). Adapters for ads, purchases or push are built in the milestone that needs them, but those APIs are never called outside `src/platform/`. **Lint-enforced:** no `Capacitor.isNativePlatform`/`getPlatform` outside `src/platform/`.
- Mobile first: design for 360px wide and up. Touch and physical keyboard both supported. Touch targets at least 24px (WCAG 2.5.8).
- Accessibility: every interactive element keyboard-reachable, colour is never the only signal (pair with shape or icon), respects `prefers-reduced-motion` (and `prefers-contrast` if the spec has a high-contrast theme).
- Content (if any) is bundled at build time and validated by `npm run validate`; the build fails on invalid content.

## Definition of done additions

- A Playwright test for any new user flow.
- For any visible UI change, Playwright saves screenshots at 390×844 (phone) and 1280×800 (desktop) to `test-results/screenshots/`. Look at them and fix anything that looks wrong before finishing. CI uploads them as an artifact.
- The axe check passes on every screen (from the accessibility task onwards).
- The final message gives the preview link.

## Cloud environment

- **Name:** `<project>-node<version>`.
- **Network:** Custom, with the default package-manager list, plus Playwright's browser download hosts:
  ```
  cdn.playwright.dev
  playwright.download.prss.microsoft.com
  playwright.azureedge.net
  ```
  If an install still fails, the error names the host; add it. Preview hosting runs through GitHub, so it needs nothing here.
- **Variables:** `NODE_ENV=development`, `CI=true`, `BASH_DEFAULT_TIMEOUT_MS=600000`, `BASH_MAX_TIMEOUT_MS=1200000`.
- **Setup script:** pre-warms Chromium and its system libraries:
  ```bash
  #!/bin/bash
  set -u
  # The project's own Playwright version installs its matching browser in the
  # SessionStart hook; this pre-warms the cache so that step is usually quick.
  npx -y playwright@latest install --with-deps chromium || true
  exit 0
  ```
- **Install script:** `files/scripts/cloud-install.sh` (npm ci when the lockfile changes, then the pinned Playwright's Chromium).
- **Check:** after task 1 is merged, a throwaway session: "Run `npm run check` and show me one of the screenshots it produced."
- **Can't do:** Safari/WebKit as on a real iPhone; judging feel. That's the owner, on previews.

## Before you start

- Before task 1: seed-wide items (GitHub App, branch protection, cloud environment).
- Before task 2: a hosting account (Cloudflare by default, free tier) with its GitHub app given access to the repo. The owner creates the project in the dashboard; Claude writes the config and `docs/deploy.md` with the exact settings.
- Before a PWA/offline task: nothing.
- Before an app-store milestone: Apple Developer Program and Google Play Console accounts (paid; approval can take days), a Mac for iOS builds or a cloud build service, test devices.

## Milestone 1 starter tasks

### 1. Scaffold and CI
**Depends on:** nothing. **Touches:** the whole repo.
- Vite + React + TS strict, Tailwind, ESLint, Prettier, Vitest, Playwright (Chromium only, exact version) per `CLAUDE.md`.
- All `npm run` scripts from `CLAUDE.md` exist and work; `npm run check` passes on an empty app. Scripts whose real content arrives later (e.g. `validate`) exist as placeholders that pass.
- GitHub Actions workflow (`.github/workflows/ci.yml`, added in M0 with a seed guard that skips everything until `package.json` exists) runs `npm run check` on every PR and on `main`, and uploads Playwright screenshots and the HTML report as artifacts. Remove the seed guard step and its `if:` lines.
- Lint rules for the architecture rules in `CLAUDE.md`.
- A placeholder home screen with a Playwright screenshot test at both viewports.
- `src/lib/storage.ts` (async, never throws), `src/lib/clock.ts` and `src/lib/rng.ts` (injectable), an empty `src/platform/` with a README stating the adapter rule. If app stores are on the roadmap: `@capacitor/core` and the agreed plugins (web only, no `npx cap add`).
- `.gitignore` covers build, coverage and test output; `.prettierignore` excludes `*.md`, `.claude/` and owned content folders.
- **Done when:** a PR shows a green CI check and the screenshot artifacts are downloadable.

### 2. Preview deploys *(parallel ok)*
**Depends on:** task 1's scaffold (can start once `npm run build` exists). **Touches:** `wrangler.json` (or the host's config), `public/_headers`, `docs/deploy.md`, a config test.
- Every PR gets a preview URL the owner can open on their phone, via the host's GitHub integration. Production deploys from `main`.
- Config in the repo, guarded by a unit test; `docs/deploy.md` records the dashboard settings, URLs, rollback, and how to find a branch's preview URL (it goes into `CLAUDE.md`'s "always give the preview link" rule).
- **Ask first:** which host (default Cloudflare). Do not create accounts.
- **Done when:** a PR comment or check links to a working preview, and production serves `main`.

Typical later tasks for this type, to consider in the roadmap: content schema, validator and loader; core engine; main screen; results/state; share; how-to and accessibility pass (axe on every screen); PWA and offline; internal authoring tool for owned content; polish and feel (owner signs off on a phone); playtest feedback links.

## Files

- `files/.github/workflows/ci.yml` → `.github/workflows/ci.yml`. Copy in M0. Its first step skips the job until `package.json` exists, so the M0 PR stays green; task 1 removes that guard.
- `files/scripts/cloud-install.sh` → `scripts/cloud-install.sh`. Copy in M0 (it does nothing until `package.json` exists).
- `files/docs/deploy.md` → `docs/deploy.md`. Copy in M0 as a draft; task 2 completes it with the real names and URLs.

## Known gotchas

- **Pin Playwright exactly** (`"@playwright/test": "1.x.y"`, no caret), so the browser cached in the cloud environment matches.
- **Screenshots are saved, not pixel-diffed.** `toHaveScreenshot` baselines fail randomly because font rendering differs between the cloud VM and CI runners. Save with `page.screenshot()` and have Claude look at them.
- **Prettier skips Markdown**, or it reformats hand-written docs and contract files.
- **Cloudflare Workers vs Pages:** new dashboard projects default to Workers. Deploy as an assets-only Worker: `wrangler.json` (plain JSON so a test can parse it) with `assets.directory: "./dist"`, `not_found_handling: "single-page-application"`, `preview_urls: true`, and an empty `previews: {}` block, which `npx wrangler preview` (non-production branch builds) refuses to run without. Set build variable `NODE_VERSION` too.
- **Preview link format:** the branch URL `https://<branch-with-dashes>-<worker>.<subdomain>.workers.dev` always shows the latest commit; the version URL in Cloudflare's PR comment shows one build.
- **Cache headers:** hashed `/assets/*` immutable for a year; `index.html`, `sw.js` and the manifest revalidated every load (`public/_headers`).
- **Service workers delay deploys by a visit:** a new build downloads in the background and takes over the next time the app is hidden or reopened. Document how to force it (DevTools → Application → Service workers → Update on reload).
- **iPhone/iPad downloads:** `<a download>` is unreliable in iOS Safari and installed PWAs; save files through the share sheet there.
- **Links in a Capacitor shell** may not open in the system browser; plan an adapter when the app-store milestone starts.
- **Scripts in TypeScript** can run with Node's built-in type stripping (`node scripts/x.ts`), no `tsx` dependency needed, on current Node versions.
- **Hidden data isn't secret.** Anything shipped to the browser can be read; obfuscation (e.g. XOR plus base64 at build time) deters casual peeking and scraping only. Decide it in the spec, and test that built files don't contain the plain values.
