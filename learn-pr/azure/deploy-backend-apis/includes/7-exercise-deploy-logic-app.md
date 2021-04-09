<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Azure Logic Apps simplifies how you design and build scalable solutions for a variety of purposes.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
Recall in the bus-catching scenario, the goal is to ultimately send notifications to application users when their monitored bus route has a bus entering the GeoFence. Azure SQL Database and Azure Functions are helping track and trigger this, but Logic Apps can actually be used to send the notifications once triggered.

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
Here, you'll deploy a pre-configured Azure Logic App which sends an email containing the bus route and status when triggered by an Azure Function. This exercise uses Outlook for notifications, but you could easily plug in an alternative such as Gmail.

## Deploy Azure Logic App

The first step is to deploy the Azure Logic App using a combination of Azure PowerShell and ARM templates. You'll need to first gather some information from GitHub in order to access the ARM template from the Azure Cloud Shell. 

1. In your GitHub account settings, near the bottom left, select **Developer settings** > **Personal access tokens** > **Generate new token** > **check all boxes** and generate the token. Make a note of the token as you'll need it shortly.

1. Make note of your GitHub repository (e.g. https://github.com/[username]/serverless-full-stack-apps-azure-sql).

1. The following script clones the repository and deploys an Azure Logic App according to an ARM template.

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

The next step is to configure the Logic App and update the Application Setting for your Azure Function App.

1. Once your Logic App is deployed, navigate to your Resource Group in the Azure portal and select the **Logic App** you deployed.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Under *Development Tools*, select **Logic app designer**. Review the flow.

1. You'll notice there's an error for the Outlook.com connection. Select **Add new**.

1. Sign in to an Outlook account that you have access to.

1. Once successfully connected, you will see the email and it's contents. In the *To* field, enter the email address where you'd like to receive notifications.

1. Select **Save**.

1. Select **When a HTTP request is received** and copy the **HTTP POST URL**.

1. In the Azure portal, navigate back to your Azure Function App.

1. Under *Settings*, select **Configuration**.

1. Select the **Edit** pencil icon for **LogicAppUrl** and update the value with the Logic App POST URL you just copied.

1. Select **OK**.

1. Select **Save**.

## Monitor and observe results

Now that everything is updated, it's time to monitor the results (and your inbox).

1. Navigate to your Azure Function App in the Azure portal and select **Functions** > **GetBusData** > **Monitor**.

1. Note that the **Invocations** has ~5 minute delay, whereas the **Logs** are closer to real-time. Review the **Logs**.

1. When a bus activates a GeoFence, what do you see? Did you receive an email? The answers to these questions should help you understand if your application is working properly.

> [!TIP]
> Depending on what time you are testing this out, you may have to wait a significant time for a bus to enter a GeoFence. If you want to trigger it, connect to your Azure SQL Database in Azure Data Studio and run the following T-SQL:
>
>```sql
>    DECLARE @RC int
>    DECLARE @payload NVARCHAR(max) = N'[{
>            "DirectionId": 1,
>            "RouteId": 100113,
>            "VehicleId": 1,
>            "Position": {
>                "Latitude": 47.61703550242447,
>                "Longitude": -122.14263367613601 
>            },
>            "TimestampUTC": "20201031"
>        },{
>            "DirectionId": 2,
>            "RouteId": 100113,
>            "VehicleId": 2,
>            "Position": {
>                "Latitude": 47.61703550242447,
>                "Longitude": -122.14263367613601 
>            },
>            "TimestampUTC": "20201030"
>        },{
>            "DirectionId": 2,
>            "RouteId": 100113,
>            "VehicleId": 2,
>            "Position": {
>                "Latitude": 47.61528240582737,
>                "Longitude": -122.14308643341062
>            },
>            "TimestampUTC": "20201031"
>    }]';
>    EXECUTE @RC = [web].[AddBusData] 
>       @payload
>    GO
>```

TODO: The tip is not quite working ....
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->
