Now that you've learned how to create and deploy functions to Azure, it's time to put the theory into practice.

In this exercise, you'll learn how to configure your function for deployment to Azure Functions. Then you'll use Maven to deploy your function, and then you'll test your function in the cloud.

## Configure your function project for deployment

There are a few changes that need to be made to your function application before it can be deployed to Azure, and the following steps will walk you updating your project for deployment.

1. Determine the region for your sandbox resource group:

    1. Use the name of the resource group that was automatically created for you when you activated the the sandbox to retrieve the region where the resource group is located:

        ```bash
        az group show --name "<rgn>[sandbox resource group name]</rgn>" | jq -r '.location'
        ```

    1. Copy the name of the region that is displayed; you will use that region in the following steps.
    
1. Edit your *pom.xml* file to update the settings:

    1. In the Azure Cloud Shell, change to the root folder for your application. For example:

        ```bash
        cd ~/event-reporting
        ```

    1. Open your *pom.xml* in the Cloud Shell code editor.

        ```bash
        code pom.xml
        ```
    
    1. Locate the following artifact ID:

        ```xml
        <artifactId>azure-functions-maven-plugin</artifactId>
        ```

    1. In the following `<configuration>` section, locate the `<resourceGroup>` element, and update it with the name of your resource group. For example:

        ```xml
        <resourceGroup><rgn>[sandbox resource group name]</rgn></resourceGroup>
        ```

    1. Locate the `<region>` element, and update it with the name of the region where your resource group is located. For example:

        ```xml
        <region>westus</region>
        ```

    1. Press <kbd>Ctrl+S</kbd> to save your *pom.xml* file, and then press <kbd>Ctrl+Q</kbd> to close the code editor.

## Deploy your Azure Function

Now that you have configured your function for deployment, your next step is to deploy it to Azure Functions.

1. In the Azure Cloud Shell, change to the root folder for your application. For example:

    ```bash
    cd ~/event-reporting
    ```

1. Use the following command to build and deploy it to Azure Functions:

    ```bash
    mvn clean package azure-functions:deploy
    ```

    Maven will display a running status of the deployment. For example:

    ```output
    [INFO] Scanning for projects...
    [INFO]
    [INFO] ------------------------------------------------------------------------
    [INFO] Building Azure Java Functions 1.0-SNAPSHOT
    [INFO] ------------------------------------------------------------------------
    [INFO]
    [INFO] --- azure-functions-maven-plugin:1.4.1:deploy (default-cli) @ event-reporting ---
    [INFO] Auth Type : AZURE_CLI
    [INFO] Subscription : Concierge Subscription(12345678-1234-1234-1234-123456789abc)
    [INFO] The specified function app does not exist. Creating a new function app...
    [INFO] Set function worker runtime to java.
    [INFO] Successfully created the function app: event-reporting-20200102030405006.
    [INFO] Trying to deploy the function app...
    [INFO] Trying to deploy artifact to event-reporting-20200102030405006...
    [INFO] Successfully deployed the artifact to https://event-reporting-20200102030405006.azurewebsites.net
    [INFO] Successfully deployed the function app at https://event-reporting-20200102030405006.azurewebsites.net.
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 01:42 min
    [INFO] Finished at: 2020-01-01T09:26:45+00:00
    [INFO] Final Memory: 64M/320M
    [INFO] ------------------------------------------------------------------------
    ```

## Retrieving your Azure Function URL using the portal

You will recall from the exercise that you completed in a previous unit, you were required to create the URL to test your function in a web browser. However, there is a much easier method to retrieve the URL for your Azure Function by using the Azure portal. To do so, use the following steps.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. Select **All resources** from the menu on the left.

1. Select your function from the list of resources; for this exercise, your function's name begins with *event-reporting*. For example:

    ```
    event-reporting-20200102030405006
    ```

   Note that this is the same `function app` name that was reported in the deployment response earlier in this exercise.

1. Expand the **Functions** list, the select your **HttpExample** function. This will show you the *function.json* file for you function.

1. At the top of the function page, select **</> Get function URL**. This will allow you to copy the fully-constructed URL of your function. For example:

    ```
    https://event-reporting-20200102030405006.azurewebsites.net/api/HttpExample
    ```

    You'll use this URL in the next section of this exercise.

## Test your Azure Function in the portal

Now that you have deployed your function to Azure, all that is necessary to test your function in a web browser is to append a query string to the end of the URL as you have done in previous exercises.

1. Construct the URL for your function's API:

    1. Retrieve the URL that you copied in the preceding **Retrieving your Azure Function URL using the portal** section of this exercise; for example:

        ```
        https://event-reporting-20200102030405006.azurewebsites.net/api/HttpExample
        ```

    1. Append a query string that passes a name to the API URL; for example:

        ```
        https://event-reporting-20200102030405006.azurewebsites.net/api/HttpExample?name=Bob
        ```

    1. Copy this fully-constructed URL for use in the following steps.

1. Open a new tab in your web browser, and paste the fully-constructed URL from the previous steps into the address field.

1. When you instruct your web browser to request the URL, you will see a plaintext message returned to your web browser that is personalized for the name you passed in the query string. For example:

    ```output
    Hello, Bob
    ```

You have now successfully deployed and tested your function in Azure!
