There are various ways that the settings in a GPO might apply to a user or computer:

- Scope determines the candidate GPO list.
- Filtering determines which candidate GPO apply.
- Precedence determines the source of single-valued settings.
- Extension semantics determine how additive or ordered settings combine.

:::image type="complex" source="../media/policy-scope-precedence.svg" alt-text="Diagram that shows LSDOU precedence, filtering, inheritance, and loopback processing.":::
[Diagram that shows LSDOU precedence, filtering, inheritance, and loopback processing.]
:::image-end:::

## Build the candidate list

Domain Group Policy processes in this order:

1. Local Group Policy.
1. Site-linked GPOs.
1. Domain-linked GPOs.
1. Organizational unit-linked GPOs from the highest parent to the child containing the object.

This order is commonly called LSDOU: Local, Site, Domain, Organizational Unit. Later processing usually has higher precedence for the same single-valued setting.

At one site, domain, or organizational unit, link order `1` has the highest precedence. The client processes lower-precedence links first, then the link with order `1`.

Always map both objects:

- Computer settings use the computer account location.
- User settings use the user account location.
- Loopback can add or replace user settings based on the computer location.
- Site-linked policy depends on the computer's AD site, which depends on subnet configuration.

## Evaluate inheritance controls

The following controls determine GPO application:

| Control | Effect | Diagnostic evidence |
| --- | --- | --- |
| Disabled link | Removes that link from processing | GPMC link state |
| Disabled GPO side | Skips user or computer configuration | GPO status, denied or empty result |
| Block Inheritance | Stops nonenforced inherited links from higher containers | GPMC inheritance view |
| Enforced link | Survives Block Inheritance. Prevents lower containers from overriding conflicting settings | GPMC link properties, RSoP precedence |
| Empty side | Contains no configured settings for the requested scope | `gpresult` denial or component data |

Block Inheritance doesn't block a GPO linked directly to the container. It also doesn't block an enforced parent link.

An enforced link is a link property. Block Inheritance is a container property. This distinction matters when the same GPO has multiple links.

## Identify winning plus contributing sources

For a managed registry value, resultant policy can often identify one winning GPO. For additive settings, the effective result can include several sources.

Examples:

- Several startup scripts can run in order.
- Multiple firewall rules can remain active.
- Several preference items can process.
- Security policy can combine settings with extension-specific rules.

Ask two questions:

- Which GPO has precedence for this setting?
- Does this extension use single-winner, merge, append, replace, or ordered processing?

The phrase "winning GPO" is incomplete when the extension allows multiple contributors.

## Diagnose security filtering

A target needs effective **Read** plus **Apply Group Policy** permissions. Security filtering in GPMC primarily exposes principals with Apply permission. The Delegation tab exposes the wider access control list.

Common failures include:

- Target user or computer isn't a member of the filtered group.
- Group membership changed after the current security token was created.
- An explicit deny overrides an allow.
- The GPO grants Apply but not Read.
- The GPC permissions differ from the GPT permissions.
- A user GPO becomes unreadable to the computer that retrieves user policy.

### Preserve computer read access for user policy

When **Authenticated Users** is removed from a user GPO's security filtering, the computer still needs Read access to retrieve the policy. A common design grants the intended user group **Read** plus **Apply Group Policy**, while **Authenticated Users** or **Domain Computers** retains Read through delegation without Apply.

Evidence can show:

- The user is in the intended group.
- The GPO is denied or inaccessible.
- Operational events report access failure.
- `Get-GPPermission -Name '<GPO name>' -All` shows missing read access.

Don't grant broad Apply permission to solve a problem that can be solved by using the **Read** permission.

### Trace nested, cross-domain, and token evidence

Group membership isn't evaluated against every directory change in real time. It's represented in a security token that's built at authentication.

Token refresh points:

- User group changes generally require a connected sign-out plus sign-in for a new user token.
- Computer group changes generally require a restart for a new computer token.
- Kerberos ticket plus PAC freshness, existing resource sessions, the local interactive token, plus cached RSoP group data are separate evidence. Policy refresh doesn't rebuild every token.

Trace the evidence in the following order:

1. Capture the GPO trustee (SID) plus standard permission levels with `Get-GPPermission -All -Server`.
1. Use GPMC **Delegation > Advanced** when an explicit deny, nonstandard right, or exact access control entry recovery matters.
1. Trace each immediate nested hop. Use recursive output only as flattened leaf corroboration.
1. Validate that each group is security-enabled plus that its scope permits the membership.
1. Compare directory membership with the affected user's current token in the relevant logon session.
1. For user policy, separately prove computer Read access.
1. For a cross-domain path, record the account domain, each group-owning domain, GPO domain, Group Policy processing domain controller, plus logon or authentication domain controller.
1. When Universal membership is implicated in a multidomain forest, determine whether a Global Catalog or Universal Group Membership Caching supplied current membership. Don't assume every path uses a Global Catalog.

Group scope controls both valid membership plus where a GPO permission can be granted:

