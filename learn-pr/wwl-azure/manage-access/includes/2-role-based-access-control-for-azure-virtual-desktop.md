Azure Virtual Desktop uses Azure role-based access controls (RBAC) to assign roles to users and admins. These roles give admins permission to carry out certain tasks.

The standard built-in roles for Azure are:

 -  **Owner**
 -  **Contributor**
 -  **Reader**

However, Azure Virtual Desktop has additional roles that let you separate management roles for host pools, app groups, and workspaces.

These roles are named in compliance with Azure's standard roles and least-privilege methodology.

Azure Virtual Desktop doesn't have a specific Owner role. However, you can use a standard Owner role for the service objects.

Below are the Azure Virtual Desktop roles:

 -  **Desktop Virtualization Contributor role:** Lets you manage all aspects of the deployment. However, it doesn't grant you access to compute resources. You'll also need the User Access Administrator role to publish app groups to users or user groups.
 -  **Desktop Virtualization Reader role:** Lets you view everything in the deployment but doesn't let you make any changes.
 -  **The Host Pool Contributor role:** Allows you to manage all aspects of host pools, including access to resources. You'll need an extra contributor role, Virtual Machine Contributor, to create virtual machines. You will need AppGroup and Workspace contributor roles to create host pool using the portal or you can use Desktop Virtualization Contributor role.
 -  **Host Pool Reader role:** Allows you to view everything in the host pool, but won't allow you to make any changes.
 -  **Application Group Contributor role:** Lets you manage all aspects of app groups. If you want to publish app groups to users or user groups, you'll need the User Access Administrator role.
 -  **Application Group Reader role:** Allows you to view everything in the app group and will not allow you to make any changes.
 -  **Workspace Contributor role:** Allows you to manage all aspects of workspaces. To get information on applications added to the app groups, you'll also need to be assigned the Application Group Reader role.
 -  **Workspace Reader role:** Lets you view everything in the workspace, but won't allow you to make any changes.
 -  **User Session Operator role:** Allows you to send messages, disconnect sessions, and use the "logoff" function to sign sessions out of the session host. However, this role doesn't let you perform session host management like removing session host, changing drain mode, and so on. This role can see assignments but can't modify admins. We recommend you assign this role to specific host pools. If you give this permission at a resource group level, the admin will have read permission on all host pools under a resource group.
 -  **Session Host Contributor role:** Allows you to view and remove session hosts, and change drain mode. They can't add session hosts using the Azure portal because they don't have write permission for host pool objects. If the registration token is valid (generated and not expired), you can use this role to add session hosts to the host pool outside of Azure portal if the admin has compute permissions through the Virtual Machine Contributor role.
