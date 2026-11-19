---
no_index_ks: true
---

When validation fails, use the configuration and test evidence to identify which requirement needs correction. Make the approved change within your authority, or request it through the appropriate access-management process before you verify the task again.

## Find the failed access check

Review the available setup and access records before deciding what to change. In this troubleshooting example, an administrator has produced a report, but an intended security practitioner can't view sessions:

| Check | Recorded result |
| --- | --- |
| Agent status | Enabled |
| Agent identity and API permissions | The configured identity has the documented grants. |
| Administrator test | The selected article was processed and a report was retrieved. |
| Security practitioner sign-in | The security practitioner can sign in to the Microsoft Defender portal. |
| Security practitioner session access | Sessions aren't visible to the security practitioner. |
| Security practitioner role review | Neither Security Reader nor Security Admin is assigned. |

The security practitioner's role record identifies the failure: viewing sessions requires at least Security Reader. Portal sign-in confirms authentication, while the role assignment determines access to sessions. The successful administrator run supplies evidence about source processing. The security practitioner's account still needs the required role and its own task test.

The missing account role doesn't justify adding API permissions to the agent. Assign Security Reader if you have role-management authority, or request the assignment through your organization's role-management process. Reserve Security Admin for tasks that need setup authority.

Follow the [documented Microsoft Entra role-assignment process](/entra/identity/role-based-access-control/manage-roles-portal?azure-portal=true). If someone else makes the assignment, retain their confirmation. Ask the security practitioner to sign in with the corrected access and check the agent-level execution, steering, and viewing settings as well.

Ask the security practitioner to retest the approved task with their account, including starting a new session, responding to the plan, and retrieving and reviewing the report. Record the new session reference, action results, and the security practitioner's output checks. Confirm readiness after the complete task passes.

## Record configuration readiness

Mark the configuration ready for the approved task when the required access checks and security practitioner test pass. Mark it not ready if required access or data is missing, a security practitioner can't complete a required action, or the output doesn't meet the agreed criteria.

Submit the readiness result and remaining limits through the organization's operational approval process. Obtain any required release approval before operational use.

If the team proposes a narrower task because a required feature is unavailable, obtain approval for the revised scope and criteria before retesting. Assess readiness against those agreed requirements.

## Hand over the result and ownership

Complete Readiness, limits, owners, and retest triggers in your setup record. Use that record for the handoff in the team's existing case, ticket, or shared work area. Check that it includes:

- The approved task.
- The configured agent identity.
- The security practitioner account or role.
- The checked data dependencies.
- The validation session and report references.
- Any remaining limits.
- The operational owner.

After correcting security practitioner access for extraction, a brief handoff could read as follows. Keep the identity, account, and actual session, report, and test references in the linked setup record:

> **Scope:** Extract threat intelligence from selected articles for security practitioner review. Detection deployment and environment changes remain outside the approved use.
>
> **Result:** The security practitioner's Security Reader assignment was corrected. A retest confirmed session start, plan response, report retrieval, and the agreed source and enrichment checks.
>
> **Evidence:** The linked setup record contains service confirmations, tested access, and session and report references. The configuration passed the agreed checks and is submitted for operational approval.
>
> **Follow-up:** I handle configuration and access issues. The security practitioner reviews findings and requests approval for broader work. We retest when changes affect the validated task.

Agree on retest triggers with the people responsible for configuration and ongoing use. These might be the same person. Record who handles each trigger. Changes to the agent identity, permissions, security practitioner role, or required data access can affect the checked task. A later request for coordinated protection also needs its own approval, requirements, and validation.
