Branch protection rules are one of the most important mechanisms for enforcing collaboration policies on GHES. They define the conditions that must be met before changes can be merged into protected branches.

### In this unit, you'll learn

- What branch protection rules control

- How review requirements are enforced

- How these rules affect daily development workflows

### What branch protection rules enforce

Branch protection rules specify how changes flow into important branches, particularly the default branch. In GitHub Enterprise Server, these rules commonly require that all changes be merged through pull requests rather than direct pushes. Organizations often require a minimum number of approving reviews and enforce automated status checks, such as builds or tests, before allowing a merge.

Additional protections may prevent force pushes, restrict who can merge changes, or block branch deletion. Together, these settings ensure that protected branches remain stable, traceable, and compliant with enterprise standards.

Organizations may also require review from code owners for specific paths, require conversations to be resolved before merging, enforce a specific merge method (such as squash merging), or require a linear commit history. Some enterprises also restrict who can push to protected branches, even through pull requests, to ensure only approved roles can complete merges.

## Repository rulesets: Policy at scale

In addition to traditional branch protection rules, GitHub Enterprise Server supports repository rulesets. Rulesets allow administrators to enforce policies across multiple branches or repositories from a centralized location.

While branch protection applies to individual branches, rulesets can target branch patterns or entire repositories. They can require pull requests, enforce status checks, restrict force pushes, require linear history, and mandate approvals.

The key difference is centralization. Policies are defined once and applied consistently, reducing configuration drift across repositories. For developers, the effect is the same: merges are blocked until requirements are met, but those requirements may now be enforced at enterprise scale.

Repository rulesets centralize and standardize governance across repositories.

### Review requirements as governance controls

In enterprise environments, code reviews are not just best practices; they are formal controls. Review requirements may include approval from designated code owners, dismissal of approvals when new changes are pushed, or enforcement of signed commits.

These requirements ensure that the right people review the right changes and that approvals reflect the final state of the code. Reviews become part of the organization's audit trail, demonstrating that changes were evaluated and approved according to policy.

### Developer experience with protected branches

For developers, branch protection rules define the boundaries of acceptable workflows. Merges may be blocked until all requirements are satisfied, and bypassing rules is typically not possible. While this can slow down urgent changes, it also reduces the risk of mistakes and provides confidence that merged code meets organizational standards.

Effective developers plan their work with these rules in mind, allowing time for reviews and checks rather than treating them as obstacles.

As a practical habit, developers should treat branch protection as a checklist: open the pull request early, confirm required reviewers (including code owners), watch status checks, and expect that new commits can reset approvals depending on policy. 

Planning for these steps reduces last-minute delays.

If merging is blocked, use the pull request details to identify exactly which requirement is unmet (for example, missing approvals, unresolved conversations, or failing status checks) before escalating to others.

## Branch queue (merge queue) for stable integration

In high-activity repositories, pull requests that pass checks individually can still break the default branch when merged concurrently. Branch queue (merge queue) reduces this risk by validating pull requests in merge order.

When enabled, approved pull requests enter a queue instead of merging immediately. Each pull request is validated against the latest base branch state before merging. If required checks fail during validation, the pull request is removed from the queue until fixed.

Branch queue helps maintain a consistently stable default branch. Developers may experience longer merge wait times, but gain greater predictability and fewer integration failures.

Branch queue improves branch stability by validating pull requests sequentially before merging.

### Step-by-Step: Identify why a merge is blocked

When a pull request can't be merged, branch protection rules will typically indicate what requirement is not satisfied.

1. Open the pull request in the GHES web UI.
1. In the merge section, identify the blocking reason (for example, missing approvals or failing checks).
1. Verify review requirements:

   - Are required reviewers assigned?
   - Are CODEOWNERS approvals required for the files you changed?
   - Were approvals dismissed due to new commits?

1. Verify checks:

   - Which required checks are failing?
   - Are checks still pending because runners are unavailable or queued?

1. Verify conversation and policy requirements:

   - Are review conversations required to be resolved?
   - Is a specific merge method required (squash/merge/rebase)?

1. Make the smallest change needed to satisfy the missing requirement (fix the failing check, request the required review, or resolve requested changes), then re-check merge eligibility.

If you still cannot determine the reason, include the merge-blocking message and the list of required checks/reviewers when asking for help.

Key takeaway: Branch protection rules translate enterprise policy into everyday workflow requirements, and successful collaboration depends on meeting those requirements consistently.

Once you understand what policies are enforced at the branch level, the next step is to see how pull requests bring reviews, checks, and discussions together into a single change workflow.