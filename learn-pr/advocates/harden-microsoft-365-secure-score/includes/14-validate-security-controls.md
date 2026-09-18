Implementation is complete only when effective behavior matches the design and you've validated that the security controls are in place. A portal value, successful command, or score increase alone is insufficient proof that a security control functions as intended.

The following table defines the evidence fields to record for every action.

| Field | Purpose |
| --- | --- |
| Control | Identifies the requirement |
| Owner | Establishes accountability |
| Configuration | Records policy, setting, scope, exclusions |
| Test | Defines expected behavior |
| Result | Captures observed behavior |
| Evidence | Links logs, exports, configuration captures, or tickets |
| Exception | Records rationale, approver, expiry |
| Rollback | Defines safe reversal |
| Review date | Prevents stale control assumptions |

Don't include secrets, real emergency account names, access tokens, or sensitive sign-in data in broadly accessible evidence.

## Validate Conditional Access

To validate conditional access, list the module policies:

```powershell
$modulePolicies = @(
    Get-MgIdentityConditionalAccessPolicy -All |
        Where-Object DisplayName -Like 'CA00*'
)

$modulePolicies |
    Select-Object Id, DisplayName, State |
    Sort-Object DisplayName
```

Confirm that expected policies exist once and are in the intended state. Duplicate policies can create unexpected cumulative requirements.

For each policy:

- Use the What If tool.
- Review report-only events.
- Test a positive case.
- Test a negative case.
- Test an exclusion.
- Test overlapping policies.
- Confirm unsupported dependencies are remediated.
- Enable during a monitored window.

Enable one verified policy by exact identifier:

```powershell
Update-MgIdentityConditionalAccessPolicy `
    -ConditionalAccessPolicyId '<policy-id>' `
    -State enabled
```

Don't enable every report-only policy in one bulk command. Performing changes incrementally, preserve attribution, and the ability to rollback.

If a policy causes harm, you can disable it using PowerShell similar to the following:

```powershell
Update-MgIdentityConditionalAccessPolicy `
    -ConditionalAccessPolicyId '<policy-id>' `
    -State disabled
```

Investigate a malfunctioning policy before editing or deleting it.

## Validate identity risk

To validate identity risk settings confirm:

- Medium-risk and high-risk sign-ins require fresh strong authentication.
- High-risk users enter the adaptive remediation flow.
- Password-backed users can complete secure password change.
- Passwordless users can reauthenticate after session revocation.
- Synchronized users can complete password writeback.
- Active risk detections have an investigation outcome.
- Legacy risk policies are migrated before October 1, 2026.

Review false positives. Don't reduce policy scope to hide unresolved detection quality problems.

## Validate application consent

To validate application consent policies are functioning as expected, confirm:

- A standard user can't grant new delegated consent directly.
- The administrator consent request workflow operates.
- Reviewers receive requests.
- Decisions appear in audit logs.
- Existing grants have an owner and risk decision.
- Application permissions are reviewed separately.

## Validate Microsoft Teams

To validate that Microsoft Teams policies are functioning as expected, first read the configured meeting policy:

```powershell
Get-CsTeamsMeetingPolicy -Identity $teamsPolicy |
    Select-Object `
        Identity,
        AutoAdmittedUsers,
        DesignatedPresenterRoleMode,
        AllowAnonymousUsersToJoinMeeting
```

Then confirm policy assignment for each test organizer. Then run meetings with:

- An invited internal user.
- An uninvited internal user.
- An invited guest.
- A permitted external user.
- An anonymous browser participant.
- An ordinary attendee.
- A promoted presenter.

Then run an experiment to verify that:

- Only invited participants bypass the lobby by default.
- Ordinary participants enter as attendees.
- Anonymous participants can't join for restricted organizers.

Wait up to 24 hours after policy changes. Create a new meeting after propagation.

## Validate privileged access

To validate privileged access policies are functioning as expected, confirm:

- Broad standing roles have approved justification.
- Replacement roles perform required tasks.
- Unrelated tasks remain blocked.
- Eligible assignments require the configured activation controls.
- Activation expires.
- Emergency access remains available.
- New privileged assignment alerts work.
- Recurring access reviews have owners.

Don't remove a broad role merely to improve the score. Remove it after a tested replacement exists.

## Validate password reset

To validate Self Service Password Reset policies function as expected, confirm:

- **Self service password reset enabled** is set to **All**.
- Users are enabled, registered, and capable.
- A non-administrator can reset a password.
- Notifications arrive.
- Help desk guidance works.
- Hybrid writeback updates the authoritative password.
- Authentication methods conform to the current method policy.

## Account for Secure Score refresh

Reopen each recommendation after source-product validation. Record the implementation date. Microsoft Entra recommendation state can refresh weekly. Microsoft Teams recommendation state can refresh monthly.

If a recommendation remains unchanged:

1. Recheck effective scope.
1. Check custom policies that override the setting.
1. Confirm all applicable users or organizers are covered.
1. Confirm the source product reports the expected value.
1. Wait for the documented refresh period.
1. Open a support case only after evidence confirms a detection mismatch.

Don't weaken a working control to force a score transition.

## Monitor continuously

Create operational monitoring to keep track of:

- Conditional Access policy changes.
- Emergency access sign-ins.
- Legacy authentication attempts.
- Risk detections and remediation failures.
- New application grants.
- Privileged role assignments and activations.
- Authentication method changes.
- Password writeback failures.
- Microsoft Teams policy drift.

Treat exceptions as expiring risk decisions. Every exception needs an owner, compensating control, review date, and removal plan.
