# Task brief template

Paste as the first message of a new cloud session to start a task. For tasks already in `docs/plan.md`, "Do task N from docs/plan.md" is usually enough; use this template for anything new or when you want to override the plan. For anything that will take more than one session, add it to `docs/plan.md` instead.

---

**Task:** <one line>

**Why:** <the user or business reason, one or two lines>

**Scope**
- In: <what to build>
- Out: <what not to touch>

**Touches:** <folders/files, so it doesn't collide with sessions running in parallel>

**Acceptance criteria**
- [ ] <observable, testable outcome>
- [ ] <…>
- [ ] The check command passes; screenshots for UI changes (see `CLAUDE.md`)

**References:** <spec sections, mockup links, decisions, related PRs>

**Ask me before:** <anything specific beyond the CLAUDE.md list, or "nothing extra">

**Branch:** <`m<milestone>/<n>-<name>` if it's a numbered task; otherwise the session's assigned branch>

**Model/effort:** <default, or e.g. "strongest model, high effort" for tricky work>

---

## Example

**Task:** Add a "copied!" toast to the share button fallback.
**Why:** users on desktop don't know the copy worked.
**Scope:** In: toast component, share fallback path. Out: share text content, native share path.
**Touches:** `src/ui/share/`, `tests/e2e/share.spec.ts`.
**Acceptance criteria:**
- [ ] Toast appears for 2s after clipboard copy, announced to screen readers
- [ ] No toast when the native share sheet is used
- [ ] End-to-end test covers the fallback path with a screenshot
**Ask me before:** final wording of the toast.
**Model/effort:** default.
