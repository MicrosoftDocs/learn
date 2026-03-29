## Prepare environment

Create a resource group and test resource as a safe sandbox for practicing access control. This isolated scope lets you configure RBAC roles without affecting production resources.

1.  Sign in with an account that can manage users and role assignments.
2.  Create a resource group named rg-gp-access-model.
3.  Create a small test resource (for example, a storage account) inside the resource group.
4.  Open two browser tabs: one for Entra ID and one for Resource Group IAM.

> [!WARNING]
> You're creating billable Azure resources. Use a test subscription and complete the clean-up unit when you're done.

> [!TIP]
> If the portal blade names differ slightly, use the top search bar in the Azure portal.

> [!NOTE]
> Screenshot opportunity: Resource group and test resource created for access scope.

