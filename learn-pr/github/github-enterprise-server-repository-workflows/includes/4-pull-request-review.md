Pull requests are the primary collaboration mechanism on GitHub Enterprise Server. They bring together discussion, review, automation, and policy enforcement in a single workflow.

### In this unit, you'll learn

- How pull requests function in enterprise environments

- Best practices for creating effective pull requests

- The role of reviewers in GHES workflows

### Pull requests as formal change records

On GHES, a pull request represents more than a proposed code change. It is a formal record that captures the intent of the change, the discussion around it, the reviews performed, and the automated checks applied. Once merged, the pull request becomes part of the permanent history of the repository.

This makes pull requests a critical component of traceability and compliance, especially in regulated industries.

### Writing effective pull requests

Clear and well-scoped pull requests make collaboration smoother and faster. Effective pull requests explain why a change is being made, reference related issues or requirements, and keep changes focused and manageable. Smaller pull requests are easier to review and reduce the likelihood of errors slipping through.

Taking time to write a clear description often saves time later during review and approval.

### Merging and traceability expectations

Enterprise repositories often standardize how pull requests are merged to support traceability and consistent history. Depending on policy, teams may use merge commits to preserve full context, squash merges to keep history compact, or rebase merges to maintain a linear timeline. Developers should follow the repository's preferred merge method and ensure pull requests contain enough context-such as links to work items, incidents, or requirements-so the change can be understood later without relying on tribal knowledge.

### Common pull request workflow patterns

In enterprise environments, it is common to open pull requests early to start review and validation, even before the change is final. Draft pull requests can help teams collaborate while signaling that the work is still in progress. When reviewers request changes, developers should address feedback, push updated commits, and re-request review as needed to keep the process moving.

Keeping the pull request description updated as scope changes helps reviewers understand the current intent of the change and reduces repeated questions during review.

### Code review responsibilities

Reviewers on GHES play an active role in maintaining quality and compliance. Their responsibility is not only to check correctness but also to ensure that changes align with organizational standards and security expectations.

Because approvals may carry formal accountability, reviewers should be confident in the changes they approve. This reinforces trust in the collaboration process and the stability of protected branches.

### Step-by-step: Open a pull request and request review

Exact steps vary by organization, but this flow works in most GHES environments.

1. Push your branch to the remote repository (for example, feature/short-description).
1. In the GHES web UI, open the repository and select Compare & pull request (or create a new pull request manually).
1. Confirm:

   - Base branch is correct (commonly main)
   - Compare branch is your feature branch

1. Write a clear description using a simple checklist:

   - What changed and why
   - How it was tested (or why testing is not needed)
   - Any risk, rollout, or rollback notes
   - Links to issues, work items, or requirements

1. Request review from the appropriate reviewers:

   - If CODEOWNERS is used, request the required code owners for the affected paths.

1. Submit the pull request early, even if it is a draft, to start collaboration and catch issues sooner.

Key takeaway: Pull requests are the central coordination point on GHES, combining discussion, review, automation, and traceability into a single controlled workflow.

With pull request workflows established, the final piece is understanding how GHES operational constraints can influence collaboration speed, automation reliability, and escalation paths.