When it comes to identity and access, most organizations that are considering using the public cloud are concerned about two things:

 -  Ensuring that when people leave the organization, they lose access to resources in the cloud.
 -  Striking the right balance between autonomy and central governance—for example, giving project teams the ability to create and manage virtual machines in the cloud while centrally controlling the networks to which those virtual machines connect.

RBAC is an authorization system built on Azure Resource Manager that provides fine-grained access management of Azure resources. Azure AD and Role Based Access Control (RBAC) make it simple for you to carry out these goals. After you extend your on-premises Active Directory to the cloud by using Azure AD Connect, your employees can use and manage their Azure subscriptions by using their existing work identities. These Azure subscriptions automatically connect to Azure AD for SSO and access management. When you disable an on-premises Active Directory account, it automatically loses access to all Azure subscriptions connected with Azure AD.

Additionally, synchronizing passwords to the cloud to support these checks also add resiliency during some attacks. Customers affected by (Not)Petya attacks were able to continue business operations when password hashes were synced to Azure AD (vs. near zero communications and IT services for customers affected organizations that had not synchronized passwords).

RBAC enables fine-grained access management for Azure. Using RBAC, you can grant just the amount of access that users need to perform their jobs. For example, you can use RBAC to let one employee manage virtual machines in a subscription while another manages SQL databases within the same subscription.

**Each Azure subscription is associated with one Azure AD directory**. Users, groups, and applications in that directory can manage resources in the Azure subscription. Grant access by assigning the appropriate RBAC role to users, groups, and applications at a certain scope. The scope of a role assignment can be a subscription, a resource group, or a single resource. A role assigned at a parent scope also grants access to the child scopes contained within it. For example, a user with access to a resource group can manage all the resources it contains, like websites, virtual machines, and subnets. The RBAC role that you assign dictates what resources the user, group, or application can manage within that scope.

The following diagram depicts how the classic subscription administrator roles, RBAC roles, and Azure AD administrator roles are related at a high level. Roles assigned at a higher scope, like a subscription, are inherited by child scopes, like service instances.

:::image type="content" source="../media/az500-role-based-access-control-08483ded.png" alt-text="Classic subscription administrator roles, RBAC roles, and Azure AD administrator roles are related at a high level.":::


> [!IMPORTANT]
> Note that a subscription is associated with only one Azure AD tenant. Also note that a resource group can have multiple resources but is associated with only one subscription. Lastly, a resource can be bound to only one resource group.

For more information: [Azure Resource Manager](/azure/azure-resource-manager/management/overview)
