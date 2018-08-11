
In this exercise, you will use the Azure CLI on your local machine to create a resource group, and then to deploy a Web App into this resource group. 

### Steps to create a resource group
1. Open a bash shell on Linux or macOS, or open the Command Prompt or PowerShell if working from Windows.

1. Start the Azure CLI and run the login command.

    ```bash
    az login
    ```
    If you do not get an Azure sign in page in your web browser, follow the command line instructions and enter an authorization code at [https://aka.ms/devicelogin](https://aka.ms/devicelogin).

1. Create a resource group.

    ```bash
    az group create --location westeurope --name popupResGroup
    ```

1. Verify that the resource group was created successfully, by listing all your resource groups in a table.

    ```bash
    az group list --output table
    ```
1. Optionally, confirm the resource was created in the Azure Portal. Open a web browser, login to the Portal and navigate to the **Resource Groups** section (see below). The new resource group should be displayed in the list.

![Using the Portal to List Resource Groups](../images/listing-resource-groups.png)

### Steps to create a service plan
When you run Web Apps, using the Azure Apps Service, you pay for the Azure compute resources used by the app, and this depends on the App Service plan associated with your Web Apps. Service plans determine the region used for the app datacenter, number of VMs used, and pricing tier.

1. Create an App Service plan to run your app. The name of the app and plan must be unique, so change the string "12345" to a random number. The following command does not specify a pricing tier or VM instance details, so by default, you'll get a **Basic** plan with 1 **Small** VM instance.

    ```bash
    az appservice plan create --name popupapp12345 --resource-group popupResGroup --location westeurope
    ```

1. Verify that the service plan was created successfully, by listing all your plans in a table.

    ```bash
    az appservice plan list --output table
    ```

### Steps to create a web app
Next, you'll create the web app in your service plan. You can deploy the code at the same time, but for our example, we'll do this as separate step.

1. Create the web app, remembering to change the string "12345" to the same random number you used earlier.
    ```bash
    az webapp create --name popupapp12345 --resource-group popupResGroup --plan popupapp12345
    ```

1. Verify that the app was created successfully, by listing all your apps in a table.

    ```bash
    az webapp list --output table
    ```

1. Make a note of the **DefaultHostName**, you will need this later.

### Steps to deploy code from GitHub
1. The final step is to deploy code from a GitHub repository to the Web App, again remembering to change the string "12345" to the same random number you used earlier.
    ```bash
    az webapp deployment source config --name popupapp12345 --resource-group popupResGroup --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
    ```

1. Copy the following url into a browser to see the web app.
http://popupapp12345.azurewebsites.net

1. The page display "HelloWorld!"

1. Close the browser window.

## Summary
This exercise demonstrated a typical pattern for an interactive Azure CLI session. You first used a standard command to create a new resource group. You then used a set of commands to deploy a resource (in this example, a web app) into this resource group. This set of commands could easily be combined into a shell script, and executed every time you need to create the same resource.
