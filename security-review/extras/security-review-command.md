---
allowed-tools: Task(security-review), Bash, Read, Grep, Glob
description: Run a security-focused code review with OWASP mapping and vulnerability detection
---

Run the security-review agent to perform a security-focused review of the current project.

If the user provided arguments, pass them as the scope:
- `$ARGUMENTS`

If no arguments were provided, review recent changes for security issues.

Use the Task tool with `subagent_type: "security-review"` and pass along any scope the user specified.

Example prompts based on arguments:
- No args: "Run a security review on this project's recent changes."
- `src/auth/`: "Run a security review scoped to src/auth/"
- `--full`: "Run a full security audit of the entire codebase."
- `--audit`: "Run a full security audit of the entire codebase."
