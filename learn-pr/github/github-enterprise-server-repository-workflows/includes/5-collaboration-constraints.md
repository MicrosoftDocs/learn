GitHub Enterprise Server environments are intentionally constrained to support security, compliance, and operational control. Understanding these constraints helps teams collaborate effectively without frustration.

### In this unit, you'll learn

- How infrastructure constraints affect collaboration
- How automation differs from GitHub.com
- Why coordination with platform teams matters

### Infrastructure and automation realities

On GHES, automation such as GitHub Actions relies on self-hosted runners managed by the organization. These runners may be limited in number, capacity, or network access, which can affect workflow performance and reliability. External dependencies may require mirrors or proxies, and some cloud-native features are unavailable.

These limitations mean that collaboration and automation must be designed with the environment in mind rather than assuming cloud defaults.
 
Some enterprises run CI/CD outside of GHES (for example, with internal build systems) and integrate results back into pull requests as status checks. Feature availability and integrations can also vary based on how the GHES instance is configured and what is approved by the platform team.

### Working with platform and DevOps Teams

In self-managed environments, platform and DevOps teams are responsible for the underlying GHES infrastructure. Developers often depend on these teams to enable features, maintain runners, and resolve infrastructure issues.

Effective collaboration includes understanding platform constraints, communicating requirements early, and treating platform teams as partners in the development process rather than external service providers.

### Step-by-step: Diagnose a failing check or workflow (high-level)

When a required check fails or stays pending, use a methodical approach before escalating.

1. Open the pull request and identify the failing or pending check.
1. Open the check details to see logs, error messages, and timestamps.
1. Determine the likely failure type:

   - Test/build failure (code or configuration issue)
   - Dependency/network failure (proxy/mirror/outbound restrictions)
   - Runner capacity issue (jobs queued or runners offline)

1. Re-run checks if allowed after correcting the cause.
1. If the failure appears infrastructure-related, capture:

   - The name of the failing check
   - A link to the run/logs
   - Timestamp and any error message
   - Whether the issue is consistent across repositories or only this one

Provide this information to the platform or DevOps team to speed up resolution.

Key takeaway: GHES environments prioritize security and operational control, so effective teams plan for infrastructure constraints and collaborate closely with platform owners to keep delivery predictable.

With these constraints in mind, you can apply the repository, branching, protection, and pull request practices in this module to collaborate efficiently in enterprise-managed GHES environments.