In the bus-catching scenario, the real-time bus data needs to be processed and stored in Azure SQL Database. After the data is brought in, it needs to be analyzed to identify buses entering or exiting the active geofence(s). In this exercise, you'll run the function locally before deploying it with GitHub Actions. Finally, you'll monitor the results in the Azure portal.

## Locally run and debug Azure Functions

The first step with any Azure Function project is to get your function running locally.

1. Open **Visual Studio Code** and select **File** > **Open folder** to open the folder where your forked GitHub repository is located.

2. Select the **Extensions** icon on the left-hand taskbar. Install [**Azurite**](https://marketplace.visualstudio.com/items?itemName=Azurite.azurite), an open-source Azure Storage API emulator. This extension is needed to run functions locally.

3. Select **View** > **Command Palette...** and type **Azurite: Start**, then select **Azurite: Start**.

::: zone pivot="python"

4. Under **Explorer**, navigate and open **azure-function** > **python** > **GetBusData** > **__init__.py**. Review the code.

5. Rename **`local.settings.json.template`** to **`local.settings.json`**.

6. In **`local.settings.json`** update the Azure SQL connection string value to reference your server name and password.

7. **Save** the file.

8. In Visual Studio Code, select **Terminal** > **New Terminal** and run the following to navigate to the root of the function and install the python requirements.

    ```cmd
    cd azure-function\python
    pip install -r requirements.txt
    ```

::: zone-end

::: zone pivot="node"

4. Under **Explorer**, navigate and open **azure-function** > **node** > **GetBusData** > **index.js**. Review the code.

5. Rename **`local.settings.json.template`** to **`local.settings.json`**.

6. In **`local.settings.json`** update the Azure SQL connection string value to reference your server name and password.

7. **Save** the file.

8. In Visual Studio Code, select **Terminal** > **New Terminal** and run the following to navigate to the root of the function and install the python requirements.

    ```cmd
    cd azure-function\node
    npm install
    ```

::: zone-end

::: zone pivot="csharp"

4. Under **Explorer**, navigate and open **azure-function** > **dotnet**. Review the code, specifically in _Services/BusDataManagerService.cs_ and _GetBusDataFunction.cs_..

5. Rename **`local.settings.json.template`** to **`local.settings.json`**.

6. In **`local.settings.json`** update the Azure SQL connection string value to reference your server name and password.

7. **Save** the file.

8. In Visual Studio Code, select **Terminal** > **New Terminal** and run the following to navigate to the root of the function and install the python requirements.

    ```cmd
    cd azure-function\dotnet
    dotnet build
    ```

::: zone-end

9. Finally, run the following to start the function. Observe the results.

    ```cmd
    func start
    ```

10. You might notice that if a bus enters or exits a geofence, there will be an error in calling the Logic App. That's OK for now. In a future exercise, you'll deploy and configure the Logic App to push notifications.

11. Run **CTRL** + **C** in the terminal to stop the function.

## Configure deployments for CI/CD with GitHub

Next, in order to publish the function to the Azure Function app you deployed in the previous exercise, you'll need to download the publish profile, configure settings in GitHub, and push your changes with Visual Studio Code.

1. Navigate to your Resource Group in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

2. Select your **Function App**.

3. Under **Settings**, select **Configuration**.

4. Select **New application setting** and add **`RealTimeFeedUrl`** with value **`https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json`**. Select **OK**.

5. Select **New application setting** and add **`AzureSQLConnectionString`** with the value from your **local.settings.json** file. Select **OK**.

6. Select **New application setting** and add **`LogicAppUrl`** with the value **`https://azure.com`**. You'll update this value later. Select **OK**.

7. Select **Save** to add the new settings. Select **Continue** to confirm.

8. In the **Overview** tab, select **Get publish profile** to download the publish profile for your function.

9. Navigate to your GitHub repository for this sample and select **Settings** > **Secrets** > **Actions** > **New repository secret**.

10. Name the secret **AZURE_FUNCTIONAPP_PUBLISH_PROFILE** and for the *Value*, copy and paste the contents from the publish profile you downloaded.

11. Select **Add secret** to store it.

::: zone pivot="node"

12. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **nodefunction.yml.template** to **nodefunctions.yml**.

::: zone-end

::: zone pivot="python"

12. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **pythonfunction.yml.template** to **pythonfunctions.yml**.

::: zone-end

::: zone pivot="csharp"

12. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **dotnetfunction.yml.template** to **dotnetfunctions.yml**.

::: zone-end

13. Select **Source Control** and add a commit message of **`enable function workflow`**.

14. Select the **checkmark**, and then select the **...** > **Push** to kick off the workflow.

15. Navigate to your GitHub repository for this sample and select **Actions** to monitor the deployment of your Azure Function App action.

## Monitor results in the Azure portal

Now that everything is deployed, it's time to monitor the results in the Azure portal and compare to what you saw locally.

1. Once the actions are completed, navigate back to the Azure portal to your Azure Function App.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select **Functions** under *Functions* > **GetBusData** > **Monitor**.

1. Review the results under the **Invocations** and **Logs** tabs. They should be similar to what you saw in the terminal when you ran the function locally.

1. Just like locally, you might notice that if a bus enters or exits a geofence, there will be an error in calling the Logic App. That's OK for now. In a future exercise, you'll deploy and configure the Logic App to push notifications.
