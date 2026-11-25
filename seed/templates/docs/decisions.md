# Decisions log

Append-only. Newest at the bottom. Claude adds an entry for every judgment call made under "decide and log" in `CLAUDE.md`, and records {{OWNER}}'s answers to questions ("Task 5: {{OWNER}}'s answers on …"). {{OWNER}} adds entries for product decisions.

To change a decision, add a new entry that says which one it replaces. Don't edit old entries, except to strike through text that's no longer true.

This file merges with `merge=union` (see `.gitattributes`): when a session merges `main` into its branch, entries added on both sides are kept. GitHub's web conflict check ignores that setting, so sessions merge `main` locally before finishing. Always append at the very end.

Format:

```
## YYYY-MM-DD — short title
- **Context:** what prompted the decision
- **Decision:** what was chosen
- **Alternatives:** what else was considered
- **Who:** {{OWNER}} / Claude (task #, PR link)
- **Revisit if:** the condition that would reopen it
```

---
