Using role-based access control (RBAC), you can create roles and groups within your security operations team to grant appropriate access to the portal. Based on the roles and groups you create, you have precise control over what users with access to the portal can see and do.  The following video explains the use of Role-Based Access Control (RBAC) and Device Groups (Machine Groups).

> [!IMPORTANT]
> Starting February 16, 2025, new Microsoft Defender for Endpoint customers will only have access to the Unified Role-Based Access Control (URBAC).
> Existing customers keep their current roles and permissions. For more information, see URBAC [Unified Role-Based Access Control (URBAC) for Microsoft Defender for Endpoint](/defender-xdr/manage-rbac)

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c9903800-3d26-4b30-bd0b-fed00dfc6a5c]

Defender for Endpoint RBAC is designed to support your tier or role-based model of choice. It gives you granular control over what roles can see, devices they can access, and actions they can take. The RBAC framework is centered around the following controls:

- Control who can take specific actions

  - Create custom roles and control what Defender for Endpoint capabilities they can access with granularity.

- Control who can see information on a specific device group or groups

  - Create device groups by specific criteria such as names, tags, domains, and others, then grant role access to them using a specific Microsoft Entra user group.

To implement role-based access, you need to define admin roles, assign corresponding permissions, and assign Microsoft Entra user groups assigned to the roles.

Before using RBAC, you should understand the roles that can grant permissions and the consequences of turning on RBAC. On your first sign-in to Microsoft Defender XDR you're granted either full access or read-only access. Full access rights are granted to users with Security Administrator or Global Administrator roles in Microsoft Entra ID. Read-only access is granted to users with a Security Reader role in Microsoft Entra ID. Someone with a Defender for Endpoint Global administrator role has unrestricted access to all devices, regardless of their device group association and the Microsoft Entra user groups assignments

> [!IMPORTANT]
> Microsoft recommends that you use roles with the fewest permissions. This helps improve security for your organization. Global Administrator is a highly privileged role that should be limited to emergency scenarios when you can't use an existing role.
