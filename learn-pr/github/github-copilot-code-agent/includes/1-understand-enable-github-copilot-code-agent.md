This unit explains what the agent is, how it differs from traditional AI coding assistants, what plans and repositories support it, and how to enable and budget for it-including Premium Request Units (PRUs) and GitHub Actions minutes.

By the end of this unit, you'll be able to:

- Explain what the GitHub Copilot coding agent is, who can use it, and where it's available.
- Describe the tasks it can perform and how to delegate work.
- Distinguish it from IDE-only assistants and Copilot's "agent mode."
- Enable the agent at the organization or repository level.
- Understand how GitHub Actions minutes and Premium Request Units (PRUs) are used and manage them effectively.

What is GitHub Copilot coding agent, who can use it and where it's available.

GitHub Copilot coding agent is an autonomous development assistant that runs inside GitHub itself. Rather than pairing with you only in your IDE, the agent acts like a background teammate. You give it a clearly scoped task-such as a bug fix, an incremental feature, or documentation update-and it creates a branch, writes commits, opens a draft pull request, updates the PR description with status, and then requests your review.

### Availability and plans

- **Plans:** Available on Copilot Pro, Copilot Pro+, Copilot Business, Copilot Enterprise.
- **Repositories:** Works in all GitHub-hosted repositories except those owned by managed user accounts or where the agent is explicitly disabled.

### What the Copilot coding agent does

Copilot coding agent can take on a wide range of development tasks:

- Fix bugs and regressions.
- Implement incremental new features.
- Improve test coverage or generate missing tests.
- Update or create documentation.
- Address technical debt and "nice-to-have" backlog items.

You can delegate work to the agent in two primary ways:

- **Assign an issue** to Copilot - on GitHub.com, GitHub Mobile, or via API/CLI.
- **Ask Copilot to create a pull request** - from the Agents panel on GitHub, Copilot Chat, your IDE or other agentic tool with MCP support, or Raycast on macOS.

When the agent finishes, it requests your review. You can mention @copilot in a pull-request comment to ask it to iterate on its work.

### How it differs from traditional IDE assistants

Traditional AI assistants in IDEs help you write code locally but leave manual steps to you: creating branches, pushing commits, writing PR descriptions, and iterating. Those decisions happen in a private session and aren't visible to your team.

With Copilot coding agent:

- All work happens as commits on GitHub.
- The agent automates branch creation, commit messages, PR opening, and PR descriptions.
- Work is visible in session logs and PR history for traceability.
- You steer via PR review comments rather than synchronous local sessions.

This creates transparency and collaboration opportunities-your teammates can see each step and jump in as needed.

### Coding agent vs. "Agent Mode" in IDEs

It's important to distinguish the GitHub Copilot coding agent (covered in this module) from the agent mode feature in Visual Studio and Visual Studio Code:

- **Coding agent:** Runs autonomously in a GitHub Actions-powered environment to complete development tasks you assign through issues or Copilot Chat. It creates pull requests with results.
- **Agent mode (Copilot Edits):** Performs autonomous local edits directly in your IDE session.

### Enabling the Copilot coding agent

Before assigning tasks to Copilot, ensure the agent is enabled:

- **Organization-owned repositories:** Availability is managed by organization or enterprise administrators.
- **Personal repositories:** Configure availability in your account settings.

**Usage Costs: GitHub Actions + PRUs**

Copilot coding agent uses two main resources:

- **GitHub Actions minutes** for the ephemeral build/test environment where the agent works.
- **Copilot Premium Requests (PRUs)** to power advanced model reasoning.

> [!NOTE]
> Beginning June 4, 2025, the agent uses one premium request per model request it makes. Within your monthly Actions and premium request allowance, you can run tasks without extra charges. ([See GitHub Copilot billing.](https://www.google.com/url?q=https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-copilot/about-billing-for-github-copilot%23allowance-usage-for-copilot-coding-agent&sa=D&source=docs&ust=1758211495584204&usg=AOvVaw2lQmmT8QfhnQOGji8ggdYe))

> [!TIP]
> Use PRUs where they add value-multi-file edits, test generation, and broader diffs that need deeper reasoning. Lightweight edits may require fewer PRU-intensive steps.

With the agent enabled and costs understood, let's confirm how it adheres to your security posture, what risks to anticipate, and which limitations to account for as you plan real work.