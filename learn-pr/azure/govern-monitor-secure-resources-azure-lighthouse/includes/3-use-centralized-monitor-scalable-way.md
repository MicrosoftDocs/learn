Relecloud provides managed services for other customers alongside Microsoft’s Lamna Healthcare. At Relecloud, you want to monitor delegated resources across all customer tenants. So now you’ll investigate how you can create Log Analytics workspaces for Azure Monitor logs, and deploy policies that help log data so you can analyze all of the collected data across customer tenants. You’ll also explore how you can query the activity log and enable access to tenant scoped data so you can monitor delegation changes by customers for your tenant.

Azure Lighthouse is changing the way that managed service providers (MSPs) operate their business through its model of centralized multi-tenant management. Azure Lighthouse is a stronger and more secure access mechanism than Azure Active  Directory B2B (Azure AD B2B).
Azure Lighthouse has been beneficial to Relecloud, your company, as it helps you to profitably and efficiently build and deliver managed services for customers like Microsoft’s Lamna Healthcare with a single pane. You can run provide managed services to multiple businesses more securely without having to switch accounts, directories, or subscriptions.

## Use Log Analytics workspaces

You create Log Analytics workspaces in Azure so you can collect data across customer tenants.  These workspaces are separate environments that are used for data collection by Azure Monitor. You can configure data sources with your workspaces, the data will be stored in its assigned workspace.

Microsoft recommends that  you create workspaces directly in customer tenants. This will help ensure that each customer’s data remains in the customer’s tenant. This way,  you can also achieve centralized monitoring for services and resources.

You create Log Analytics workspaces through either the Azure portal, Azure CLI, or Azure PowerShell.
In the Azure portal, you search for "Log Analytics workspaces" and select **Log Analytics workspaces**:

:::image type="content" source="../media/3-log-analytics-workspaces.png" alt-text="Find log analytics workspaces":::

You then select **Add** and fill in the Log Analytics workspace form to create a new workspace:

:::image type="content" source="../media/3-create-workspace.png" alt-text="Create workspace":::

In the Azure portal, you'll view activity logs from workspaces from one pane:

:::image type="content" source="../media/3-view-activity-logs.png" alt-text="View activity logs":::

## Deploy policies to log data

Policies help your company to stay compliant with corporate standards and its service level agreements with customers. After you've created the Log Analytics workspaces, you can deploy policies through Azure Policy to ensure that diagnostic information is always sent to the correct workspace in each tenant.  Azure Policy is a service that you can use to create and manage policies in Azure.  You can take the following steps to create policies:

- Create a policy definition to specify what actions are enforced and under which conditions they're enforced.
- Create an assignment to specify which resources or subscription the policy definition should be enforced on.
You can create policies using tools like the Azure portal, Azure CLI, and PowerShell.

The details of the policies will vary based on the customer and the resource types you're monitoring.

[Video with step-by-steps for creating a policy definition and assignment]
  
Once policies have been created, you view non-compliance  across all resources from a single location:

:::image type="content" source="../media/3-view-policies.png" alt-text="View policies":::

### Analyze logged data

When you  have deployed policies, data collected will be logged to the workspaces you’ve created for each customer. You can analyze the data and get insight across all of your customers’ tenants using tools like Azure Monitor Workbooks:

:::image type="content" source="../media/3-analyzed-logged-data.png" alt-text="Analyze logged data":::

Workbooks can be shared across the organization or with groups outside the organization in the wider community.

## Monitor delegation changes in the managing tenant

You want to always be aware of when customer resources or subscriptions have been delegated to your tenant through Azure Lighthouse’s delegated resource management, or when delegations have been removed.
You can use Azure’s Activity Log to monitor for delegation activity from customers.

### Enable access to tenant scoped data

You must have an account in Azure that is assigned with the *Monitoring Reader* built-in role set at the root-scope of the managing tenant, to access activity log data.  This type of role can be assigned by any administrator user that has the Global Administrator role, but also has elevated access.

If you're the Global Administrator, you can elevate access for yourself by enabling **Access management for Azure resources** in the **Properties** pane of your Azure Active Directory tenant:

:::image type="content" source="../media/3-elevate-access.png" alt-text="Elevate access":::

You can then assign the *Monitoring Reader* role to the account you want to allow to access tenant-level data. It can be done through tools like Azure CLI, or Azure PowerShell. To assign it using Azure PowerShell, you run the following command:

```powershell
# Log in first with Connect-AzAccount if you're not using Cloud Shell
New-AzRoleAssignment -SignInName <yourLoginName> -Scope "/" -RoleDefinitionName "Monitoring Reader" -ApplicationId $servicePrincipal.ApplicationId
```

Microsoft recommends that this is assigned to a service principal account rather than a single user or a group of users. This service principal account should only be used for this particular function and must not be used for any other function.

Elevated access must be removed again after the role has been assigned to the service principal:

:::image type="content" source="../media/3-remove-role-assignment.png" alt-text="Remove access":::

### Query activity logs

After you've created a service principal account that has the *Monitoring Reader* level access, you use it to report and query the Tenant Activity Log for delegation activity.
Tenant activity log data returned contains useful information including the following:

