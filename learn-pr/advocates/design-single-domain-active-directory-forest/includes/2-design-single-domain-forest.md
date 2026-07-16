A single-domain forest contains one forest root domain and no child or tree domains. All writable domain controllers hold a full replica of the same domain directory partition. Any writable domain controller can authenticate any account in the forest.

## Use the simplest structure that meets the requirements

Choose one domain when administrative delegation, policy variation, regional operations, or password requirements can be implemented with organizational units, Group Policy, fine-grained password policies, and access control.

A single-domain forest provides these operational properties:

- One set of domain service-administrator groups
- One domain password and Kerberos policy boundary
- No cross-domain object moves
- No interdomain group-membership replication
- No infrastructure-master and global-catalog placement conflict
- No domain trust path to troubleshoot inside the forest
- All domain controllers can be global catalogs without extra partial replicas

The main tradeoff is replication scope. Every domain controller receives every object and attribute in the domain partition. Sites and schedules control when traffic crosses WAN links, but they don't prevent domain data from reaching a site that hosts a domain controller.

Single domain forests meet most organizational requirements. You don't need a multiple domain forest to achieve the following goals:

- Delegate administration
- Apply different Group Policy settings
- Use different password policies
- Reflect departments or geographically segmented political areas
- Reduce the number of objects visible to administrators

Those goals don't require a domain boundary. Additional domains increase DNS, trust, global catalog, service-account, Group Policy, and recovery complexity.

## Select the forest root DNS name

Use a DNS namespace that the organization owns and can operate for the lifetime of the forest. A delegated subdomain such as `corp.contoso.com` usually separates AD-integrated DNS from the public `contoso.com` zone while preserving a verifiable suffix.

| Option | Benefit | Design risk |
| --- | --- | --- |
| `corp.contoso.com` | Clear delegation and separation from public records | Requires internal delegation and suffix planning |
| `contoso.com` | Users and resources share one suffix | Requires deliberate split-brain DNS and record ownership |
| An unregistered suffix such as `contoso.local` | No public collision at deployment time | Nonroutable UPNs, certificate friction, and future integration cost |
| A single-label name such as `CONTOSO` | Short legacy name | Unsupported design assumptions and DNS interoperability problems |

Treat the forest root name as durable. Domain rename is disruptive and many directory-dependent products impose additional restrictions.

## Separate the DNS name, UPN suffix, and NetBIOS name

These identifiers serve different clients:

- The AD DS DNS name identifies the domain and DNS service records
- The UPN suffix identifies user sign-in names
- The NetBIOS name supports legacy interfaces

For example:

| Identifier | Value |
| --- | --- |
| AD DS DNS name | `corp.contoso.com` |
| User UPN suffix | `contoso.com` |
| NetBIOS name | `CONTOSO` |

Add the routable UPN suffix before large-scale account provisioning. Changing UPNs later affects synchronization, certificates, applications, scripts, and user communication.

Windows Server 2025 DC Locator favors DNS domain names and blocks NetBIOS-based discovery by default. New designs should use `corp.contoso.com`, not `CONTOSO`, in application and automation settings.

## Record the decision

The forest decision record should state:

- The business and security boundary served by the forest
- Why one domain is sufficient
- The owned DNS suffix and delegation authority
- The user-facing UPN suffix
- The legacy NetBIOS name
- Applications that impose namespace constraints
- Conditions that would require a separate forest

For additional design background, see [Reviewing the domain models](/windows-server/identity/ad-ds/plan/reviewing-the-domain-models).
