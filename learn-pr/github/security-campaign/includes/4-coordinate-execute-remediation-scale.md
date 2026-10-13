Security campaigns in GitHub Advanced Security do not execute remediation work themselves. Instead, they track security alerts as teams resolve them using standard GitHub development workflows.

After you define a campaign scope, remediation happens continuously across repositories as developers fix alerts and GitHub automatically updates their status.

This unit explains how remediation work progresses and how that work changes the state of a campaign.

### Resolve alerts through repository workflows

You resolve security alerts directly in the repositories where GitHub detects them.

Each alert links to the exact code location that introduced the issue. You use this context to implement a fix and open a pull request.

For code scanning alerts, remediation follows this flow:

- You identify the vulnerable code location from the alert
- You create a pull request that updates or removes the vulnerable pattern
- GitHub analyzes the updated code during review
- The alert updates automatically when the fix is merged

This creates a direct relationship between code changes and alert resolution.

## Use pull requests to close security issues

Pull requests serve as the primary mechanism for resolving security alerts.

When you include a fix in a pull request:

- GitHub tracks the change against the original alert
- The alert remains open until the fix is merged into the default branch
- Once merged, GitHub marks the alert as resolved

This ensures that remediation only completes when changes are officially part of the codebase.

Pull request workflows also ensure that security fixes go through the same review process as feature changes.

## Apply dependency updates through automated pull requests

For dependency-related vulnerabilities, GitHub supports remediation through dependency update workflows.

When vulnerable dependencies are detected:

- GitHub identifies affected packages and versions
- It suggests updated versions that resolve known vulnerabilities
- Tools like Dependabot create pull requests with updated dependencies

You review and merge these pull requests through the same workflow used for code changes.

This allows dependency remediation to scale across many repositories without requiring manual version tracking.

## Track alert state changes across repositories

As remediation progresses, GitHub automatically updates alert states.

Each alert moves through a lifecycle:

- Open - GitHub detects the issue
- In progress - a pull request introduces a fix
- Closed - the fix merges into the default branch

These state changes occur at the repository level and roll up into the campaign view.

Campaigns therefore reflect real-time remediation progress across all included repositories.

## Understand how remediation affects the campaign

As alerts close across repositories, the campaign updates automatically.

You observe:

- Reduction in open alerts within the campaign scope
- Increased number of resolved alerts across repositories
- Remaining alerts grouped by type, severity, or repository

This allows the campaign to act as a live view of risk reduction over time.

## Scale remediation through repeated workflows

When a campaign includes similar vulnerabilities across multiple repositories, you do not apply a single centralized fix.

Instead, you repeat the same remediation workflow across repositories:

- Identify the same vulnerability pattern in each repository
- Apply consistent fixes through pull requests
- Update dependencies where required
- Merge fixes independently per repository

This approach ensures consistency while preserving repository-level control and review.