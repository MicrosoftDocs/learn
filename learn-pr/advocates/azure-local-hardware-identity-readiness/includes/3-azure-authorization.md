Azure authorization determines which actions a principal can perform against Azure resources. It's separate from logging on to a physical node, using an AD DS account, or administering a guest operating system.

## Identify the Azure resource boundary

A Microsoft Entra *tenant* is the directory boundary for Azure identities. A *subscription* is an Azure resource, billing, and policy boundary associated with a tenant. A *resource group* contains related resources within a subscription.

Azure Local uses Azure Arc integration to represent and manage on-premises resources in Azure. An Arc-enabled server resource represents an individual machine. The Azure Local system resource represents the deployed instance. *Azure Arc resource bridge* is an on-premises infrastructure appliance that enables relevant Azure management operations against local resources. Registering a machine with Arc is a prerequisite activity, not proof that the complete Azure Local deployment is ready.

Choose the tenant, subscription, supported region, and resource group deliberately. Don't assume that the closest Azure region supports every required service.

> [!NOTE]
> Select the Azure subscription carefully before deployment. After you deploy an Azure Local instance, changing its subscription requires redeploying the instance. This subscription restriction is separate from checking which regions support the services you need.

## Apply roles to the right principal and scope

Azure role-based access control (RBAC) combines a **principal**, a **role**, and a **scope**. The principal is the user, group, service principal, or managed identity receiving permission. The role defines allowed actions. The scope identifies where those permissions apply.

Permissions assigned at a parent scope can apply to child resources. Resource-group permission doesn't grant subscription-level authority. A role assignment also doesn't override Azure Policy, deny assignments, resource locks, or unsupported service configurations.

A *managed identity* is an identity assigned to an Azure resource so that software can obtain authorized access without a human-maintained application password. A node's Arc managed identity and the engineer's user identity are different principals. Assigning a role to one doesn't grant it to the other.

Use the dedicated registration and deployment permission guidance to separate responsibilities. The following table maps each responsibility to its documented roles and scopes.

| Responsibility | Documented roles for the workflow | Scope and interpretation |
| --- | --- | --- |
| Register resource providers | Owner or Contributor | Subscription; an authorized subscription administrator can complete this separately |
| Onboard machines to Arc | Resource-group Owner, or both Azure Connected Machine Onboarding and Azure Connected Machine Resource Administrator | Machine-registration resource group |
| Deploy the Azure Local instance | Azure Stack HCI Administrator and Reader | Deployment resource group |
| Create and configure the deployment vault and its access | Key Vault Contributor and Key Vault Data Access Administrator | Deployment resource group, as required by the deployment workflow |
| Work with deployment-vault secrets | Key Vault Secrets Officer | Deployment resource group, as specified by the deployment permission matrix |
| Create deployment storage resources | Storage Account Contributor | Deployment resource group |
| Enable local-identity backup access for nodes | Key Vault Secrets Officer and Key Vault Certificates Officer | Relevant vault, assigned to the Arc-machine managed identities |

> [!NOTE]
> Azure Stack HCI has been renamed Azure Local. Some technical names, including the **Azure Stack HCI Administrator** built-in role, retain the former product name. When assigning permissions, use the exact role names shown in the table rather than substituting "Azure Local."

The deployment rows describe a combined permission set, not a menu from which one role is sufficient. The person assigning those roles also needs role-assignment authority at the relevant scope. That preparatory authority isn't a reason to leave every deployment operator permanently privileged at subscription scope.

Understand the distinction between the *control plane* and the *data plane*. Creating a Key Vault resource is a control-plane operation. Reading a secret stored in that vault is a data-plane operation. A principal that can create or view the vault isn't necessarily authorized to read that vault's secrets.

## Check providers, policy, and service limits

A *resource provider* exposes Azure resource types and their management operations. A subscription must register the providers required by the chosen deployment. Registration doesn't assign user permissions, create the target resources, or prove endpoint reachability.

Review policies for allowed locations, permitted resource types, required tags, extension restrictions, and vault or storage network settings. A security policy might correctly block the proposed design. Resolve the design or obtain an approved, scoped policy exception; don't disable the policy across the subscription.

Review resource locks and relevant service quotas or resource limits as well. Available CPU cores in the local machines don't prove that an Azure resource limit has capacity. Conversely, an Azure quota increase doesn't add local workload capacity.

## Inspect the deployment context without changing resources

Use an administrative workstation or Azure Cloud Shell with compatible, already-installed **Az.Accounts** and **Az.Resources** modules. Sign in to the approved tenant first. The caller needs permission to read resource providers and role assignments. At each prompt, supply the approved value from the deployment plan; use the principal's **object ID**, not an application/client ID.

The example changes the current PowerShell context but doesn't register providers, assign roles, create resources, or read vault secrets.

```powershell
$ErrorActionPreference = 'Stop'
$tenantId = Read-Host 'Approved tenant ID'
$subscriptionId = Read-Host 'Approved subscription ID'
$resourceGroup = Read-Host 'Deployment resource group'
$principalId = Read-Host 'Deployment principal object ID'

Set-AzContext -TenantId $tenantId `
    -SubscriptionId $subscriptionId -Scope Process | Out-Null
Get-AzContext |
    Select-Object Account, Tenant, Subscription

$scope = "/subscriptions/$subscriptionId/resourceGroups/$resourceGroup"
$providers = @(
    'Microsoft.HybridCompute',
    'Microsoft.GuestConfiguration',
    'Microsoft.HybridConnectivity',
    'Microsoft.AzureStackHCI',
    'Microsoft.Kubernetes',
    'Microsoft.KubernetesConfiguration',
    'Microsoft.ExtendedLocation',
    'Microsoft.ResourceConnector',
    'Microsoft.HybridContainerService',
    'Microsoft.Attestation',
    'Microsoft.Storage',
    'Microsoft.Insights',
    'Microsoft.KeyVault'
)

foreach ($provider in $providers) {
    Get-AzResourceProvider -ProviderNamespace $provider |
        Select-Object ProviderNamespace, RegistrationState
}

Get-AzRoleAssignment -ObjectId $principalId -Scope $scope |
    Select-Object RoleDefinitionName, Scope

Get-Module -Name Az.Accounts, Az.Resources |
    Select-Object Name, Version
```

Expect required providers to report `Registered`. A missing or incomplete registration needs action from the authorized owner. For example, omitting `Microsoft.Insights` can affect the diagnostic and audit-logging resources used by deployment.

This role inspection isn't a complete effective-access evaluator. Review group membership, eligible-role activation, assignment conditions, inherited grants, deny assignments, and permissions on separately scoped resources. An eligible role that hasn't been activated isn't the same as an active grant.

**Scenario decision:** Contoso's engineer can onboard nodes but can't create the deployment vault. The next action is to identify the failed operation and required role at its documented scope. Adding the engineer to a node's local Administrators group doesn't resolve the Azure denial.
