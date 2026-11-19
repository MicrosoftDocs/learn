With the ISOC operating model in mind, you next establish whether the organization can participate in the current preview before you select capabilities. Separate eligibility from implementation readiness: a tenant can be eligible even when the organization isn't ready to govern or operate the capabilities.

## Check preview eligibility

During this phase of the preview, ISOC is available to eligible customers that meet both conditions:

- The organization has an active, eligible Microsoft Defender Suite, Microsoft 365 E5, or Microsoft 365 E7 license.
- The organization doesn't have an active Microsoft Sentinel workspace.

If the organization has an active Microsoft Sentinel workspace, its plan should continue using the existing Microsoft Sentinel experience during this preview phase.

> [!IMPORTANT]
> Don't disconnect a production Microsoft Sentinel workspace only to qualify for the ISOC preview. Record the tenant as ineligible for this preview phase and monitor the official ISOC documentation for changes.

License ownership doesn't establish that every capability is included at no additional cost. Some optional capabilities and additional data ingestion have separate cost considerations. Confirm the licensing and availability of each selected capability as part of planning.

## Distinguish workspace prerequisites

An eligible organization can begin with built-in capabilities that don't require an ISOC workspace. If selected capabilities require a workspace, the plan also needs:

- An active Azure subscription.
- A person with the **Security Administrator** role in Microsoft Entra ID.
- One of these Azure subscription permission configurations:
  - Unconditional **Owner**.
  - **User Access Administrator** and **Microsoft Sentinel Contributor**.

These permissions apply to creating an ISOC workspace. Day-to-day feature access uses capability-specific Microsoft Defender unified role-based access control (RBAC), Microsoft Entra roles, or Microsoft Sentinel roles, depending on the capability and tenant configuration.

Don't assign broad permanent access only because workspace creation requires elevated permissions. Identify who performs provisioning, who administers capabilities, and who consumes security data. Apply least privilege to each responsibility and include an access review in the plan.

## Assess organizational readiness

Complete a readiness review across the following areas:

| Area | Planning questions | Evidence |
| --- | --- | --- |
| Tenant and licenses | Is the tenant eligible? Is there an active Microsoft Sentinel workspace? Which licenses are active? | Tenant inventory and license records |
| Azure | Is a subscription available if a workspace is needed? Who has the required permissions? | Subscription and role assignment inventory |
| Security operations | Which processes move into the shared experience? Who owns each workflow? | Process maps and responsibility assignments |
| Data | Which native Defender and additional data sources support defined outcomes? | Data source inventory and data owners |
| Access | Which roles need read, manage, or administrative access, and at which scopes? | RBAC design and scope map |
| Governance | How are changes reviewed, tested, approved, and audited? | Change and control requirements |
| Preview risk | Which production dependencies are acceptable for a changing preview capability? | Risk acceptance and fallback criteria |

## Record a readiness decision

Summarize the review as one of these planning decisions:

- **Not eligible:** Keep current operations and monitor preview eligibility changes.
- **Eligible, built-in start:** Begin planning capabilities that don't require a workspace.
- **Eligible, workspace candidate:** Continue to workspace, data, access, retention, and cost analysis.
- **Eligible, not operationally ready:** Resolve ownership, governance, data, or access gaps before adoption.

This decision prevents the organization from treating workspace creation as the start of planning. It also creates a traceable reason to proceed, pause, or limit the evaluation.
