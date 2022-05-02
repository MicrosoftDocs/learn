Use the Azure CLI, provided as part of the Visual Studio Code dev container, to create the Azure resources for your web app and monitoring.

The Cosmos DB resource will be created later in this module.

## Create the Azure resources with a script

1. Using the dev container's terminal, to login to Azure CLI:

    ```azurecli
    az login
    ```

1. Complete the login experience. A browser window may open as part of that experience. 
1. The resulting JSON array of objects includes all the subscriptions you have access to at this time. 

1. To create the resources run the following script:

    ```bash
    bash setup-in-sandbox.sh
    ```