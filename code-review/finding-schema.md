# Structured findings

Every reviewer ends its human-readable report with a fenced `json` block so the
orchestrator can merge, dedupe, and verify findings deterministically instead of
parsing prose. Emit the block even when clean (`[]`).

```json
[
  {
    "id": "breadth-1",
    "file": "src/auth/login.ts",
    "line": 42,
    "severity": "critical",
    "confidence": "high",
    "category": "correctness",
    "title": "Session token never expires",
    "detail": "One-sentence statement of the defect.",
    "fix": "One-sentence concrete fix.",
    "source": "breadth"
  }
]
```

Field rules:

- `id` — unique within your report, prefixed by your `source` (`breadth-`, `depth-`, `perf-`, `security-`).
- `severity` — `critical | warning | suggestion | insight`.
- `confidence` — `high | medium | low`.
- `category` — `correctness | security | performance | quality | architecture | edge-case | type-safety | test | api-contract | docs`.
- `line` — 1-based line in the changed file, or `null` if not line-specific.
- `source` — `breadth | depth | perf | security` (which reviewer produced it).
- Keep `detail`/`fix` to one or two sentences — the markdown section above already carries the depth.
- The markdown report and the JSON block **must agree**. The block is the machine's copy of the same findings.
