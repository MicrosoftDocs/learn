GitHub Copilot coding agent runs inside a secure, ephemeral GitHub Actions environment. With a few configuration steps you can preseed this environment to improve reliability and speed, extend the agent's capabilities with external tools through the Model Context Protocol (MCP), and apply best practices to test and validate the agent's output before merging.

By the end of this unit, you will be able to:

- Preinstall tools, dependencies, and secrets to customize the agent's development environment.
- Extend the agent's capabilities using the Model Context Protocol (MCP).
- Test and validate agent output effectively before merging changes.

## Preseeding the development environment

**Preinstall tools & dependencies with** **`copilot-setup-steps.yml`** 

Create `.github/workflows/copilot-setup-steps.yml` on your repository's default branch. The workflow must define a single job named `copilot-setup-steps`. Include any steps needed to install dependencies or set up tools.

**Example for TypeScript:**

```
name: "Copilot Setup Steps"

on:
  workflow_dispatch:
  push:
    paths:
      - .github/workflows/copilot-setup-steps.yml
  pull_request:
    paths:
      - .github/workflows/copilot-setup-steps.yml

jobs:
  copilot-setup-steps:
    runs-on: ubuntu-latest
    permissions:
      contents: read
    steps:
      - name: Checkout code
        uses: actions/checkout@v5
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - name: Install JavaScript dependencies
        run: npm ci
```

Allowed configuration keys for the `copilot-setup-steps` job: `steps, permissions, runs-on, container, services, snapshot, timeout-minutes` (≤ 59). Any `actions/checkout` fetch-depth is overridden to allow safe rollback. The setup workflow runs standalone (so you can validate it) and then automatically before the agent starts.

**Larger GitHub-hosted runners**

- Add larger runners first 
- In `copilot-setup-steps.yml`, set `runs-on` to the label/group (for example, `ubuntu-4-core`).
- Only Ubuntu x64 runners are supported; self-hosted runners aren't supported.

**Git LFS**

If you use Git Large File Storage, enable it in setup steps:

```
jobs:
  copilot-setup-steps:
    runs-on: ubuntu-latest
    permissions:
      contents: read
    steps:
      - uses: actions/checkout@v5
        with:
          lfs: true
```

**Firewall customization** 

Default internet access is limited to reduce exfiltration risk. You can customize or disable the firewall per organizational policy if needed.

## Extend with the Model Context Protocol (MCP)

MCP is an open standard for connecting LLMs to tools and data. The agent can use **tools** provided by local or remote MCP servers to expand its capabilities.

Note: Copilot coding agent supports MCP tools only (not resources or prompts). Remote MCP servers that require OAuth aren't supported.

**Default MCP servers**

- **GitHub MCP Server:** Access issues, PRs, and GitHub data with a read-only token scoped to the current repo by default (you can customize the token).
- **Playwright MCP Server:** Read, interact with, and take screenshots of web pages accessible inside the agent's environment (localhost/127.0.0.1).

**Repository configuration** 

Admins can declare MCP servers via a JSON configuration in the repo. Once configured, the agent autonomously uses the available tools-no per-use approval prompts. See Extending GitHub Copilot coding agent with MCP.

**Best practices**

- Review third-party MCP servers for performance and output quality implications.
- Prefer read tools; if write tools exist, allow only what's necessary.
- Carefully validate the MCP configuration before saving.

## Testing & validating agent output

You remain accountable for quality and security:

- Run CI (tests, linters, scanning) on every agent PR; these checks won't run until you click Approve and run workflows.
- Manually inspect high-impact or sensitive areas.
- Ask the agent to generate tests (e.g., "Add Jest unit tests for all functions in `src/utils/` following repo style") - multi-file test generation consumes PRUs.
- Enforce rulesets so agent PRs must pass tests + scanning + linting before merge.
- Label agent PRs (e.g., `agent-refactor, agent-tests`) to monitor, triage, and revert if needed.
- Iterate instructions in .github/copilot-instructions.md when you see repeated mistakes.
- Revert quickly if needed and request new changes from the agent.

**Using PRUs intentionally for validation** 

Leverage PRUs for deeper validation tasks such as test coverage expansion, audits across directories, or risky area scans. Lightweight checks consume fewer PRUs, so apply them intentionally to maximize value.

With configuration, extensions, and validation practices in place, the final step is to use the agent responsibly scoping tasks well, safeguarding environments, and continuously reviewing outcomes.