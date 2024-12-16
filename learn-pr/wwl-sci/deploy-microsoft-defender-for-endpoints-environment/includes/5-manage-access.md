Using role-based access control (RBAC), you can create roles and groups within your security operations team to grant appropriate access to the portal. Based on the roles and groups you create, you have fine-grained control over what users with access to the portal can see and do.  The following video explains the use of Role-Based Access Control (RBAC) and Device Groups (Machine Groups).


>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4bJ2a?rel=0]

Defender for Endpoint RBAC is designed to support your tier or role-based model of choice. It gives you granular control over what roles can see, devices they can access, and actions they can take. The RBAC framework is centered around the following controls:

- Control who can take specific actions

  - Create custom roles and control what Defender for Endpoint capabilities they can access with granularity.

- Control who can see information on a specific device group or groups

  - Create device groups by specific criteria such as names, tags, domains, and others, then grant role access to them using a specific Microsoft Entra user group.

To implement role-based access, you'll need to define admin roles, assign corresponding permissions, and assign Microsoft Entra user groups assigned to the roles.

Before using RBAC, you should understand the roles that can grant permissions and the consequences of turning on RBAC. On your first sign-in to Microsoft Defender XDR you're granted either full access or read-only access. Full access rights are granted to users with Security Administrator or Global Administrator roles in Microsoft Entra ID. Read-only access is granted to users with a Security Reader role in Microsoft Entra ID. Someone with a Defender for Endpoint Global administrator role has unrestricted access to all devices, regardless of their device group association and the Microsoft Entra user groups assignments
