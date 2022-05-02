Use the Azure CLI, provided as part of the Visual Studio Code dev container, to create the Azure resources for your web app and monitoring.

The Cosmos DB resource will be created later in this module.

## Create the Azure resources with a script

1. Using the dev container's terminal, to login to Azure CLI:

    ```azurecli
    az login -t 604c1504-c6a3-4080-81aa-b33091104187
    ```

1. Complete the login experience. A browser window may open as part of that experience. 
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

1. To create the resources run the following script:

    ```bash
    bash setup-in-sandbox.sh
    ```

## Check your work

In Visual Studio Code, use the Azure Explorer to view your Azure App Service. 

