AI-assisted delivery should accelerate work without weakening governance. Define clear controls for permissions, review policy, and sensitive operations.

## Governance baseline

Governance is the framework that ensures speed does not reduce quality, security, or accountability. For learners, a useful perspective is to view governance as "guardrails" that allow safe experimentation while preventing high-impact mistakes.

Establish policy in three layers:

- **Access controls**: Least-privilege permissions in Azure DevOps and GitHub.
- **Process controls**: Required reviewers, branch protections, and test checks.
- **Audit controls**: Retain work item and pull request history for traceability.

## Security practices for delegated work

Security expectations should be explicit before delegation begins. Copilot can generate helpful implementation ideas, but teams are still responsible for protecting credentials, sensitive data, and compliance boundaries.

- Avoid including secrets, tokens, or sensitive data in prompts.
- Keep identity, credential, and infrastructure tasks human-approved.
- Require security review for authentication and authorization changes.
- Enforce dependency and code scanning in the PR pipeline.

## Responsible AI usage

Responsible AI usage means deciding where automation is appropriate and where human control is mandatory. Not all tasks have the same risk profile, and high-impact decisions still require experienced judgment.

Teams should define where Copilot is preferred and where human ownership is mandatory.

Examples of human-led areas:

- Architecture decisions with broad platform impact.
- Compliance-sensitive policy changes.
- Production hotfixes without adequate test confidence.

## Governance scorecard

Use a lightweight scorecard to measure whether your governance approach is working. These metrics help you assess if AI assistance is improving outcomes while keeping risk under control.

Track these metrics monthly in **both Azure DevOps (work item analytics) and GitHub (pull request insights)**:

- **Percentage of Copilot-assisted PRs that passed first review** — Measure in GitHub; track approval rate without rework requests.
- **Average rework cycles per delegated item** — Monitor in Azure DevOps (work item history) and GitHub (PR revision count).
- **Security issues introduced or prevented** — Review in GitHub (code scanning results in PRs) and Azure DevOps (security task tracking).
- **Lead time change relative to non-assisted baseline** — Calculate in Azure DevOps (cycle time reports) and correlate with GitHub PR merge times.

Use Azure DevOps dashboards for organizational rollup and GitHub for PR-level detail. Align review gates in both systems to ensure consistent governance enforcement.

## Summary

Strong governance and security practices are essential for sustainable AI-assisted delivery. By applying clear guardrails, explicit security rules, and outcome-based metrics, teams can scale Copilot usage confidently without losing control.
