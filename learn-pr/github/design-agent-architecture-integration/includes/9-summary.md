**This module covered how to design agent architectures that work reliably within the Software Development Lifecycle (SDLC) while maintaining clear boundaries, governance, and human oversight.** We explored how agentic systems can go beyond simple automation by interpreting goals and proposing changes, but also why that power requires structure-without it, agents can introduce risk to code quality, security, and stability

A key theme across the module was reinforcing that agents should propose work, not unilaterally execute it. By using pull requests, required checks, CODEOWNERS, and environment protections, we ensure that all agent-generated changes are validated through both automated signals and human review before they are accepted. This model is critical to maintaining security and reliability, especially as agent autonomy increases.

By enforcing governance, observability, and risk-based autonomy, teams can safely delegate repetitive or time-consuming work to agents while keeping humans in control of decisions that matter most. The result is a development workflow that is both faster and more scalable, without sacrificing trust, quality, or accountability.

In this module, you learned how to:

- Map agent responsibilities to SDLC stages and define bounded scopes.

- Define task inputs, outputs, and enforceable success criteria.

- Separate planning from execution and enforce plan gating.

- Use PR-based controls (templates, required checks, CODEOWNERS, rules, environments) to govern work.

- Build reliable workflows using outputs, contexts, and safe triggering patterns.

- Operate agents safely using observability, artifacts, tool governance, MCP restrictions, secrets isolation, hooks-based guardrails, and reliability patterns.

## Learn more

For deeper reading, use official GitHub documentation on:

- [Creating a pull request template for your repository](https://docs.github.com/es/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository)

- [Managing rulesets for a repository](https://docs.github.com/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/managing-rulesets-for-a-repository) and [Available rules for rulesets](https://docs.github.com/enterprise-cloud@latest/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets)

- [Troubleshooting required status checks](https://docs.github.com/en/enterprise-server@3.16/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/troubleshooting-required-status-checks) (helps avoid brittle "required check" designs)

- [Using ](https://docs.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token)[GITHUB_TOKEN](https://docs.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token)[ for authentication in workflows](https://docs.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token) and [Security hardening for GitHub Actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)

- [Environments](https://docs.github.com/en/actions/reference/environments) (required reviewers, deployment protection rules, and approval gates)

- [Uploading an artifact in a workflow](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts) (workflow outputs as durable evidence)

- [Uploading a SARIF file to GitHub](https://docs.github.com/en/code-security/how-tos/scan-code-for-vulnerabilities/integrate-with-existing-tools/uploading-a-sarif-file-to-github) (code scanning evidence in CI)

- [Protecting pushes with secret scanning (push protection)](https://docs.github.com/code-security/secret-scanning/protecting-pushes-with-secret-scanning) (prevents supported secrets from being committed)

- [Using hooks with GitHub Copilot agents](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/cloud-agent/use-hooks)

- [Tracking GitHub Copilot's sessions](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/cloud-agent/track-copilot-sessions)