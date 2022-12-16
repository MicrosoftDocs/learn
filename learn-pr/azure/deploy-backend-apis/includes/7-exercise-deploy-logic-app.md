Azure Logic Apps simplifies how you design and build scalable solutions for various purposes.

Recall in the bus-catching scenario, the goal is to ultimately send notifications to application users when their monitored bus route has a bus entering the geofence. Azure SQL Database and Azure Functions are helping track and trigger this, but Logic Apps can actually be used to send the notifications once triggered.

Here, you'll deploy a pre-configured Azure Logic App, which sends an email containing the bus route and status when triggered by an Azure Function. This exercise uses Outlook for notifications, but you could easily plug in an alternative such as Gmail.

## Deploy the Azure Logic App

The first step is to deploy the Azure Logic App using a combination of Azure PowerShell and Azure Resource Manager (ARM) templates. You'll need to first gather some information from GitHub to access the ARM template from the Azure Cloud Shell.

<!--1. In your GitHub account settings, near the bottom left, select **Developer settings** > **Personal access tokens** > **Generate new token** > **check all boxes** and generate the token. Make a note of the token as you'll need it shortly.-->

1. Make note of your GitHub repository (for example, `https://github.com/[username]/serverless-full-stack-apps-azure-sql`).

1. The following script clones the repository and deploys an Azure Logic App according to an ARM template. ARM templates won't be discussed in this module, but you can think of them like a recipe for how to build an Azure service. This one is built to include the Outlook connector.

    ```powershell
    # Resource group name and resource group
    $resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like $resourceGroupName
    $location = $resourceGroup.Location
    # Get the repository name
    $appRepository = Read-Host "Enter your GitHub repository URL (e.g. https://github.com/[username]/serverless-full-stack-apps-azure-sql):"
    # Clone the repo - note this asks for the token
    $cloneRepository = git clone $appRepository
    # Get subscription ID 
    $subId = [Regex]::Matches($resourceGroup.ResourceId, "(\/subscriptions\/)+(.*\/)+(.*\/)").Groups[2].Value
    $subId = $subId.Substring(0,$subId.Length-1)
    # Deploy logic app
    az deployment group create --name DeployResources --resource-group $resourceGroupName `
        ` --template-file ./serverless-full-stack-apps-azure-sql/deployment-scripts/template.json `
        --parameters subscription_id=$subId location=$location  
    ```

## Review and update the Logic App

The next step is to configure the Logic App to connect to your email address and update the Application Setting for your Azure Function App.

1. Once your Logic App is deployed, navigate to your Resource Group in the Azure portal and select the **Logic App** you deployed.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Under *Development Tools*, select **Logic app designer**. Review the flow.

1. You'll notice there's an error for the Outlook.com connection. Select **Add new**.

1. Sign in to an Outlook account that you have access to.

1. Once successfully connected, you'll see the email and its contents. In the *To* field, enter the email address where you'd like to receive notifications.

1. Select **Save**.

1. Select **When a HTTP request is received** and copy the **HTTP POST URL**.

1. In the Azure portal, navigate back to your Azure Function App.

1. Under *Settings*, select **Configuration**.

1. Select the **Edit** pencil icon for **LogicAppUrl** and update the value with the Logic App POST URL you copied.

1. Select **OK**.

1. Select **Save**.

## Monitor and observe results

Now that everything is updated, it's time to monitor the results (and your inbox).

1. Navigate to your Azure Function App in the Azure portal and select **Functions** > **GetBusData** > **Monitor**.

1. The **Invocations** have ~5-minute delay, whereas the **Logs** are closer to real time. Review the **Logs**.

1. When a bus activates a geofence, what do you see? Did you receive an email? The answers to these questions should help you understand if your application is working properly.

> [!WARNING]
> Depending on what time you are testing this out and current bus activity, you may have to wait for some time for a bus to enter a geofence.