| Scope | Membership rule | GPO permission implication |
| --- | --- | --- |
| Global | Accounts plus Global groups from the same domain | Can be granted permission in its forest plus trusting domains or forests. Foreign-domain principals aren't direct members |
| Universal | Accounts, Global groups, plus Universal groups from any domain in the same forest | Can be granted permission forest-wide plus in trusting forests. Global Catalog or Universal Group Membership Caching plus token-creation timing matter only when Universal membership is part of the path |
| Domain Local | Accounts, Global groups, plus Universal groups from any domain or trusted forest; Domain Local groups only from the same domain | Grants permission only in its own domain. For a GPO access control list, use a Domain Local group in the GPO or resource domain |

Read-only membership plus permission evidence `whoami /groups`

In PowerShell:

```powershell
# First hop; repeat for each nested child group to retain the path.
Get-ADGroupMember -Identity 'GPO-AppServers-Apply' `
    -Server 'DC01.contoso.com' |
    Select-Object Name,ObjectClass,DistinguishedName,SID

# Flattened leaf corroboration; intermediate nesting isn't retained.
Get-ADGroupMember -Identity 'GPO-AppServers-Apply' -Recursive `
    -Server 'DC01.contoso.com' |
    Select-Object Name,ObjectClass,DistinguishedName,SID
```

Determine permissions:

```powershell
$permissionQuery = @{
    Name       = 'Application Server Settings'
    All        = $true
    DomainName = 'contoso.com'
    Server     = 'DC01.contoso.com'
}
Get-GPPermission @permissionQuery
```

Command limitations:

- `whoami /groups` shows the invoking process's current user token. Standard, elevated, plus UAC-filtered tokens can differ. It doesn't show the computer token, a future token, or current directory state.
- `Get-ADGroupMember` reads directory membership from the named AD instance. `-Recursive` doesn't preserve the nesting path, and remote-forest resolution can fail when prerequisites such as Active Directory Web Services aren't available.
- `Get-GPPermission` reports GPO trustee permission levels. It doesn't calculate effective nested or token access, and it doesn't prove the named-DC GPT access control list.

## Diagnose WMI filtering

A GPO can link to one WMI filter. The filter runs on the destination computer for both user-side and computer-side processing.

When diagnosing whether a problem is caused by a WMI filter, validate:

- Namespace.
- Query syntax.
- Returned properties.
- Operating-system version assumptions.
- Product type.
- Provider health.
- Evaluation duration.

For Windows Server targeting, `Win32_OperatingSystem.ProductType` is more reliable than assuming a different major version:

```sql
SELECT * FROM Win32_OperatingSystem WHERE ProductType = 3
```

Values are:

- `1` - Client.
- `2` - Domain controller.
- `3` - Member server.

Avoid broad or expensive providers. `Win32_Product` can trigger Windows Installer consistency checks plus materially delay processing. Prefer a direct registry, file, service, or narrower WMI test when possible.

A false result is a filtering decision. A query error, provider failure, or timeout is a processing failure. The operational log distinguishes them.

## Separate filtering from item-level targeting

Security filtering plus WMI filtering determine whether the GPO applies. Group Policy Preferences item-level targeting determines whether one preference item processes after the GPO is already in scope.

Item-level targeting can inspect:

- Group membership.
- Operating system.
- Internet Protocol address range.
- Registry data.
- File presence.
- Environment variables.
- LDAP queries.

> [!NOTE]  
> Filtering isn't a security boundary. A user who can read the GPO can read preference configuration. Never place secrets in preference XML.

## Diagnose loopback processing

Loopback applies user settings based on computer scope. Configure it as computer policy under:

**Computer Configuration > Policies > Administrative Templates > System > Group Policy > Configure user Group Policy loopback processing mode**

| Mode | Processing |
| --- | --- |
| Merge | Process the user's normal GPO list. Then process user settings from GPOs in the computer's scope. Computer-scope user settings have later precedence. |
| Replace | Ignore the user's normal GPO list. Process only user settings from GPOs in the computer's scope. |

For every loopback incident, record:

- User location.
- Computer location.
- GPO that enables loopback.
- Loopback mode.
- GPO that contains the expected user setting.
- Link scope of that user-setting GPO.
- User-side GPO status.
- Security filtering plus Read access.

Example:

- User `Adele` is in `OU=Sales Users`.
- Computer `KIOSK01` is in `OU=Kiosks`.
- Loopback Replace is enabled through a GPO linked to `OU=Kiosks`.
- `Sales User Settings` is linked only to `OU=Sales Users`.

`Sales User Settings` won't supply the user configuration during that sign-in. Replace mode gathers user settings from GPOs in the kiosk computer's scope.

## Verify site placement

Site-linked GPOs depend on the client's site. The site depends on the client Internet Protocol address matching an AD subnet object.

Unexpected site policy can result from:

- Missing subnet.
- Overlapping subnet.
- Stale virtual private network address assignment.
- Client using a domain controller in another site.
- Incorrect site-link design.


```console
nltest /dsgetsite
```

Compare the reported site with the expected subnet object plus the site shown in Group Policy evidence.

Scope diagnosis ends when you can explain the candidate list, each denial, plus every winning or contributing source. Only then investigate retrieval or extension processing.
