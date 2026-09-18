**Secure Score recommendation:** Restrict anonymous meeting access.

Anonymous participants don't present an identity that the tenant can verify reliably. Blocking anonymous join to meetings reduces untraceable attendance and limits harm from leaked meeting links.

## Distinguish external participant types

You shouldn't treat every external participant as anonymous. The following table distinguishes the external participant types.

| Type | Identity |
| --- | --- |
| Guest | Authenticated through a guest account in the tenant |
| External access user | Authenticated by a permitted external organization |
| Anonymous participant | Not signed in with an account the meeting can verify |

Guest access, external access, cross-tenant access, and anonymous access use different controls. Test them separately.

## Choose policy scope

The durable control is the per-organizer meeting policy. Set **Anonymous users can join a meeting** to off for organizers who mustn't host anonymous participants. Prefer the meeting policy for ongoing control. Use the organization-wide switch only when an immediate blanket block is required and current product behavior supports it.

## Configure the portal

To configure this policy in the portal, perform the following steps:

1. In the Microsoft Teams admin center, select **Meetings** > **Meeting policies**.
1. Open the policy assigned to target organizers.
1. Under **Meeting join & lobby**, turn **Anonymous users can join a meeting** off.
1. Save the policy.
1. Review all custom organizer policies.
1. If a tenant-wide immediate block is required, review **Meetings** > **Meeting settings** > **Participants**.

## Configure PowerShell

To configure this policy in the using PowerShell, perform the following steps, starting with recording the original meeting policy value:

```powershell
$originalAnonymousJoin = (
    Get-CsTeamsMeetingPolicy -Identity $teamsPolicy
).AllowAnonymousUsersToJoinMeeting

$originalAnonymousJoin
```

Then block anonymous participants for organizers assigned the policy:

```powershell
Set-CsTeamsMeetingPolicy `
    -Identity $teamsPolicy `
    -AllowAnonymousUsersToJoinMeeting $false
```

Then verify using the following commands:

```powershell
Get-CsTeamsMeetingPolicy -Identity $teamsPolicy |
    Select-Object Identity, AllowAnonymousUsersToJoinMeeting
```

In the event that current tenant requirements justify the control being applied organization-wide, run the following command:

```powershell
Set-CsTeamsMeetingConfiguration `
    -Identity Global `
    -DisableAnonymousJoin $true
```

Confirm current service guidance before relying on the organization-wide property because its lifecycle differs from the meeting policy.

## Validate access

To validate the implementation, run the following test:

1. Create a new meeting from an organizer assigned the policy.
1. Open the link in a private browser session.
1. Don't sign in.
1. Confirm that anonymous participation is blocked.
1. Join as an authenticated guest. Confirm the guest follows guest policy.
1. Join from a permitted external organization. Confirm external access behavior.
1. Check a meeting created by an organizer with a different custom policy.

The unsigned browser test proves anonymous behavior. It doesn't prove guest or external access behavior.

> [!NOTE]
> Anonymous join can be required for public webinars, customer support, recruiting, healthcare, education, or community events. Use a dedicated organizer population and policy where legitimate anonymous access is required. Keep the secure default for other organizers.
