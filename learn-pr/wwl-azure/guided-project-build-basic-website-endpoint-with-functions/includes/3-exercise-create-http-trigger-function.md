This guided project consists of the following exercises:

 - Create the Function App
 - **Deploy an HTTP-trigger function**
 - Test endpoint and review logs

In this exercise, you use Cloud Shell to create a function project with an HTTP trigger and deploy it to your Function App. This gives you a live HTTP endpoint that anyone can call from a browser.

This exercise includes the following tasks:

 - Open Cloud Shell
 - Create the function project
 - Deploy the function to Azure

**Outcome:** A callable HTTP endpoint deployed to your Function App using Cloud Shell.

## Task 1: Open Cloud Shell

Launch Azure Cloud Shell so you can use the command line to create and deploy a function.

1.  In the Azure portal, select the **Cloud Shell** icon in the top toolbar (it looks like a command prompt **>_**).
2.  If prompted to choose **Bash** or **PowerShell**, select **Bash**. If Cloud Shell opens without prompting, look in the upper-left corner of the Cloud Shell pane. If you see a **Switch to Bash** button, select it. If you see **Switch to PowerShell**, you're already in Bash. It may take a minute for Cloud Shell to initialize.
3.  If prompted to create storage, select **Create storage** and wait for Cloud Shell to initialize.
4.  Confirm you see a Bash command prompt at the bottom of the portal.

> [!NOTE]
> **Validation step:** Confirm the Cloud Shell terminal is open and shows a **$** prompt.

## Task 2: Create the function project

Use the Azure Functions Core Tools in Cloud Shell to scaffold a new function project with an HTTP trigger.

1.  At the Cloud Shell prompt, run the following command to create a new function project folder and switch into it:

    ```bash
    mkdir func-gp-endpoint && cd func-gp-endpoint
    ```

2.  Run the following command to initialize a new Functions project using the Node.js runtime. This may take a minute while it installs the required packages.

    ```bash
    func init --worker-runtime node --language javascript --model V4
    ```

3.  Run the following command to add an HTTP-triggered function named **GetStatus**:

    ```bash
    func new --name GetStatus --template "HTTP trigger" --authlevel anonymous
    ```

    > [!NOTE]
    > The `--authlevel anonymous` flag means anyone with the URL can call this function without providing a key or signing in. This is useful for testing but should not be used for production endpoints that handle sensitive data.

4.  Confirm the output shows the function was created by running:

    ```bash
    ls src/functions/
    ```

    You should see a file named **GetStatus.js**.

> [!NOTE]
> **Validation step:** Confirm you see **GetStatus.js** in the `src/functions/` directory.

## Task 3: Deploy the function to Azure

Publish the function project to the Function App you created in the previous exercise.

1.  Run the following command to look up your Function App name and store it in a variable:

    ```bash
    FUNC_APP_NAME=$(az functionapp list --resource-group rg-gp-functions-endpoint --query "[0].name" -o tsv)
    echo $FUNC_APP_NAME
    ```

    Confirm the output displays the Function App name you created in the previous exercise.

2.  Run the following command to publish the function project to your Function App:

    ```bash
    func azure functionapp publish $FUNC_APP_NAME
    ```

3.  Wait for the deployment to complete. The output displays the function's public URL, which looks like:

    ```
    Functions in <your-function-app-name>:
        GetStatus - [httpTrigger]
            Invoke url: https://<your-function-app-name>.azurewebsites.net/api/getstatus
    ```

4.  Copy the **Invoke url** from the output. You use this URL in the next exercise to test the function.

> [!NOTE]
> **Validation step:** Confirm the deployment output shows the **GetStatus** function with an Invoke url.