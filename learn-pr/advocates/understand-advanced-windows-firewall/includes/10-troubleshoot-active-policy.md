When troubleshooting, examine the effective runtime path. Don't begin by editing the rule that appears most relevant.

## Use a fixed diagnostic sequence

The following diagnostic sequence can help you troubleshoot Windows Firewall:

1. Confirm the application is listening.
1. Confirm basic route and name resolution.
1. Confirm the active network profile.
1. Inspect the active policy store.
1. Identify the matching firewall rule.
1. Identify rule origin.
1. Confirm address, port, program, service, and profile filters.
1. Confirm connection security policy.
1. Confirm a security association.
1. Correlate firewall logs and packet capture.

## Inspect effective rules

You can inspect effective rules using the following command:

```powershell
Get-NetFirewallProfile -PolicyStore ActiveStore

Get-NetFirewallRule -PolicyStore ActiveStore -Enabled True |
  Select-Object DisplayName, Direction, Action, Profile, PolicyStoreSourceType
```

Trace a rule to its policy source:

```powershell
Get-NetFirewallRule `
  -PolicyStore ActiveStore `
  -DisplayName 'Contoso - Inbound - Windows Remote Management - Management subnet' `
  -TracePolicyStore |
  Select-Object DisplayName, PolicyStoreSource, PolicyStoreSourceType
```

> [!NOTE]
> `-PolicyStore ActiveStore` returns rules from the merged active policy. When used with `-TracePolicyStore`, `PolicyStoreSource` identifies the originating policy store and `PolicyStoreSourceType` identifies its category, such as `GroupPolicy`.

Query associated filters:

```powershell
$rule = Get-NetFirewallRule -DisplayName 'Contoso - Inbound - Windows Remote Management*'
$rule | Get-NetFirewallPortFilter
$rule | Get-NetFirewallAddressFilter
$rule | Get-NetFirewallApplicationFilter
$rule | Get-NetFirewallServiceFilter
```

Check for broad block rules before adding another allow rule. Explicit blocks can override overlapping allows.

## Inspect connection security state

```powershell
Get-NetIPsecRule -PolicyStore ActiveStore
Get-NetIPsecMainModeSA
Get-NetIPsecQuickModeSA
```

No main-mode association suggests failure before peer authentication completes. A main-mode association without a matching quick-mode association suggests traffic-selector or protection-policy mismatch.

Validate:

- Peer addresses
- Authentication method
- Trust chain
- Time synchronization
- Name resolution
- Cryptographic proposal compatibility
- Endpoint port assignment
- Profile applicability

## Interpret packet capture

Bidirectional negotiation packets show that both peers can exchange control traffic. One-way negotiation commonly indicates routing, filtering, missing peer policy, or service availability failure.

Filter for User Datagram Protocol port `500` during standard Internet Key Exchange negotiation. Include User Datagram Protocol port `4500` when Network Address Translation traversal applies.

Protected application traffic without application success can indicate:

- Firewall authorization failure
- User or computer group mismatch
- Application listener failure
- Application-layer authorization failure

## Avoid destructive fixes

Don't:

- Stop the firewall service.
- Add an unrestricted allow rule.
- Enable every profile without analysis.
- Remove block rules without checking their purpose.
- Disable authentication to hide negotiation failure.

Make one controlled change, reproduce the test, then compare evidence.
