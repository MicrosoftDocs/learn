Azure Virtual Desktop uses Azure role-based access control (RBAC) to control access to resources. There are many built-in roles for use with Azure Virtual Desktop that are a collection of permissions. You assign roles to users and admins and these roles give permission to carry out certain tasks.

The standard built-in roles for Azure are *Owner*, *Contributor*, and *Reader*. However, Azure Virtual Desktop has more roles that let you separate management roles for host pools, application groups, and workspaces. This separation lets you have more granular control over administrative tasks. These roles are named in compliance with Azure's standard roles and least-privilege methodology. Azure Virtual Desktop doesn't have a specific Owner role, but you can use the general Owner role for the service objects.

The built-in roles for Azure Virtual Desktop and the permissions for each one are detailed in this article. You can assign each role to the scope you need. Some Azure Desktop features have specific requirements for the assigned scope, which you can find in the documentation for the relevant feature. For more information, see [Understand Azure role definitions](/azure/role-based-access-control/role-definitions) and [Understand scope for Azure RBAC](/azure/role-based-access-control/scope-overview).

## Desktop Virtualization Contributor

The Desktop Virtualization Contributor role allows managing all your Azure Virtual Desktop resources. You also need the *User Access Administrator* role to assign application groups to user accounts or user groups. This role doesn't grant users access to compute resources.

## Desktop Virtualization User

The Desktop Virtualization User role allows users to use an application on a session host from an application group as a non-administrative user

## Desktop Virtualization Host Pool Contributor

The Desktop Virtualization Host Pool Contributor role allows managing all aspects of a host pool. You also need the *Virtual Machine Contributor* role to create virtual machines and the *Desktop Virtualization Application Group Contributor* and *Desktop Virtualization Workspace Contributor* roles to deploy Azure Virtual Desktop using the portal, or you can use the *Desktop Virtualization Contributor* role.

## Desktop Virtualization Application Group Contributor

The Desktop Virtualization Application Group Contributor role allows managing all aspects of an application group. If you want to assign user accounts or user groups to application groups too, you also need the *User Access Administrator* role.

## Desktop Virtualization Workspace Contributor

The Desktop Virtualization Workspace Contributor role allows managing all aspects of workspaces. To get information on applications added to a related application group, you also need the *Desktop Virtualization Application Group Reader* role.

## Desktop Virtualization User Session Operator

The Desktop Virtualization User Session Operator role allows sending messages, disconnecting sessions, and using the *logoff* function to sign users out of a session host. However, this role doesn't allow host pool or session host management like removing a session host, changing drain mode, and so on. This role can see assignments, but can't modify members. We recommend you assign this role to specific host pools. If you assign this role at a resource group level, it provides read permission on all host pools under a resource group.

## Desktop Virtualization Session Host Operator

The Desktop Virtualization Session Host Operator role allows viewing and removing session hosts, and changing drain mode. This role can't add session hosts using the Azure portal because it doesn't have write permission for host pool objects. For adding session hosts outside of the Azure portal, if the registration token is valid (generated and not expired), this role can add session hosts to the host pool if the *Virtual Machine Contributor* role is also assigned.

## Desktop Virtualization Power On Contributor

The Desktop Virtualization Power On Contributor role is used to allow the Azure Virtual Desktop Resource Provider to start virtual machines.

## Desktop Virtualization Power On Off Contributor

The Desktop Virtualization Power On Off Contributor role is used to allow the Azure Virtual Desktop Resource Provider to start and stop virtual machines.

## Desktop Virtualization Virtual Machine Contributor

The Desktop Virtualization Virtual Machine Contributor role is used to allow the Azure Virtual Desktop Resource Provider to create, delete, update, start, and stop virtual machines.
