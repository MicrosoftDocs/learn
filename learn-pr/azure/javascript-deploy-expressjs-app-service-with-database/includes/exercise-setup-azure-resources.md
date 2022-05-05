Create the Azure web app and monitoring resources. The Cosmos DB resource is created later in this module.

## Sign in to the Learn sandbox

Select the **Sign in to activate sandbox** button to sign in. This step might include reviewing permissions. When you see **Sandbox activated!** with a time remaining on this page, this step is complete.

Make sure you use the same user account to sign in both of the following:
* Learn sandbox
* Azure, from Visual Studio Code.

The following Learn sandbox information may be useful to troubleshoot connection issues that may occur:

|Name|Value|
|--|--|
|Azure cloud|AzureCloud|
|Tenant|604c1504-c6a3-4080-81aa-b33091104187|
|Subscription name|Concierge Subscription|
|Subscription Id|2e3431a6-9673-485f-a9d9-2296d848d530|

## Find the subscription in Visual Studio Code

Find the free sandbox subscription in Visual Studio Code.

1. Open Visual Studio Code.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign Out**. When you sign in, the Learn sandbox tenant is available.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign In to Azure Cloud** to complete the sign-in process.
1. When the listing of Azure clouds appears, select **Azure Cloud**.
1. After the process is finished, your account appears in the bottom bar. An example is `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions to the sandbox subscription.

    |Subscription name|Value|
    |--|--|
    |**Subscription name**|`Concierge Subscription`|
1. Enable the sandbox subscription **Concierge Subscription**. Clear any other subscription checkboxes so that you can focus while you complete this module.

## Create the Azure resources with a script

This exercise uses an Azure CLI script. If you would rather create the resources with Visual Studio Code, use [these instructions from a previous module](/learn/modules/javascript-deploy-expressjs-app-service/create-app-service-resource) in the Learn JavaScript on Azure path. 

### [Browser terminal](#tab/browser-terminal)

These instructions should be used if you aren't using dev containers.

1. Using the sandbox's terminal, to sign in to Azure CLI (already in the terminal) with the Sandbox tenant (a tenant is a specific instance of Azure AD containing accounts and groups):

    ```azurecli
    az login -t 604c1504-c6a3-4080-81aa-b33091104187
    ```

1. Complete the sign-in experience. A browser window may open as part of that experience. 
1. After you select your account and sign in, close the browser.
1. Copy the following bash script:

    ```bash
    RESOURCEGROUPSTRING=$(az group list --query "[0].name")
    RESOURCEGROUPNAME=`sed -e 's/^"//' -e 's/"$//' <<<"$RESOURCEGROUPSTRING" `
    
    printf '%s \n' "$RESOURCEGROUPNAME"
    
    # Silently install AZ CLI extensions if needed
    # on older versions
    echo "Allow extensions to auto-install"
    az config set extension.use_dynamic_install=yes_without_prompt
    
    echo "Create app insights"
    az monitor app-insights component create --resource-group "$RESOURCEGROUPNAME" --location westus --app js-rentals
    
    echo "Create app plan"
    az appservice plan create --resource-group "$RESOURCEGROUPNAME" --name js-rentals --location westus3 --sku F1 --is-linux
    
    echo "Create web app"
    az webapp create --resource-group "$RESOURCEGROUPNAME" --location westus3 --name js-rentals --os-type "Linux" --runtime "node|14-lts" 
    
    echo "Connect web app to app insights"
    az monitor app-insights component connect-webapp --resource-group "$RESOURCEGROUPNAME" --app js-rentals --web-app js-rentals
    ```

1. On this page, in the sandbox terminal, create a new file:

    ```bash
    nano setup-in-sandbox-terminal.sh
    ```
1. Paste the contents into the file and save the file with <kbd>ESC</kbd> + <kbd>Q<KBD>.
1. Run the file:

    ```bash
    bash setup-in-sandbox-terminal.sh
    ```

1. In Visual Studio Code, make sure the root of the File explorer is still the root of the **3-Add-cosmosdb-mongodb** folder in the samples repo.
1.  Select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. Select and expand **App Service**. If the **js-rentals** web app isn't displayed, refresh the list.
1. Right-click on the web app and select **Deploy to web app**. This moves your local sample project onto your Azure App Service Resource.


### [Container terminal](#tab/container-terminal)

1. Using the dev container's terminal, to sign in to Azure CLI:

    ```azurecli
    az login -t 604c1504-c6a3-4080-81aa-b33091104187
    ```

1. Complete the sign-in experience. A browser window may open as part of that experience. 
1. After you select your account and sign in, close the browser.
1. The dev container's terminal resulting JSON array of objects includes all the subscriptions you have access to at this time. 

    ```json
    [
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "604c1504-c6a3-4080-81aa-b33091104187",
    "id": "2e3431a6-9673-485f-a9d9-2296d848d530",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Concierge Subscription",
    "state": "Enabled",
    "tenantId": "604c1504-c6a3-4080-81aa-b33091104187",
    "user": {
      "name": "YOUR-EMAIL",
      "type": "user"
    }
  }
]
    ```

1. To create the resources, run the following script:

    ```bash
    bash setup-in-sandbox.sh
    ```

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. Select and expand **App Service**. If the **js-rentals** web app isn't displayed, refresh the list.
1. Expand the **js-rentals** resource to view the areas such as files, app settings, and logs.

---

## View your web app

1. In Visual Studio Code, using the **Azure** pane, right-click the **js-rentals** web app and select **Browse website**.
1. The deployed web app opens in a browser. The web app should display a message that the database isn't connected. This is the correct state of the app.

## Check your work

* The web app resource is created.
* The web app displays in a browser. 