Password protection is a feature of Microsoft Entra ID that reduces the risk of users setting weak passwords. Microsoft Entra password protection detects and blocks known weak passwords and their variants, and can also block other weak terms that are specific to your organization.

With Microsoft Entra password protection, default global banned password lists are automatically applied to all users in a Microsoft Entra tenant. To support your own business and security needs, you can define entries in a custom banned password list. When users change or reset their passwords, these lists are checked to enforce the use of strong passwords.

You should use other features like Microsoft Entra multifactor authentication, not just rely on strong passwords enforced by Microsoft Entra password protection. Passwords alone, even strong ones, aren't as secure as multiple layers of security.

### Global banned password list

The Microsoft Entra ID Protection team constantly analyzes security telemetry data looking for commonly used weak or compromised passwords. When weak terms are found, they're added to the global banned password list. The contents of the global banned password list aren't based on any external data source but on the results of Microsoft Entra security telemetry and analysis from real-world password spray attacks.

The global banned password list is automatically applied to all users in a Microsoft Entra tenant. There's nothing to enable or configure, and it can't be disabled. When users change or reset their password, the new password is validated against this list. The password validation algorithm uses smart fuzzy-matching techniques to efficiently detect and block millions of common weak passwords and their variations.

### Custom banned password lists

Organizations can create custom banned password lists to add terms specific to their business. Terms added to the custom banned password list should focus on organizational-specific terms such as:

- Brand names
- Product names
- Locations, such as company headquarters
- Company-specific internal terms
- Abbreviations that have specific company meaning

When terms are added to the custom banned password list, they're combined with the global banned password list. Password change or reset events are then validated against the combined set. The custom banned password list is limited to a maximum of 1,000 terms. It isn't designed for blocking extremely large lists of passwords—instead, adding key base terms is more effective because the password validation algorithm automatically blocks weak variants and combinations.

Licensing requirements for password protection vary depending on whether you use the global or custom banned password list and whether users are cloud-only or synchronized from on-premises AD DS. For details, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

### How passwords are evaluated

When a user changes or resets their password, the new password is checked for strength by validating it against the combined global and custom banned password lists. Even if a user's password contains a banned term, the password might be accepted if the overall password is strong enough. The evaluation follows these steps:

1. **Normalization**—the password is converted to lowercase, and common character substitutions are applied (for example, "@" to "a", "$" to "s", "1" to "l", "0" to "o"). This maps a small set of banned base terms to a much larger set of potentially weak passwords.
1. **Fuzzy matching**—the normalized password is compared against banned passwords using an edit distance of one. This means passwords that differ from a banned term by a single character substitution, insertion, or deletion are detected and rejected.
1. **Substring matching**—the system checks the normalized password for the user's first and last name and the tenant name, preventing the inclusion of easily guessable personal or organizational identifiers. Substring matching is only enforced for terms that are at least four characters long.
1. **Score calculation**—the system assigns one point for each banned password found in the normalized password and one point for each remaining character. A password must score at least five points to be accepted. This scoring approach means that longer, more complex passwords can be accepted even if they contain a banned term, as long as the overall password is sufficiently strong.

### Protecting against password spray

Password spray attacks are one of the most common techniques used by attackers. Rather than targeting a single account with many password attempts, the attacker submits a few of the most commonly used weak passwords against many accounts. This approach avoids triggering account lockout thresholds while rapidly searching for compromised accounts. As these attacks become more sophisticated—with AI enabling attackers to generate and test password variations at scale—strong password protection becomes increasingly important.

Microsoft Entra password protection efficiently blocks all known weak passwords likely to be used in password spray attacks. The global banned password list is built from real-world security telemetry on actual password spray attacks, ensuring it targets the passwords attackers are most likely to use.

### On-premises integration

For organizations with hybrid identity models that include on-premises Active Directory Domain Services (AD DS), Microsoft Entra password protection can be extended to the on-premises environment. Two components are installed on on-premises servers:

- **Proxy service**—runs on a domain-joined machine and forwards password policy download requests from domain controllers to Microsoft Entra ID.
- **DC Agent**—installed on domain controllers to receive password validation requests and process them using the current password policy downloaded from Microsoft Entra ID.

The on-premises deployment uses the same global and custom banned password lists stored in Microsoft Entra ID and performs the same validation checks for on-premises password changes. Domain controllers never need to communicate directly with the internet—all communication goes through the proxy service. No AD DS schema changes are required, and any supported domain or forest functional level can be used.

The DC Agent service requests a new policy at startup and checks the age of the locally cached policy hourly. If the policy is older than one hour, a new policy is downloaded through the proxy service. Microsoft Entra password protection acts as a supplement to existing AD DS password policies, not a replacement—all password validation components must agree before a password is accepted.
