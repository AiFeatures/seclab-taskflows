# Copilot Instructions — seclab-taskflows

## Project

- **Name**: seclab-taskflows
- **Organization**: AiFeatures (fork from GitHubSecurityLab)
- **Enterprise**: iAiFy
- **Description**: Security lab task flows and automation templates

## Conventions

- Use kebab-case for file and directory names
- Use conventional commits (feat:, fix:, chore:, docs:, refactor:, test:)
- All PRs require review before merge
- Branch from main, merge back to main

## Shared Infrastructure

- Reusable workflows: Ai-road-4-You/enterprise-ci-cd@v1
- Composite actions: Ai-road-4-You/github-actions@v1
- Governance standards: Ai-road-4-You/governance

## Quality Standards

- Run lint and tests before submitting PRs
- Keep dependencies updated via Dependabot
- No hardcoded secrets — use GitHub Secrets or environment variables
- Follow OWASP Top 10 security practices

## AgentHub Integration
- Skills: `.agents/skills/` in this repo links to shared AgentHub skills
- 14 shared agents available
- MCP: 12 servers (GitHub, Supabase, Playwright, MongoDB, Notion, HuggingFace, etc.)
