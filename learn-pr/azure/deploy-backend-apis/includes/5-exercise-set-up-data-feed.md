<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Azure Functions can be used to do things like retrieve the latest data from a feed.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
In the bus-catching scenario, the real-time bus data needs to be processed and stored in Azure SQL Database. After the data is brought in, it needs to be analyzed to identify buses entering or exiting the active GeoFence(s).

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

## Run Azure Functions locally

The first step with any Azure Function project is to get your function running locally.

1. Open **Visual Studio Code** and select **File** > **Open folder** to open the folder where your forked GitHub repository is located.

1. Select the **Extensions** icon on the left-hand taskbar. Install **Azurite**, an open source Azure Storage API emulator. This is needed to run functions locally.

1. Select **View** > **Command Palette...** and type **Azurite: Start**, then select **Azurite: Start**.

::: zone pivot="python"

1. Under **Explorer**, navigate and open **azure-function** > **python** > **GetBusData** > **__init__.py**. Review the code.

1. Rename **`local.settings.json.template`** to **`local.settings.json`**.

1. In **`local.settings.json`** update the Azure SQL connection string value to reference your server name and password.

1. **Save** the file.

1. In Visual Studio Code, select **Terminal** > **New Terminal** and run the following to navigate to the root of the function and install the python requirements.

    ```cmd
    cd azure-function\python
    pip install -r requirements.txt
    ```

::: zone-end

::: zone pivot="node"

1. Under **Explorer**, navigate and open **azure-function** > **node** > **GetBusData** > **index.js**. Review the code.

1. Rename **`local.settings.json.template`** to **`local.settings.json`**.

1. In **`local.settings.json`** update the Azure SQL connection string value to reference your server name and password.

1. **Save** the file.

1. In Visual Studio Code, select **Terminal** > **New Terminal** and run the following to navigate to the root of the function and install the python requirements.

    ```cmd
    cd azure-function\node
    npm install
    ```

::: zone-end

::: zone pivot="csharp"

1. Under **Explorer**, navigate and open **azure-function** > **dotnet**. Review the code, specifically in **BusDataManager.cs** and **GetBusData.cs**.

1. Rename **`local.settings.json.template`** to **`local.settings.json`**.

1. In **`local.settings.json`** update the Azure SQL connection string value to reference your server name and password.

1. **Save** the file.

1. In Visual Studio Code, select **Terminal** > **New Terminal** and run the following to navigate to the root of the function and install the python requirements.

    ```cmd
    cd azure-function\dotnet
    dotnet build
    ```

::: zone-end

1. Finally, run the following to start the function. Observe the results.

    ```cmd
    func start
    ```

1. You might notice that if a bus enters or exits a GeoFence, there will be an error in calling the Logic App. That's OK for now. In a future exercise, you will deploy and configure the Logic App to push notifications.

1. Run **CTRL** + **C** in the terminal to stop the function.

## Configure for CI/CD with GitHub

Next, in order to publish the function to the Azure Function app you deployed in the previous exercise, you'll need to download the publish profile, configure settings in GitHub, and push your changes with Visual Studio Code.

1. Navigate to your Resource Group in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select your **Function App**.

1. Under **Settings**, select **Configuration**.

1. Select **New application setting** and add **`RealTimeFeedUrl`** with value **`https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json`**. Select **OK**.

1. Select **New application setting** and add **`AzureSQLConnectionString`** with the value from your **local.settings.json** file. Select **OK**.

1. Select **New application setting** and add **`LogicAppUrl`** with the value **`https://azure.com`**. You will update this later. Select **OK**.

1. Select **Save** to add the new settings. Select **Continue** to confirm.

1. In the **Overview** tab, select **Get publish profile** to download the publish profile for your function.

1. Navigate to your GitHub repository for this sample and select **Settings** > **Secrets** > **New repository secret**.

1. Name the secret **AZURE_FUNCTIONAPP_PUBLISH_PROFILE** and for the *Value*, copy and paste the contents from the publish profile you just downloaded.

1. Select **Add secret** to store it.

::: zone pivot="node"

1. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **nodefunction.yml.template** to **nodefunctions.yml**.

::: zone-end

::: zone pivot="python"

1. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **pythonfunction.yml.template** to **pythonfunctions.yml**.

::: zone-end

::: zone pivot="csharp"

1. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **dotnetfunction.yml.template** to **dotnetfunctions.yml**.

::: zone-end

1. Select **Source Control** and add a commit message of **`enable function workflow`**.

1. Select the **checkmark**, and then select the **...** > **Push** to kick off the workflow.

1. Navigate to your GitHub repository for this sample and select **Actions** to monitor the deployment of your Azure Function App action.

## Monitor results in the Azure portal

Now that everything is deployed, it's time to monitor the results in the Azure portal and compare to what you saw locally.

1. Once the actions are completed, navigate back to the Azure portal to your Azure Function App.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select **Functions** under *Functions* > **GetBusData** > **Monitor**.

1. Review the results under the **Invocations** and **Logs** tabs. They should be similar to what you saw in the terminal when you ran the function locally.

1. Just like locally, you might notice that if a bus enters or exits a GeoFence, there will be an error in calling the Logic App. That's OK for now. In a future exercise, you will deploy and configure the Logic App to push notifications.
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->
