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

TODO

::: zone-end

::: zone pivot="csharp"

TODO

::: zone-end

1. Finally, run the following to start the function. Observe the results.

    ```cmd
    func start
    ```

## Compare results to database
<!-- Introduction paragraph -- compare results to what is actually in the database  -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Configure for CI/CD with GitHub

<!-- Summary paragraph --> TODO

1. TODO: Get package profile
1. TODO: Configure yaml file and github secrets
1. TODO: Push and monitor deployment
1. <!-- Step  -- directions will vary slightly based on language chosen -->

## Monitor results in the Azure portal
<!-- Introduction paragraph -->

`$resourceGroupName = "<rgn>[sandbox resource group name]</rgn>"`

If you have any issues or want to confirm the resources were deployed, you can review in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)


1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
