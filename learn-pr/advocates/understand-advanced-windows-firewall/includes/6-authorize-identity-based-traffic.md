Address scope identifies a network location. Identity-based policy verifies who or what initiated the traffic. Windows can combine user identity, computer identity, address scope, and connection protection. If you want to use identity such as user or group in a filewall rule, the traffic must also be authenticated through IPsec.

For example, the following identity-based inbound firewall rule permits authenticated WMI traffic only when the remote user belongs to the `contoso\HelpDesk` domain security group.

```powershell
$group = New-Object System.Security.Principal.NTAccount("contoso\HelpDesk")
$groupSid = $group.Translate(
    [System.Security.Principal.SecurityIdentifier]
).Value
$helpDeskSDDL = "D:(A;;CC;;;$groupSid)"

New-NetFirewallRule `
    -DisplayName "Allow WMI for contoso\HelpDesk" `
    -Direction Inbound `
    -Action Allow `
    -Protocol TCP `
    -LocalPort RPC `
    -Authentication Required `
    -RemoteUser $helpDeskSDDL
```

## Use dual identity for privileged access

Assume an attacker steals a privileged account. A user-only rule can still authorize the attacker from a compromised workstation.

A stronger rule requires:

- Membership in an authorized user group
- Membership in an authorized computer group
- A valid security association
- The correct protected service
- The correct profile

For example, the following rule allows inbound WMI traffic on the **Domain** profile only when the connection has a valid IPsec security association and both the remote user and computer belong to their respective authorized Contoso groups.

```powershell
function Get-GroupSddl {
    param([Parameter(Mandatory)][string]$Group)

    $account = [System.Security.Principal.NTAccount]::new($Group)
    $sid = $account.Translate(
        [System.Security.Principal.SecurityIdentifier]
    ).Value

    "D:(A;;CC;;;$sid)"
}

$authorizedUsers = Get-GroupSddl "contoso\HelpDesk"
$authorizedComputers = Get-GroupSddl "contoso\ManagedComputers"

New-NetFirewallRule `
    -DisplayName "Allow secured WMI from authorized identities" `
    -Direction Inbound `
    -Action Allow `
    -Profile Domain `
    -Protocol TCP `
    -LocalPort RPC `
    -Service Winmgmt `
    -Authentication Required `
    -RemoteUser $authorizedUsers `
    -RemoteMachine $authorizedComputers
```

The corresponding IPsec policy must authenticate both the user and computer so Windows can establish the required security association and evaluate both group memberships.

## Build identity groups around roles

Use dedicated groups such as:

- Privileged remote management users
- Privileged administration workstations
- Approved support users
- Approved support devices
- Human resources application users
- Human resources application servers

Avoid using broad groups such as all domain users or all domain computers for sensitive access.

Group lifecycle matters. Connect membership to joiner, mover, leaver, privilege review, and device compliance processes.

## Combine identity with network scope

Identity doesn't make address scope obsolete. Layer the controls:

| Control | Security purpose |
|---|---|
| Remote address | Restrict the network origin |
| Computer group | Restrict the managed device identity |
| User group | Restrict the interactive or service identity |
| Program or service | Restrict the local listener |
| Profile | Restrict the network category |
| Internet Protocol security | Authenticate and protect the path |

This combination limits policy failure from any single assumption.

## Use exceptions deliberately

An exception group excludes identities that would otherwise match an allow rule.

Example:

- Allow: approved support users
- Exclude: restricted support users
- Require computer: approved support devices

Use exceptions when the business rule is stable and centrally governed. Excessive exception layers make effective authorization difficult to reason about.

## Protect Windows Remote Management

A high-value design can require:

- Inbound local port `5985`
- Domain profile
- Approved management subnet
- Privileged remote management user group
- Privileged workstation computer group
- Authenticated, integrity-protected traffic

Use encryption when the application layer doesn't already provide adequate confidentiality or when policy requires network-layer protection.

## Validate authorization failure

Test four cases:

- Authorized user from authorized device: permit.
- Authorized user from unauthorized device: deny.
- Unauthorized user from authorized device: deny.
- Authorized identities without compatible security negotiation: deny.

Don't validate only the success path. Negative tests prove that each authorization dimension is effective.

> [!TIP]
> Use separate user and computer groups. A combined naming standard makes policy intent visible during review.