- The ID of a delegated resource group or subscription
- The tenant ID for a customer
- Whether a delegation change was successful or has failed
- The time and date when a change in delegation was logged
you can use Log Analytics, or use tools like Azure PowerShell scripts to query tenant activity logs.

You use an Azure PowerShell script to query the tenant activity log API in your managing tenant, and filter events related to customers who are registering or unregistering a delegation to your tenant.

You write your script like this:

1. Define the time frame (in this case the last day). Get your current Azure context, and a token to make a call to the API:

    ```powershell
    # Azure Lighthouse: Query Tenant Activity Log for registered or unregistered delegations for the last 1 day

    $GetDate = (Get-Date).AddDays((-1))

    $dateFormatForQuery = $GetDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    # Getting Azure context for the API call

    $currentContext = Get-AzContext

    # fetching new token
    $azureRmProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
    $profileClient = [Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient]::new($azureRmProfile)
    $token = $profileClient.AcquireAccessToken($currentContext.Tenant.Id)

    $listOperations = @{
        Uri     = "https://management.azure.com/providers/microsoft.insights/eventtypes/management/values?api-version=2015-04-01&`$filter=eventTimestamp ge '$($dateFormatForQuery)'"
        Headers = @{
            Authorization  = "Bearer $($token.AccessToken)"
            'Content-Type' = 'application/json'
        }
        Method  = 'GET'
    }
    $list = Invoke-RestMethod @listOperations
    ```

1. Aggregate all the tenant activity data

    ```powershell
    # While you get data - continue fetching and add results 
    while($list.nextLink){
        $list2 = Invoke-RestMethod $list.nextLink -Headers $listOperations.Headers -Method Get
        $data+=$list2.value;
        $list.nextLink = $list2.nextlink;
    }

    $showOperations = $data;
    ```

1. Output information on any customer who has delegated resources to the Azure tenant. 

    ```powershell
    if ($showOperations.operationName.value -eq "Microsoft.Resources/tenants/register/action") {
        $registerOutputs = $showOperations | Where-Object -FilterScript { $_.eventName.value -eq "EndRequest" -and $_.resourceType.value -and $_.operationName.value -eq "Microsoft.Resources/tenants/register/action" }
        foreach ($registerOutput in $registerOutputs) {

            $eventDescription = $registerOutput.description | ConvertFrom-Json;

        $registerOutputdata = [pscustomobject]@{
            Event                    = "An Azure customer has registered delegated resources to your Azure tenant";
            DelegatedResourceId      = $eventDescription.delegationResourceId; 
            CustomerTenantId         = $eventDescription.subscriptionTenantId;
            CustomerSubscriptionId   = $eventDescription.subscriptionId;
            CustomerDelegationStatus = $registerOutput.status.value;
            EventTimeStamp           = $registerOutput.eventTimestamp;
            }
            $registerOutputdata | Format-List
        }
    }
    ```

    This helps you see details like the following:

    |Detail  |Description  |
    |---------|---------|
    |DelegatedResourceId|The ID for any resource or subscription that has been delegated|
    |CustomerTenantId|The customer tenant ID|
    |CustomerSubscriptionId|The customer's subscription ID|
    |CustomerDelegationStatus|The new status for the delegation of the resource|
    |EventTimeStamp|When the action took place|

1. Output the same information on any customer who has unregistered delegated resources from your tenant:

    ```powershell
    if ($showOperations.operationName.value -eq "Microsoft.Resources/tenants/unregister/action") {
        $unregisterOutputs = $showOperations | Where-Object -FilterScript { $_.eventName.value -eq "EndRequest" -and $_.resourceType.value -and $_.operationName.value -eq "Microsoft.Resources/tenants/unregister/action" }
        foreach ($unregisterOutput in $unregisterOutputs) {
            $eventDescription = $registerOutput.description | ConvertFrom-Json;
        $unregisterOutputdata = [pscustomobject]@{
            Event                    = "An Azure customer has unregistered delegated resources from your Azure tenant";
            DelegatedResourceId      = $eventDescription.delegationResourceId; 
            CustomerTenantId         = $eventDescription.subscriptionTenantId;
            CustomerSubscriptionId   = $eventDescription.subscriptionId;        
            CustomerDelegationStatus = $unregisterOutput.status.value;
            EventTimeStamp           = $unregisterOutput.eventTimestamp;
            }
            $unregisterOutputdata | Format-List
        }
    }
    else {
        Write-Output "No new delegation events for tenant: $($currentContext.Tenant.TenantId)"  
    ```

## Additional tools

There are various tools in Azure that naturally integrate with Azure Lighthouse, which you’ll want to take advantage of to help you monitor customer tenants:

- Use **Azure Monitor alerts** to help you monitor for alerts across different customers. Your alerts will be accessible from your log analytics workspace. You’ll also help your customers to stay compliant because their log data never actually leaves their subscriptions.
- Use **Azure Automation** to create runbooks that are stored in your own subscriptions, while they perform actions on your customers’ subscriptions. This way, your company’s intellectual property never leaves your tenant, but your customers still benefit from your runbooks.
- Use **Azure Resource Graph Explorer** to query for Azure resources across all customer tenants. In your case, you might want to find out which virtual machines belong to which customer. You can write a straightforward query to fetch a list of these machines, and then export the information to a `.csv` file for further analysis.
