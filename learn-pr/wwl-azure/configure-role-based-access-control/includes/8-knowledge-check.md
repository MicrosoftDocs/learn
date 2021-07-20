Choose the best response for each question. Then select Check your answer.

## Multiple Choice
There are three virtual machines (VM1, VM2, and VM3) in a resource group. The Helpdesk hires a new employee. The new employee must be able to modify the settings on VM3, but not on VM1 and VM2. Which of following meets the requirements and minimizes administrative overhead?
( ) Assign the user to the Contributor role on the resource group. {{That's incorrect. This will give the new employee the ability to modify all of the virtual machines in the resource group.}}
(x) Assign the user to the Contributor role on VM3. {{That's correct. The Contributor role will allow the user to change the settings on VM1. }}
( ) Move VM3 to a new resource group and assign the user to the Owner role on VM3. {{That's incorrect. The Owner role will give more permissions that what is needed. }}

## Multiple Choice
What's the main difference between Azure roles and Azure Active Directory roles?
(x) Azure roles apply to Azure resources. Azure AD roles apply to Azure AD resources such as users, groups, and domains. {{That's correct. Azure roles are used to manage access to virtual machines, storage, and other Azure resources. Azure AD roles are used to manage access to Azure AD resources such as user accounts and passwords. }}
( ) Azure roles can be assigned at the root level. {{That's incorrect. Azure roles can only be assigned at the management groups, subscriptions, resource groups, or resources scope. }}
( ) Azure AD roles are used to manage access to Azure resources. {{That's incorrect. Azure roles are used to view and manage Azure resources. Azure roles are used to manage access to virtual machines, storage, and other Azure resources. Azure AD roles are used to manage access to Azure AD resources such as user accounts and passwords. }}

## Multiple Choice
What is included in a custom Azure role definition?
(x) Operations allowed for Azure resources and the scope of permissions {{ That's correct. A custom role definition includes the operations allowed such as read, write, and delete for Azure resources and the scope of those permissions. }}
( ) The assignment of a custom role {{ That's incorrect. Role assignment isn't part of the custom role assignment. }}
( ) Actions and DataActions operations scoped to the tenant level {{ That's incorrect. The scopes that can apply to an Azure resource are subscription, resource group, and individual resource. Azure AD roles are at the tenant scope. }}
