# CLAUDE.md — seclab-taskflows

Fork of GitHubSecurityLab/seclab-taskflow-agent. Provides concrete taskflow definitions, MCP server integrations, and helper scripts for AI-driven security workflows (vulnerability auditing, alert triage, variant analysis) within the iAiFy AiFeatures org. Version: 0.0.4 (pre-release), Python >= 3.9, build system: Hatch.

## Quick Start

### Option A — Codespace (recommended)

Open in GitHub Codespaces — devcontainer auto-installs everything. Run demo when `(.venv)` appears in the prompt.

### Option B — Local

```bash
pip install hatch
hatch env create
hatch run python -m seclab_taskflow_agent \
  -t seclab_taskflows.taskflows.audit.ghsa_variant_analysis_demo \
  -g repo=github/cmark-gfm \
  -g ghsa=GHSA-c944-cv5f-hpvr
```

### Option C — Docker

```bash
# Create .env with: MEMCACHE_STATE_DIR, CODEQL_DBS_BASE_PATH, DATA_DIR, LOG_DIR
./scripts/run_seclab_agent.sh \
  -t seclab_taskflows.taskflows.audit.ghsa_variant_analysis_demo \
  -g repo=github/cmark-gfm \
  -g ghsa=GHSA-c944-cv5f-hpvr
```

## Architecture

- `seclab_taskflows/taskflows/` — Taskflow definitions (audit, triage, variant analysis)
- `seclab_taskflows/mcp/` — Custom MCP server integrations
- `scripts/` — Helper scripts including Docker entrypoint
- `pyproject.toml` — Hatch build config and dependency spec

## Conventions

- Kebab-case file and directory names
- Conventional commits (`feat:`, `fix:`, `chore:`, `security:`)
- Never commit credentials or scan results — security findings are sensitive data
- Python >= 3.9 compatibility required across all taskflows

## Shared Resources

| Resource | Location |
| --- | --- |
| Reusable CI workflows | `Ai-road-4-You/enterprise-ci-cd` |
| Agent templates | `Ai-road-4-You/repo-templates` |
| AgentHub | `~/AgentHub/` (central hub, 12 MCP servers) |

## AgentHub

- Central hub: `~/AgentHub/`
- Skills: `.agents/skills/` (symlinked to AgentHub shared skills)
- MCP: 12 servers synced across all agents
- Agents: 14 shared agents available
- Hooks: Safety, notification, and logging hooks
