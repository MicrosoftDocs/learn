Continuous Delivery enables on-demand software delivery through automated processes.

Deployment represents the technical implementation of software installation, while release processes encompass the organizational workflows required for production delivery.

Technical deployment capabilities must integrate with approval workflows to establish comprehensive release governance.

Release approvals control _whether_ deliveries proceed rather than _how_ deployments execute.

Manual approvals address organizational trust and governance requirements. Organizations beginning Continuous Delivery adoption often require human validation before production releases.

As confidence builds through successful deployments, manual approvals typically evolve into automated quality gates and validation checks.

Key considerations for release approval design:

- **Purpose**: Define approval objectives - compliance requirements (SOX four-eyes principle), dependency management, or authority sign-off from security officers or product owners.
- **Approvers**: Identify required approval roles including product owners, security officers, or code reviewers. Approver availability directly impacts deployment velocity.
- **Timing**: Determine approval placement in the deployment pipeline. Consider whether processes can continue without approval or require complete holds. Scheduled deployments can decouple approval from deployment execution.

Manual approvals provide release control but may introduce unnecessary delays in automated pipelines.

Earlier approval stages, such as source control change validation, can improve efficiency without compromising governance.

Scheduled deployments resolve timing dependencies by eliminating real-time human intervention requirements.

Automated approvals and release gates provide release control while eliminating manual intervention bottlenecks.

- [Release approvals and gates overview](/azure/devops/pipelines/release/approvals/approvals).
