Identity and Access Management (IAM) is the framework of permissions, processes, and systems that ensure security principals have correct access to organizational resources. IAM involves managing user identities and controlling their access to systems and data based on predefined roles and permissions. 

In your global clothing retailer, your merger with a competitor has given you systems implemented on both Azure and AWS. You're planning to migrate some of your AWS resources to Azure but, before you do, you need to understand how users are authenticated and authorized to access resources, so that the migration doesn't result in accidental data breaches.

In this unit, you'll see how identity and access are managed in Azure and compare that with the methods you may be familiar with from your AWS experience.

:::image type="content" source="../media/iam-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Amazon AWS.":::

## Identity and Access Management (IAM)

IAM includes user authentication, authorization, and account provisioning. Use IAM to ensure security principals can perform actions and access only the information necessary for their roles. By implementing IAM, organizations can enhance security, streamline compliance with regulations, and improve operational efficiency.

AWS and Azure both provide mechanisms to control access to resources, and both encourage the principle of least privilege. However, there are differences in how the two platforms implement identity and access. AWS offers a user-centric approach to security. Azure's is a role-based model.

Before getting into the details of access control, let's first compare the terminology used by each platform:

| Azure  | AWS  | Comments  |
|---------|---------|---------|
| [Azure subscription](/azure/cost-management-billing/manage/create-subscription)| AWS Account | An Azure subscription is a billing and quota boundary. The size and complexity of your organization will determine the quantity of subscriptions. |
| [Microsoft Entra ID](/entra/fundamentals/whatis) | AWS IAM Identity Center | Entra ID manages your directory of users, groups, and other security principals. |
| [Resource groups](/azure/azure-resource-manager/management/manage-resource-groups-portal) | No AWS equivalent | Azure resources are created within a resource group. You can manage all the resources in a resources group as a single unit. |
| [Azure management groups](/azure/governance/management-groups/overview) | AWS Organization Units | Azure has no equivalent to the "master" or "management account" that is used as the parent in AWS Organizations. |
| [Azure subscription administrator](/azure/cost-management-billing/manage/add-change-subscription-administrator) | AWS account root user | These accounts have full control over the Azure subscription or AWS account. |
| [Microsoft Entra user](/entra/fundamentals/how-to-create-delete-users) | AWS IAM User | Each IAM User is associated with only one AWS Account. In Azure, a user can be assigned access to multiple subscriptions by their subscription administrators. |
| Similar to the combination of RBAC [role definition](/azure/role-based-access-control/role-definitions) and [role assignment](/azure/role-based-access-control/overview#role-assignments) | AWS IAM Policy | These objects are used to determine the actions a security principal can perform in Azure or AWS. |

## IAM in AWS

In AWS, IAM is user-centric and implemented with policies. Each policy can be applied to users, groups, or roles.

User idenities are stored in a single AWS account and can't be used to access other accounts. You have fine-grained control over the resources each user can access.

## IAM in Azure

In Azure, IAM is role-centric and implemented with these tools:

### Microsoft Entra ID

Microsoft Entra ID is a cloud-based identity and access management service. It's designed as a central store for identities including users, groups, and service principals. Microsoft Entra ID is similar to AWS AIM Identity Center.

AWS is user-centric. Each AWS account has a separate IAM store, and each IAM user is associated with only one AWS account. Users created in Microsoft Entra ID, by contrast, can be granted access to more than one Azure subscription.

### Role-Based Access Control (RBAC)

Azure RBAC is built on Azure Resource Manager to provide access management for resources in Azure. RBAC is an authorization system that grants access by assigning roles to security principals. A security principal may be a user, group, or application. RBAC roles are assigned at different scopes as discussed in the following section.

By contrast, AWS IAM creates AWS users and groups with permissions that grant or deny access to AWS resources using policies. Policies are JSON files that can be assigned to users, groups, or roles.

For more information about RBAC, see [Secure your Azure resources with Azure role-based access control (Azure RBAC)](/training/modules/secure-azure-resources-with-rbac/)

### Hierarchical scope

In Azure, you can assign permissions at different scopes, so that it's easier to manage large environments. The scope levels include:

- Management group
- Subscription
- Resource group
- Resource

For organizations that have many Azure subscriptions, management groups make it easier to manage access, policies, and compliance for more than one subscription. The governance conditions that you apply cascade by inheritance to all associated subscriptions. For more information, see [What are Azure Management Groups?](/azure/governance/management-groups/overview).

## Learn more

- [Secure your Azure resources with Azure role-based access control (Azure RBAC)](/training/modules/secure-azure-resources-with-rbac/)
- [What are Azure management groups?](/azure/governance/management-groups/overview)
