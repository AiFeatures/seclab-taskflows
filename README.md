# seclab-taskflows

Example taskflows and custom MCP servers for the [SecLab Taskflow Agent](https://github.com/GitHubSecurityLab/seclab-taskflow-agent) framework.

## Why this exists

[GitHub Security Lab](https://securitylab.github.com/) maintains an experimental agentic framework for AI-driven security work — vulnerability auditing, alert triage, and variant analysis. This repository provides the concrete taskflow definitions, MCP server integrations, and helper scripts that turn the framework into runnable security workflows. It is a fork maintained by [AiFeatures](https://github.com/AiFeatures) as part of the iAiFy enterprise.

## Status

| Field | Value |
|-------|-------|
| Version | `0.0.4` (pre-release) |
| Python | `>= 3.9` |
| Build system | [Hatch](https://hatch.pypa.io/) |
| License | [MIT](./LICENSE) |

## Quick start

### Option A — Codespace (recommended)

1. Open this repo in a [GitHub Codespace](https://github.com/features/codespaces).
2. Wait for the devcontainer to finish (look for `(.venv)` in the prompt).
3. Run the demo:

```bash
python -m seclab_taskflow_agent \
  -t seclab_taskflows.taskflows.audit.ghsa_variant_analysis_demo \
  -g repo=github/cmark-gfm \
  -g ghsa=GHSA-c944-cv5f-hpvr
```

### Option B — Local install

```bash
pip install hatch
hatch env create
```

### Option C — Docker

Create a `.env` file in the repo root:

```
MEMCACHE_STATE_DIR=/app/data
CODEQL_DBS_BASE_PATH=/app/data
DATA_DIR=/app/data
LOG_DIR=/app/logs
```

Then run:

```bash
./scripts/run_seclab_agent.sh \
  -t seclab_taskflows.taskflows.audit.ghsa_variant_analysis_demo \
  -g repo=github/cmark-gfm \
  -g ghsa=GHSA-c944-cv5f-hpvr
```

### Environment variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `AI_API_TOKEN` | AI API credentials | _(required)_ |
| `AI_API_ENDPOINT` | AI model endpoint | `https://models.github.ai/inference` |
| `GH_TOKEN` | GitHub API access | _(required)_ |

> **Note:** Auditing taskflows can take several hours on large projects and require a [Copilot Pro](https://github.com/github-copilot/pro) account.

### Running an audit

```bash
./scripts/audit/run_audit.sh juice-shop/juice-shop
```

Results are written to an SQLite database. The `audit_result` table has a `has_vulnerability` column marking likely genuine findings.

## Package overview

```
src/seclab_taskflows/
├── taskflows/         # Taskflow definitions (audit, triage, container shell)
├── mcp_servers/       # Custom MCP servers (GHSA, CodeQL, GitHub APIs, etc.)
├── configs/           # Agent and taskflow configuration
├── containers/        # Container image definitions
├── personalities/     # Agent persona prompts
├── prompts/           # Prompt templates
└── toolboxes/         # Tool definitions for taskflows
```

## Development

Requires Python >= 3.9 and [Hatch](https://hatch.pypa.io/).

```bash
# Install Hatch
pip install --upgrade hatch

# Lint (check only)
hatch fmt --linter --check

# Format
hatch fmt

# Run tests with coverage
hatch test --cover --randomize --parallel --retries 2 --retry-delay 1

# Type check
hatch run types:check
```

## Deployment

CI runs on every push and PR to `main` via `.github/workflows/ci.yml`. The pipeline:
- Lints with `hatch fmt --linter --check`
- Tests across Python 3.11 and 3.13 on Ubuntu, Windows, and macOS
- Publishing to PyPI/TestPyPI is handled by dedicated workflows

Enterprise deployments use [Ai-road-4-You/enterprise-ci-cd@v1](https://github.com/Ai-road-4-You/enterprise-ci-cd) reusable workflows.

## Security

This project follows OWASP Top 10 practices. See [SECURITY.md](./SECURITY.md) for the vulnerability disclosure policy. No secrets should be hardcoded — use environment variables or GitHub Secrets.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) and [Ai-road-4-You/governance](https://github.com/Ai-road-4-You/governance) for guidelines.

## License

[MIT](./LICENSE) — Copyright GitHub, Inc.
