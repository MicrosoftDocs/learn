Access to eDiscovery tools in Microsoft Purview isn't granted by default. Because eDiscovery involves access to sensitive content, permissions must be explicitly granted to ensure that only authorized individuals can create cases, run searches, place holds, and export data.

## Who typically uses eDiscovery?

eDiscovery is often used by legal teams, compliance officers, and security personnel. Depending on how responsibilities are structured in your organization, tasks might be split across different roles:

- **eDiscovery Admins** configure the overall setup, assign permissions, and manage global settings.
- **eDiscovery Managers** create and manage cases, run searches, and review content.

Other teams, such as HR or external counsel, might be added to specific cases with limited access based on the scope of the investigation.

## How are permissions assigned?

Access to eDiscovery features is controlled through **role-based access control (RBAC)** in the Microsoft Purview portal. To perform tasks in eDiscovery, users need to be added to a built-in role group such as **eDiscovery Manager** or **Administrator**, or a custom role group with the right permissions.

Permissions are scoped by case. Even if someone has access to the eDiscovery tools, they can't see a specific case unless they're added to it.

This approach helps organizations ensure that investigations are handled securely, with access limited to only users who need it.
