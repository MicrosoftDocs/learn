You'll need an Azure Automation account to run the PowerShell runbook. The process this section describes is useful even if you have an existing Azure Automation account that you want to use to set up the PowerShell runbook.

Here's how to set it up:

1.  Open Windows PowerShell.
2.  Run the following cmdlet to sign in to your Azure account.

```
Login-AzAccount

```

> [!NOTE]
> Your account must have contributor rights on the Azure subscription where you want to deploy the scaling tool.

3.  Run the following cmdlet to download the script for creating the Azure Automation account:

```
New-Item -ItemType Directory -Path "C:\Temp" -Force
Set-Location -Path "C:\Temp"
$Uri = "https://raw.githubusercontent.com/Azure/RDS-Templates/master/wvd-templates/wvd-scaling-script/CreateOrUpdateAzAutoAccount.ps1"
# Download the script
Invoke-WebRequest -Uri $Uri -OutFile ".\CreateOrUpdateAzAutoAccount.ps1"

```

4.  Run the following cmdlet to execute the script and create the Azure Automation account. You can either fill in values for the parameters or comment them to use their defaults.

```
$Params = @{
    "AADTenantId"          = "<Azure_Active_Directory_tenant_ID>"  # Optional. If not specified, it will use the current Azure context.    "SubscriptionId"        = "<Azure_subscription_ID>"              # Optional. If not specified, it will use the current Azure context.
    "UseARMAPI"            = $true
    "ResourceGroupName"    = "<Resource_group_name>"                # Optional. Default: "AVDAutoScaleResourceGroup"
    "AutomationAccountName" = "<Automation_account_name>"            # Optional. Default: "AVDAutoScaleAutomationAccount"
    "Location"              = "<Azure_region_for_deployment>"
    "WorkspaceName"        = "<Log_analytics_workspace_name>"      # Optional. If specified, Log Analytics will be used to configure the custom log table that the runbook PowerShell script can send logs to.
}

.\CreateOrUpdateAzAutoAccount.ps1 @Params

```

5.  The cmdlet's output will include a webhook URI. Make sure to keep a record of the URI because you'll use it as a parameter when you set up the execution schedule for the Azure Logic App.
6.  If you specified the parameter **WorkspaceName** for Log Analytics, the cmdlet's output will also include the Log Analytics Workspace ID and its Primary Key. Make sure to remember URI because you'll need to use it again later as a parameter when you set up the execution schedule for the Azure Logic App.
7.  After you've set up your Azure Automation account, sign in to your Azure subscription and check to make sure your Azure Automation account and the relevant runbook have appeared in your specified resource group, as shown in the following image:

:::image type="content" source="../media/scale-session-hosts-azure-automation-image-1-35ba6e72.png" alt-text="An image of the Azure overview page showing the newly created Azure Automation account and runbook.":::


To check if your webhook is where it should be, select the name of your runbook. Next, go to your runbook's Resources section and select Webhooks.
