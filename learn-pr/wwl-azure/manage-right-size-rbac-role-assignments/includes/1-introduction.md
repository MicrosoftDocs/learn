A compromised account with Owner permissions at subscription scope gives an attacker complete control over every resource in that subscription. They can delete production workloads, assign roles to create persistent backdoor access, and move laterally to every service. At Contoso, the preaudit gap assessment revealed 37 identities with Owner-level access at subscription scope—12 of which were used in 90 days. Three custom roles had overly broad permissions because they were created by copying Contributor and removing only a few actions. What started as "making it easier to get things done" created a critical security exposure.

Role-based access control (RBAC) is designed to enforce least privilege. It only works when you assign roles with the right scope, use built-in roles correctly, and regularly evaluate the need. Over-assignment is common, and it creates unnecessary risk. Every excessive permission is a potential path for attackers to exploit.

In this module, you learn how to assign built-in RBAC roles at the correct scope, create custom roles that grant only necessary permissions. Then you evaluate your existing role assignments to identify and remove overprivileged access. You start by understanding how to choose and assign built-in roles correctly.

## Learning objectives

By the end of this module, you're able to:

- Assign built-in Azure roles at the appropriate scope using least-privilege principles.
- Create custom Azure roles and Microsoft Entra roles for operations that built-in roles don't cover at the right permission level.
- Identify overprivileged role assignments using Defender for Cloud CSPM identity insights and CIEM.
- Remediate excessive access using Microsoft Entra ID access reviews and targeted role assignment changes.
