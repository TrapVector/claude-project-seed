#!/bin/bash
# Milestone 0's definition of done. Run from the repo root: bash seed/check.sh
# Checks that every project doc exists and nothing is left unfilled.
# Run it before deleting seed/ (it lives there).

set -u
cd "$(dirname "$0")/.." || exit 1

fail=0
problem() { echo "  ✗ $1"; fail=1; }

required=(
  CLAUDE.md
  README.md
  docs/spec.md
  docs/workflow.md
  docs/before-you-start.md
  docs/roadmap.md
  docs/plan.md
  docs/decisions.md
  docs/task-brief-template.md
  setup/cloud-environment.md
  setup/starting-sessions.md
  .github/pull_request_template.md
  .claude/settings.json
  scripts/cloud-install.sh
)

echo "Required files"
for f in "${required[@]}"; do
  [ -s "$f" ] || problem "$f is missing or empty"
done

echo "Unfilled sections and placeholders"
# Every Markdown file and script outside seed/ and .git/.
while IFS= read -r f; do
  if grep -n '<!-- FILL' "$f" >/dev/null; then
    grep -n '<!-- FILL' "$f" | sed "s#^#  ✗ $f:#"
    fail=1
  fi
  if grep -nE '\{\{[A-Z_]+\}\}' "$f" >/dev/null; then
    grep -nE '\{\{[A-Z_]+\}\}' "$f" | sed "s#^#  ✗ $f:#"
    fail=1
  fi
done < <(find . -path ./.git -prune -o -path ./seed -prune -o -path ./node_modules -prune -o -type f \( -name '*.md' -o -name '*.sh' -o -name '*.json' -o -name '*.yml' -o -name '*.yaml' \) -print)

echo "Seed mode removed"
grep -q 'SEED MODE' CLAUDE.md 2>/dev/null && problem "CLAUDE.md is still the seed's bootstrap file"
grep -q 'SEED STUB' scripts/cloud-install.sh 2>/dev/null && problem "scripts/cloud-install.sh is still the seed stub (copy the profile's, or write one for the stack)"
[ -e docs/brief.md ] && problem "docs/brief.md still exists (move its content into docs/spec.md, then delete it)"

echo "Content"
grep -qi 'seed' docs/decisions.md 2>/dev/null || problem "docs/decisions.md has no entry recording the seed version"
grep -qE '^### 1\.' docs/plan.md 2>/dev/null || problem "docs/plan.md has no task 1"
grep -qi 'scaffold' docs/plan.md 2>/dev/null || problem "docs/plan.md task 1 should be scaffold and CI"
tasks=$(grep -cE '^### [0-9]+[a-z]?\.' docs/plan.md 2>/dev/null || echo 0)
dones=$(grep -c 'Done when' docs/plan.md 2>/dev/null || echo 0)
[ "$dones" -ge "$tasks" ] || problem "docs/plan.md: $tasks tasks but only $dones 'Done when' lines"
grep -qE '^## M1' docs/roadmap.md 2>/dev/null || problem "docs/roadmap.md has no M1 section"
grep -qi 'exit check' docs/roadmap.md 2>/dev/null || problem "docs/roadmap.md has no exit check"

if [ "$fail" -eq 0 ]; then
  echo "seed/check.sh: all checks passed ($tasks M1 tasks)."
  echo "Next: add the 'Milestone 0 complete' decisions entry, delete seed/, commit, push, mark the PR ready."
else
  echo "seed/check.sh: FAILED. Fix the items above and run it again."
fi
exit "$fail"
