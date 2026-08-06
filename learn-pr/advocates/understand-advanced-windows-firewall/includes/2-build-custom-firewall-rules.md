A firewall rule is an authorization statement over a traffic defined by its properties (often called a tuple). A basic firewall rule filters based on source address, destination address, port, or protocol. More advanced rules can filter traffic based on characteristics including program, service, profile, or identity. Strong rules constrain every stable property that represents the intended application flow.

In this module, you learn about managing Windows Firewall beyond enabling the built-in simple rules such as allowing HTTP access to the Internet Information Services web server.

## Basic firewall rule construction

The simplest way to manage Windows Firewall rule at scale is with the Windows Firewall PowerShell cmdlets. For example, to view effective enabled firewall rules, run the command:

```powershell
Get-NetFirewallRule -PolicyStore ActiveStore -Enabled True |
  Select-Object DisplayName, Direction, Action, Profile
```

To view which ports and addresses are configured for a specific rule run:

```powershell
Get-NetFirewallRule -DisplayName "Rule name" |
  Get-NetFirewallPortFilter
```

To create an inbound rule that allows HTTPS traffic:

```powershell
New-NetFirewallRule -DisplayName "Allow HTTPS" -Direction Inbound `
  -Protocol TCP -LocalPort 443 -Action Allow -Profile Domain,Private
```

And to manage existing rules use the following commands:

```powershell
Enable-NetFirewallRule  -DisplayName "Rule name"
Disable-NetFirewallRule -DisplayName "Rule name"
Set-NetFirewallRule     -DisplayName "Rule name" -Action Block
Remove-NetFirewallRule  -DisplayName "Rule name"
```

## Define the traffic contract

Before you create a custom rule, determine the nature of the traffic flow you want the rule to address. You can create rules defined on the following elements:

| Property | Question |
|---|---|
| Direction | Which host initiates the connection? |
| Protocol | Which network protocol carries the traffic? |
| Local port | Which port does the protected host listen on? |
| Remote port | Is the source port fixed or dynamic? |
| Local address | Which interface or bound address receives traffic? |
| Remote address | Which systems may initiate traffic? |
| Program | Which executable owns the connection? |
| Service | Which service may use the rule? |
| Profile | On which network categories is the rule valid? |
| Identity | Which authenticated users or computers may connect? |

## Interpret local scope correctly

Local and remote are evaluated from the device that owns the rule.

For an inbound Windows Remote Management rule:

- The local port is `5985`.
- The remote port is usually `Any` because clients use dynamic source ports.
- The remote address is the management host or management subnet.
- The local address can select a dedicated management interface.

The following PowerShell code creates a rule of this type:

```powershell
New-NetFirewallRule -DisplayName 'Allow WinRM from management subnet' `
  -Direction Inbound -Action Allow -Protocol TCP `
  -LocalPort 5985 -RemotePort Any `
  -RemoteAddress '10.20.30.0/24' `
  -LocalAddress '10.20.30.10'
```

For a client browsing to a remote service on port `443`, the client doesn't listen on local port `443`. The remote service does. You don't need to create a rule to allow traffic outbound on port 443 (unless you've blocked outgoing traffic) as stateful inspection tracks the outbound connection and permits its response traffic. By default, only unsolicited inbound traffic will be blocked by rules, not communication initiated by the host.

## Prefer custom rules

Predefined rules can be useful, but they can enable more rule groups, profiles, protocols, or addresses than the design requires. A custom rule exposes the complete scope.

Use this sequenced progression:

1. Select the exact direction.
1. Select the protocol.
1. Set the listening port on the protected host.
1. Restrict the local address when the host has multiple interfaces or bindings.
1. Restrict the remote address to approved sources.
1. Restrict the program or service when the binding is stable.
1. Select only required profiles.
1. Require authentication for sensitive flows.

## Scope programs carefully

Instead of specifying which port to open, you can create firewall rules, known as path-based program rules, based the path to an executable on your host. A path-based program rule trusts the executable found at that path. You should be cautious using this type of rule as it doesn't establish publisher trust and weak file permissions can let an attacker replace the executable.

Use program scope when:

- The executable path is stable.
- The directory has strong access control.
- The application doesn't host unrelated services.

Service scope works in a similar manner to path-based program rules except you allow traffic to a service. Use service scope when a shared host process serves multiple Windows services. Service scope limits the rule to the selected service identity.

> [!WARNING]
> If using service scope, ensure that the service is configured to use a managed service account with minimal privileges.

You can also create firewall rules for application packages using the package's SID string. Packaged applications can be scoped through package identity. You might use this if you're using restrictive outbound controls and only want to allow known authorized packages to communicate with the network. This approach could be layered with application control policies to restrict which applications could run on a computer and which were granted access to remote network resources.

## Use addresses as authorization boundaries

Remote address scope is one of the highest-value controls. When creating rules for critical hosts, replace broad internal network address ranges with:

- Named management subnets
- Jump hosts
- Privileged workstations
- Application tiers
- Load balancers
- Monitoring collectors

Don't use address scope as proof of identity. Address assignment, routing, network address translation, and compromised hosts can invalidate that assumption. Combine addresses with authenticated computer or user identity for sensitive traffic.

## Apply deterministic naming

When creating firewall rules, provide useful names. A useful display name conveys ownership and intent. For example:

`Contoso - Inbound - Windows Remote Management - Privileged Workstations - Secure`

Keep a stable internal rule name for automation. Display names can change; scripts should prefer immutable identifiers or controlled policy-group membership.

## Create a scoped rule with PowerShell

The following example permits inbound Remote Desktop Management connections from an approved management subnet. 

```powershell
New-NetFirewallRule `
 -Name 'Contoso-RDP-Management-In' `
 -DisplayName 'Contoso - Inbound - Remote Desktop - Management subnet' `
 -Group 'Contoso - Remote management' `
 -Direction Inbound `
 -Action Allow `
 -Protocol TCP `
 -LocalPort 3389 `
 -RemoteAddress '10.40.8.0/24' `
 -Profile Domain `
 -Enabled True
```

Inspect the rule plus its associated filters:

```powershell
$rule = Get-NetFirewallRule -Name 'Contoso-RDP-Management-In'
$rule
$rule | Get-NetFirewallPortFilter
$rule | Get-NetFirewallAddressFilter
```

The rule object doesn't contain every filter property. Query associated filter objects when validating effective scope.

## Common faults when creating firewall rules

Avoid the following common faults when creating firewall rules

- Don't set the local port to the remote service port for client-initiated traffic.
- Don't restrict the remote port unless the source uses a stable port.
- Don't permit the full internal address space when only a management tier requires access.
- Don't enable every profile without a profile-specific requirement.
- Don't assume an application path proves publisher identity.
- Don't create a broad allow rule to hide an incomplete traffic inventory.
- Don't rely on the display name to identify policy origin.
