In this exercise, you apply the agentic DevOps framework from this module to a realistic sample DevOps backlog. Your goal is to produce a justified autonomy classification for each task — the same kind of assessment you'd do before piloting agentic capabilities for your team.

## Scenario

Your team runs a platform engineering function for a financial services organization on Azure. You support eight application teams with shared Azure infrastructure, centralized pipelines, and an Azure DevOps project that manages all work items, pipelines, and repository policies.

You're evaluating which tasks to pilot with agentic capabilities in the next quarter. Your organization has a formal change management process, and any change that touches production environments requires documented authorization.

## Task list

Review each task in the backlog below and assign:

1. **Agentic opportunity?** — Yes or No
2. **Autonomy level** — Inform, Suggest, Execute on approval, or Execute autonomously
3. **Justification** — One to two sentences citing reversibility, blast radius, or compliance constraint

| # | Task description | Frequency |
|---|---|---|
| 1 | Review incoming bug reports and assign them to the correct area path and team | Daily |
| 2 | Generate Bicep templates for new storage accounts based on a naming convention document | Weekly |
| 3 | Create RBAC role assignments for new team members in production Azure subscriptions | Monthly |
| 4 | Summarize the last seven days of pipeline failure history and identify the top three failure patterns | Weekly |
| 5 | Update Azure Key Vault secrets when service credentials are rotated | Quarterly |
| 6 | Write pull request descriptions for infrastructure changes before review | Daily |
| 7 | Apply Azure Policy exemptions for approved exception requests | As needed |
| 8 | Triage failing unit tests in CI builds and surface probable root cause to the committing engineer | Daily |
| 9 | Generate a sprint summary report for the platform team's weekly status meeting | Weekly |
| 10 | Modify production pipeline variable groups to support a new deployment target | Monthly |

## Evaluation criteria

Your classification is correct when:

- Tasks with **low reversibility and any meaningful blast radius** are not assigned Execute autonomously.
- At least one task is classified as **Execute autonomously** with a valid justification.
- **Tasks 3, 5, 7, and 10** are not assigned Execute autonomously (they touch production security, credentials, or policy controls regardless of tooling confidence).
- Each justification explicitly references at least one of: reversibility, blast radius, compliance, or frequency.

## Check your work

After completing your classification, compare it against these reference answers:

| # | Recommended level | Key rationale |
|---|---|---|
| 1 | Execute autonomously | Fully reversible; no blast radius outside Boards; high-frequency reduces overhead significantly |
| 2 | Execute on approval | Reversible but requires human review of generated template against policy and naming standards before use |
| 3 | Suggest only | Low reversibility in practice; RBAC changes in production require documented human authorization |
| 4 | Execute autonomously | Read-only; purely informational; no state change |
| 5 | Inform/Suggest only | Credentials are never autonomous; requires human execution through approved change process |
| 6 | Execute autonomously | Draft only; no branch protection bypass; human reviews before PR is opened |
| 7 | Inform only | Policy exceptions must be human-authorized regardless of confidence level |
| 8 | Execute on approval | Summaries and hypotheses automated; fix recommendation requires committer agreement |
| 9 | Execute autonomously | Read-only; report generation from existing Boards and pipeline data |
| 10 | Suggest only | Production pipeline change; must transit change management process |

> [!NOTE]
> If your answers differ from the reference, focus on tasks where you assigned a higher autonomy level than recommended. Those represent the decisions where blast radius or regulatory requirements override convenience.

## Reflect

Consider two questions before moving to the knowledge check:

- Which of these tasks exists in your current team's backlog?
- For the tasks where you disagreed with the reference answer, what would need to be true about your environment for a higher autonomy level to be justified?
