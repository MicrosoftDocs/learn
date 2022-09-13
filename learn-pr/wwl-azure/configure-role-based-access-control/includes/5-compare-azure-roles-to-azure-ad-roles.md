When you are new to Azure, you may find it a little challenging to understand all the different roles in Azure. This article helps explain the following roles and when you would use each:

- Classic subscription administrator roles
- Azure role-based access control (RBAC) roles
- Azure Active Directory (Azure AD) administrator roles

To better understand roles in Azure, it helps to know some of the history. When Azure was initially released, access to resources was managed with just three administrator roles: Account Administrator, Service Administrator, and Co-Administrator. Later, role-based access control (RBAC) for Azure resources was added. Azure RBAC is a newer authorization system that provides fine-grained access management to Azure resources. RBAC includes many built-in roles, can be assigned at different scopes, and allows you to create your own custom roles. To manage resources in Azure AD, such as users, groups, and domains, there are several Azure AD administrator roles.

## Differences between Azure roles and Azure Active Directory roles

At a high level, Azure RBAC roles control permissions to manage Azure resources, while Azure AD administrator roles control permissions to manage Azure Active Directory resources. The following table compares some of the differences.

| <!-- Blank --> | Azure RBAC roles | Azure AD roles |
| --- | --- | --- |
| **Access** | Manages access to Azure resources | Manages access to Azure AD resources |
| **Scope**  | Scope specified at multiple levels, including management groups, subscriptions, resource groups, and resources | Scope specified at the tenant level |
| **Roles** | Roles accessed via the Azure portal, the Azure CLI, Azure PowerShell, Azure Resource Manager templates, and the REST API | Roles accessed via the Azure admin portal, Microsoft 365 admin portal, and Microsoft Graph Azure AD PowerShell |

> [!NOTE]
> Azure Resource Manager roles should be used instead of Classic administrator roles.