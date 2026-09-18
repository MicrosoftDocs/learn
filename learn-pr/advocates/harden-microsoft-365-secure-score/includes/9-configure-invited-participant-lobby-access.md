**Secure Score recommendation:** Admit only invited meeting participants automatically.

A Teams meeting link can be forwarded, copied, or exposed to anyone, which means you may end up with people, or their AI agent delegates, in a Teams meeting that shouldn't be there. Requiring participants that haven't been directly invited to wait in the lobby gives an organizer, co-organizer, or presenter a chance to verify attendance.

## Understand policy scope

Microsoft Teams meeting policies are assigned to organizers. The policy attached to the organizer controls the meeting default.

The **People who were invited** lobby value allows invited participants to bypass the lobby. It can include:

- People sent the invitation directly.
- Members of an invited distribution list within supported limits.
- People who receive a forwarded invitation.

A signed-in user who has only the join link waits in the lobby. An unsigned-in anonymous participant also waits, unless another setting prevents participation entirely.

The policy sets a default. Organizers can change it in meeting options. Use a Microsoft Teams Premium meeting template or sensitivity label when a regulated meeting requires enforcement.

## Configure the portal

To configure this policy in the portal, perform the following steps:

1. Sign in to the Microsoft Teams admin center.
1. Select **Meetings** > **Meeting policies**.
1. Open the policy assigned to the target organizers.
1. Under **Meeting join & lobby**, locate **Who can bypass the lobby**.
1. Select **People who were invited**.
1. Save the policy.
1. Repeat the review for each custom meeting policy.

Changing only the Global policy doesn't affect organizers assigned a custom policy.

## Configure PowerShell

To configure the policy in PowerShell, first record the original value:

```powershell
$originalLobbyValue = (
    Get-CsTeamsMeetingPolicy -Identity $teamsPolicy
).AutoAdmittedUsers

$originalLobbyValue
```

Then set the invited-user default:

```powershell
Set-CsTeamsMeetingPolicy `
    -Identity $teamsPolicy `
    -AutoAdmittedUsers InvitedUsers
```

Verify with the following command:

```powershell
Get-CsTeamsMeetingPolicy -Identity $teamsPolicy |
    Select-Object Identity, AutoAdmittedUsers
```

Changes can take up to 24 hours to take effect.

## Test participant types

To test the policy, create a new test meeting after policy propagation. The following table defines the participant types and expected results.

| Participant | Expected result |
| --- | --- |
| Invited internal user | Bypasses lobby |
| Invited guest | Bypasses lobby |
| Invited user from a permitted external organization | Bypasses lobby |
| Signed-in internal user with only the join link | Waits in lobby |
| Anonymous user with only the join link | Waits in lobby or is blocked by anonymous policy |

Verify the exact result in the client. Guest access, external access, anonymous join, meeting options, templates, and sensitivity labels can change the outcome.

## Limit invitation forwarding

If only directly invited people should attend, disable invitation forwarding where the meeting workflow supports it. The lobby setting alone treats a valid forwarded invitation as invited.

For highly sensitive meetings:

- Use a sensitivity label or meeting template.
- Restrict forwarding.
- Restrict presenters.
- Disable anonymous join.
- Review recording, transcription, chat, application, and screen-sharing settings.
