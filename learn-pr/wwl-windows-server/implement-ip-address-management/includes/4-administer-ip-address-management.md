Configuring administration for IPAM can be a complex task depending on how your IPAM infrastructure is deployed and who is managing the infrastructure. For example, Contoso can choose to allow an administrator to manage all aspects within IPAM, or they could  limit management ability. If they want to assign specific administrative tasks to administrators, they can limit tasks based on IPAM functional areas or specific servers.

## RBAC

To define and establish fine-grained control for users and groups, you can use RBAC to customize:

- Roles.
- Access scopes.
- Access policies.

This enables users and groups to perform a specific set of administrative operations on specific objects that IPAM manages.

Implement role-based management in IPAM by using the components in the following table.

|Component|Description |
|---------------|------------------------------------------------------------|
|Role|A *role* is a collection of IPAM operations. You can associate a role with a user or group in Windows by using an access policy. Nine built-in administrator roles are available for convenience, but you can also create custom roles to meet your business requirements. You can create and edit roles from the **Access Control** tab in the **IPAM** node in Server Manager.|
|Access scope|An *access scope* determines the objects to which a user has access. You can use access scopes to define administrative domains in IPAM. For example, you might create access scopes based on a user's geographical location. By default, IPAM includes an access scope named **Global**. All other access scopes are subsets of the **Global** access scope. Users or groups that you assign to the **Global** access scope have access to all objects in IPAM that their assigned role permits. You can create and edit access scopes from the **Access Control** node in the **IPAM management** console.|
|Access policy|An *access policy* combines a role with an access scope to assign permissions to a user or group. For example, you might define an access policy for a user by combining a role named **IP Block Admin** with an access scope named **Global\Asia**. The user would have permission to edit and delete IP address blocks that are associated with the **Asia** access scope, but wouldn't have permission to edit or delete any other IP address blocks in IPAM. You can create and edit access policies from the **Access Control** node in the **IPAM management** console.|

## IPAM security groups

IPAM has several built-in role-based security groups that you can use for managing your IPAM infrastructure, as described in the following table.

|Group name|Description|
|-------|------|
|IPAM Administrators|Members of this group have privileges to access all IPAM data and to perform all IPAM tasks.|
|IPAM MSM Administrators|Members of this group can manage DHCP servers, scopes, policies, and DNS servers and associated zones and records.|
|IPAM DNS Administrators|Members of this group can manage DNS servers and their associated DNS zones and resource records.|
|DNS Record Administrators|Members of this group can manage DNS resource records.|
|IPAM ASM Administrators|Members of this group can perform IP address space tasks, in addition to common IPAM management tasks.|
|IP Address Record Administrators|Members of this group can manage IP addresses, including unallocated addresses. Members can create and delete IP address instances.|
|IPAM DHCP Administrators|Members of this group can manage DHCP servers and their scopes.|
|IPAM DHCP Scope Administrators|Members of this group can manage DHCP scopes.|
|IPAM DHCP Reservations Administrators|Members of this group can manage DHCP reservations.|
