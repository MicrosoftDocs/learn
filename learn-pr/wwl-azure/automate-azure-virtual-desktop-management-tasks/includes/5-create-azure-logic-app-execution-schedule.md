Next, you'll need to create the Azure Logic App and set up an execution schedule for your new scaling tool.

1.  Open Windows PowerShell.
2.  Run the following cmdlet to sign in to your Azure account.

```
Login-AzAccount

```

3.  Run the following cmdlet to download the script for creating the Azure Logic App.

```
New-Item -ItemType Directory -Path "C:\Temp" -Force
Set-Location -Path "C:\Temp"
$Uri = "https://raw.githubusercontent.com/Azure/RDS-Templates/master/wvd-templates/wvd-scaling-script/CreateOrUpdateAzLogicApp.ps1"
# Download the script
Invoke-WebRequest -Uri $Uri -OutFile ".\CreateOrUpdateAzLogicApp.ps1"

```

4.  Run the following PowerShell script to create the Azure Logic App and execution schedule for your host pool:

> [!NOTE]
> You'll need to run this script for each host pool you want to autoscale, but you need only one Azure Automation account.

```
$AADTenantId = (Get-AzContext).Tenant.Id

$AzSubscription = Get-AzSubscription | Out-GridView -OutputMode:Single -Title "Select your Azure Subscription"
Select-AzSubscription -Subscription $AzSubscription.Id

$ResourceGroup = Get-AzResourceGroup | Out-GridView -OutputMode:Single -Title "Select the resource group for the new Azure Logic App"

$AVDHostPool = Get-AzResource -ResourceType "Microsoft.DesktopVirtualization/hostpools" | Out-GridView -OutputMode:Single -Title "Select the host pool you'd like to scale"

$LogAnalyticsWorkspaceId = Read-Host -Prompt "If you want to use Log Analytics, enter the Log Analytics Workspace ID returned by when you created the Azure Automation account, otherwise leave it blank"
$LogAnalyticsPrimaryKey = Read-Host -Prompt "If you want to use Log Analytics, enter the Log Analytics Primary Key returned by when you created the Azure Automation account, otherwise leave it blank"
$RecurrenceInterval = Read-Host -Prompt "Enter how often you'd like the job to run in minutes, for example, '15'"
$BeginPeakTime = Read-Host -Prompt "Enter the start time for peak hours in local time, for example, 9:00"
$EndPeakTime = Read-Host -Prompt "Enter the end time for peak hours in local time, for example, 18:00"
$TimeDifference = Read-Host -Prompt "Enter the time difference between local time and UTC in hours, for example, +5:30"
$SessionThresholdPerCPU = Read-Host -Prompt "Enter the maximum number of sessions per CPU that will be used as a threshold to determine when new session host VMs need to be started during peak hours"
$MinimumNumberOfRDSH = Read-Host -Prompt "Enter the minimum number of session host VMs to keep running during off-peak hours"
$MaintenanceTagName = Read-Host -Prompt "Enter the name of the Tag associated with VMs you don't want to be managed by this scaling tool"
$LimitSecondsToForceLogOffUser = Read-Host -Prompt "Enter the number of seconds to wait before automatically signing out users. If set to 0, any session host VM that has user sessions, will be left untouched"
$LogOffMessageTitle = Read-Host -Prompt "Enter the title of the message sent to the user before they are forced to sign out"
$LogOffMessageBody = Read-Host -Prompt "Enter the body of the message sent to the user before they are forced to sign out"

$AutoAccount = Get-AzAutomationAccount | Out-GridView -OutputMode:Single -Title "Select the Azure Automation account"
$AutoAccountConnection = Get-AzAutomationConnection -ResourceGroupName $AutoAccount.ResourceGroupName -AutomationAccountName $AutoAccount.AutomationAccountName | Out-GridView -OutputMode:Single -Title "Select the Azure RunAs connection asset"

$WebhookURIAutoVar = Get-AzAutomationVariable -Name 'WebhookURIARMBased' -ResourceGroupName $AutoAccount.ResourceGroupName -AutomationAccountName $AutoAccount.AutomationAccountName

$Params = @{
    "AADTenantId"                  = $AADTenantId                            # Optional. If not specified, it will use the current Azure context
    "SubscriptionID"                = $AzSubscription.Id                      # Optional. If not specified, it will use the current Azure context
    "ResourceGroupName"            = $ResourceGroup.ResourceGroupName        # Optional. Default: "AVDAutoScaleResourceGroup"
    "Location"                      = $ResourceGroup.Location                  # Optional. Default: "West US2"
    "UseARMAPI"                    = $true
    "HostPoolName"                  = $AVDHostPool.Name
    "HostPoolResourceGroupName"    = $AVDHostPool.ResourceGroupName          # Optional. Default: same as ResourceGroupName param value
    "LogAnalyticsWorkspaceId"      = $LogAnalyticsWorkspaceId                # Optional. If not specified, script will not log to the Log Analytics
    "LogAnalyticsPrimaryKey"        = $LogAnalyticsPrimaryKey                  # Optional. If not specified, script will not log to the Log Analytics
    "ConnectionAssetName"          = $AutoAccountConnection.Name              # Optional. Default: "AzureRunAsConnection"
    "RecurrenceInterval"            = $RecurrenceInterval                      # Optional. Default: 15
    "BeginPeakTime"                = $BeginPeakTime                          # Optional. Default: "09:00"
    "EndPeakTime"                  = $EndPeakTime                            # Optional. Default: "17:00"
    "TimeDifference"                = $TimeDifference                          # Optional. Default: "-7:00"
    "SessionThresholdPerCPU"        = $SessionThresholdPerCPU                  # Optional. Default: 1
    "MinimumNumberOfRDSH"          = $MinimumNumberOfRDSH                    # Optional. Default: 1
    "MaintenanceTagName"            = $MaintenanceTagName                      # Optional.
    "LimitSecondsToForceLogOffUser" = $LimitSecondsToForceLogOffUser          # Optional. Default: 1
    "LogOffMessageTitle"            = $LogOffMessageTitle                      # Optional. Default: "Machine is about to shutdown."
    "LogOffMessageBody"            = $LogOffMessageBody                      # Optional. Default: "Your session will be logged off. Please save and close everything."
    "WebhookURI"                    = $WebhookURIAutoVar.Value
}

.\CreateOrUpdateAzLogicApp.ps1 @Params

```

After you run the script, the Azure Logic App should appear in a resource group, as shown in the following image.<br>

:::image type="content" source="../media/scale-session-hosts-azure-automation-image-2-23b17185.png" alt-text="An image of Azure Logic App appearing in a resource group.":::


To make changes to the execution schedule, such as changing the recurrence interval or time zone, go to the Azure Logic Apps autoscale scheduler and select **Edit** to go to the Azure Logic Apps Designer.

:::image type="content" source="../media/logic-apps-designer-edd1bffd.png" alt-text="An image of how to make changes to the execution schedule.":::
