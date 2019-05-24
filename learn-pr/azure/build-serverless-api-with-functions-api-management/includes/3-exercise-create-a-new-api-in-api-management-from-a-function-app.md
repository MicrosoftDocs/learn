<!-- TODO: Add introduction -->

## Create functions

<!-- TODO: add some blurb -->

1. To clone the functions project, in the Cloud Shell on the right, execute this command:

    <!-- TODO: the URL in this git clone command must be updated when the correct location is known -->

    ```bash
    git clone http://github.com/<reponame>
    ```

1. To run the script that sets up the necessary Azure resources, execute these commands:

    ```bash
    cd OnlineStoreFuncs
    bash setup.sh
    ```

## Test the product details function

<!-- TODO: Add some blurb -->

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. Click **All Resources** and then click the product function.
1. Under **Functions**, click **ProductDetails**, and then click **Test**.

    ![Test the ProductDetails function](../media/3-test-product-details-function.png)

1. In the **HTTP method** drop-down list, select **GET**, and then click **Add parameter**.
1. In the **name** textbox, type **id** and in the **value** textbox, type **3**.
1. Click **Run** and then examine the results in the **Output** box.

    ![Test results from the ProductDetails function](../media/3-test-results.png)

    The output pain displays the details of a product in JSON format. You can also test the function with IDs 1 and 2 for different products.

1. At the top of the page, click **</> Get function URL**. Notice that the URL is the name of the function within the **azurewebsites.net** domain. Make a note of this URL for later comparison.




<!-- TODO: This seems incomplete. WHat we actually need are:

1. A VS Code project in a Git Hub location that implements the two functions
1. Clone that.
1. Include a script that installs the Azure FUnctions Core Tools by using npm, creates a resource group, storage account, and two function resources in azure.
1. Script or get the students to deploy the functions to azure.
 -->

You must have a function app to host the execution of your functions. The function app provides an environment for serverless execution of your function code. It lets you group functions as a logic unit for easier management, deployment, and sharing of resources. Create a function app by using the az functionapp create command.

For this exercise you will create 2 Function Aps with HTTP trigger Functions. You can use the script below to setup a Function App (currently named as "func-App-instance1). Create a second name by changing the name to something similar such as (func-App-stance2) and running the serverless function app script below

```bash
#!/bin/bash

# Function app and storage account names must be unique.
storageName=mystorageaccount$RANDOM
functionAppName=func-App-instance1$RANDOM

# Create a resource group.
az group create --name myResourceGroup --location westeurope

# Create an Azure storage account in the resource group.
az storage account create \
  --name $storageName \
  --location westeurope \
  --resource-group myResourceGroup \
  --sku Standard_LRS

# Create a serverless function app in the resource group.
az functionapp create \
  --name $functionAppName \
  --storage-account $storageName \
  --consumption-plan-location westeurope \
  --resource-group myResourceGroup
```

Run the following to create HTTP trigger function or alternatively use the Azure Portal to create two Azure Functions

<!-- TODO: This command is not available unless you've installed the Azure Functions Core Tools (which you can do with npm) -->

```bash
func new --name Product --template "HttpTrigger" 
func new --name Order --template "HttpTrigger"
```

<!-- TODO: This might be "Http Trigger" with a space? -->
<!-- TODO: The functions are not published. We have to do that before we can add them to an APIM instance -->

<!-- TODO: show that one of the functions is working in Azure -->

## Create a new API Management instance

1. In the Azure portal, select **Create a resource** > **Integration** > **API management**
    Alternatively, choose New, type API management in the search box, and press Enter. Click Create

1. In the API Management service window, enter settings

    ![Screenshot of the Azure portal showing the Create a new API management instance.](../media/3-create-api-mgmt-instance.png)

> [!TIP]
> It usually takes between 20 and 30 minutes to create an API Management service. You can pin the newly created service to the dashboard by selecting Pin

### Import an Azure Function App as a new API

Follow the steps below to create a new API from an Azure Function App

1. In your **Azure API Management** service instance, select **APIs** from the menu on the left

1. In the **Add a new API** list, select **Function App**

    ![Screenshot of the Azure portal showing the adding of an Azure Function App to import.](../media/3-import-azure-function-app.png)

1. Click **Browse** to select Functions for import

    ![Screenshot of the Azure portal showing selecting an existing Function App](../media/3-import-azure-function-app-02.png)

1. Click on the **Function App** section to choose from the list of available Function Apps.

    ![Screenshot to select an existing Function App](../media/3-import-azure-function-app-03.png)

1. Find the **Function App** you want to import Functions from, click on it and press **Select**

    ![Screenshot to select an existing Function App](../media/3-import-azure-function-app-04.png)

1. Select the Functions you would like to import and click **Select**

    ![Screenshot to select an existing Function App](../media/3-import-azure-function-app-06.png)

1. Switch to the **Full** view and assign **Product** to your new API. If needed, edit other pre-populated fields
1. Click **Create**
