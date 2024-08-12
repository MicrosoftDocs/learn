Microsoft Entra ID provides several ways to manage access to resources, applications, and tasks. With Microsoft Entra groups, you can grant access and permissions to a group of users instead of for each individual user. Limiting access to Microsoft Entra resources to only those users who need access is one of the core security principles of [Zero Trust](/security/zero-trust/zero-trust-overview).

This article provides an overview of how groups and access rights can be used together to make managing your Microsoft Entra users easier while also applying security best practices.

Microsoft Entra ID lets you use groups to manage access to applications, data, and resources. Resources can be:

 -  Part of the Microsoft Entra organization, such as permissions to manage objects through roles in Microsoft Entra ID
 -  External to the organization, such as for Software as a Service (SaaS) apps
 -  Azure services
 -  SharePoint sites
 -  On-premises resources

Some groups can't be managed in the Azure portal:

 -  Groups synced from on-premises Active Directory can be managed only in on-premises Active Directory.
 -  Distribution lists and mail-enabled security groups are managed only in Exchange admin center or Microsoft 365 admin center. You must sign in to Exchange admin center or Microsoft 365 admin center to manage these groups.

## What to know before creating a group

There are two group types and three group membership types. Review the options to find the right combination for your scenario.

### Group types:<br>

Security: Used to manage user and computer access to shared resources.

For example, you can create a security group so that all group members have the same set of security permissions. Members of a security group can include users, devices, service principals, and other groups (also known as nested groups), which define access policy and permissions. Owners of a security group can include users and service principals.

> [!NOTE]
> When nesting an existing security group to another security group, only members in the parent group will have access to shared resouces and applications. Nested group members don't have the same assigned membership as the parent group members.

Microsoft 365: Provides collaboration opportunities by giving group members access to a shared mailbox, calendar, files, SharePoint sites, and more.

This option also lets you give people outside of your organization access to the group. Members of a Microsoft 365 group can only include users. Owners of a Microsoft 365 group can include users and service principals.

## Membership types:

Assigned: Lets you add specific users as members of a group and have unique permissions.

Dynamic user: Lets you use dynamic membership rules to automatically add and remove members. If a member's attributes change, the system looks at your dynamic group rules for the directory to see if the member meets the rule requirements (is added), or no longer meets the rules requirements (is removed).

Dynamic device: Lets you use dynamic group rules to automatically add and remove devices. If a device's attributes change, the system looks at your dynamic group rules for the directory to see if the device meets the rule requirements (is added), or no longer meets the rules requirements (is removed).

## What to know before adding access rights to a group

After creating a Microsoft Entra group, you need to grant it the appropriate access. Each application, resource, and service that requires access permissions needs to be managed separately because the permissions for one may not be the same as another. Grant access using the principle of least privilege to help reduce the risk of attack or a security breach.

## How access management in Microsoft Entra ID works

Microsoft Entra ID helps you give access to your organization's resources by providing access rights to a single user or to an entire Microsoft Entra group. Using groups lets the resource owner or Microsoft Entra directory owner assign a set of access permissions to all the members of the group. The resource or directory owner can also give management rights to someone such as a department manager or a help desk administrator, letting that person add and remove members.

:::image type="content" source="../media/microsoft-entra-identity-access-management-4ca9b9bc.png" alt-text="Diagram showing how access management in Microsoft Entra ID works.":::


## Ways to assign access rights

After creating a group, you need to decide how to assign access rights. Explore the ways to assign access rights to determine the best process for your scenario.

 -  Direct assignment. The resource owner directly assigns the user to the resource.<br>
 -  Group assignment. The resource owner assigns a Microsoft Entra group to the resource, which automatically gives all of the group members access to the resource. Group membership is managed by both the group owner and the resource owner, letting either owner add or remove members from the group.<br>
 -  Rule-based assignment. The resource owner creates a group and uses a rule to define which users are assigned to a specific resource. The rule is based on attributes that are assigned to individual users. The resource owner manages the rule, determining which attributes and values are required to allow access the resource.<br>
 -  External authority assignment. Access comes from an external source, such as an on-premises directory or a SaaS app. In this situation, the resource owner assigns a group to provide access to the resource and then the external source manages the group members.<br>

:::image type="content" source="../media/access-management-process-591704e6.png" alt-text="Diagram showing ways to assign access rights.":::


## Can users join groups without being assigned?

The group owner can let users find their own groups to join, instead of assigning them. The owner can also set up the group to automatically accept all users that join or to require approval.

After a user requests to join a group, the request is forwarded to the group owner. If it's required, the owner can approve the request and the user is notified of the group membership. If you have multiple owners and one of them disapproves, the user is notified, but isn't added to the group.
