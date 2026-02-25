AI-assisted delivery should accelerate work without weakening governance. Define clear controls for permissions, review policy, and sensitive operations.

## Governance baseline

Establish policy in three layers:

- **Access controls**: Least-privilege permissions in Azure DevOps and GitHub.
- **Process controls**: Required reviewers, branch protections, and test checks.
- **Audit controls**: Retain work item and pull request history for traceability.

## Security practices for delegated work

- Avoid including secrets, tokens, or sensitive data in prompts.
- Keep identity, credential, and infrastructure tasks human-approved.
- Require security review for authentication and authorization changes.
- Enforce dependency and code scanning in the PR pipeline.

## Responsible AI usage

Teams should define where Copilot is preferred and where human ownership is mandatory.

Examples of human-led areas:

- Architecture decisions with broad platform impact.
- Compliance-sensitive policy changes.
- Production hotfixes without adequate test confidence.

## Governance scorecard

Use a lightweight monthly scorecard:

- Percentage of Copilot-assisted PRs that passed first review.
- Average rework cycles per delegated item.
- Security issues introduced or prevented.
- Lead time change relative to non-assisted baseline.
