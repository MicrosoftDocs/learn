Environment variables allow you to dynamically configure the application or script the container runs. You can use the Azure CLI, PowerShell, or the Azure portal to set variables when you create the container. Secured environment variables prevent sensitive information from displaying in the container's output.

Create an Azure Cosmos DB instance and use environment variables to pass the connection information to an Azure container instance. An application in the container uses the variables to write and read data from Azure Cosmos DB. Create both an environment variable and a secured environment variable so that you can see the difference between them.

## Deploy Azure Cosmos DB

1. When you deploy Azure Cosmos DB, you provide a unique database name. For learning purposes, run this command in Cloud Shell to create a Bash variable that holds a unique name:

    ```bash
    COSMOS_DB_NAME=aci-cosmos-db-$RANDOM
    ```

1. Run this `az cosmosdb create` command to create your Azure Cosmos DB instance:

    ```azurecli
    COSMOS_DB_ENDPOINT=$(az cosmosdb create \
      --resource-group learn-deploy-aci-rg \
      --name $COSMOS_DB_NAME \
      --query documentEndpoint \
      --output tsv)
    ```

    This command can take a few minutes to complete.

    `$COSMOS_DB_NAME` specifies your unique database name. The command prints the endpoint address for your database. Here, the command saves this address to the Bash variable `COSMOS_DB_ENDPOINT`.

1. Run `az cosmosdb keys list` to get the Azure Cosmos DB connection key and store it in a Bash variable named `COSMOS_DB_MASTERKEY`:

    ```azurecli
    COSMOS_DB_MASTERKEY=$(az cosmosdb keys list \
      --resource-group learn-deploy-aci-rg \
      --name $COSMOS_DB_NAME \
      --query primaryMasterKey \
      --output tsv)
    ```

## Deploy a container that works with your database

Create an Azure container instance that can read from and write records to your Azure Cosmos DB instance.

The two environment variables you created in the last part, `COSMOS_DB_ENDPOINT` and `COSMOS_DB_MASTERKEY`, hold the values you need to connect to the Azure Cosmos DB instance.

1. Run the following `az container create` command to create the container:

    ```azurecli
    az container create \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo \
      --image mcr.microsoft.com/azuredocs/azure-vote-front:cosmosdb \
      --ip-address Public \
      --location eastus \
      --environment-variables \
        COSMOS_DB_ENDPOINT=$COSMOS_DB_ENDPOINT \
        COSMOS_DB_MASTERKEY=$COSMOS_DB_MASTERKEY
    ```

    **azuredocs/azure-vote-front:cosmosdb** refers to a container image that runs a fictitious voting app.

    Note the `--environment-variables` argument. This argument specifies environment variables that are passed to the container when the container starts. The container image is configured to look for these environment variables. Pass the name of the Azure Cosmos DB endpoint and its connection key.

1. Run the `az container show` command to get your container's public IP address:

    ```azurecli
    az container show \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo \
      --query ipAddress.ip \
      --output tsv
    ```

1. In a browser, go to your container's IP address.

    > [!IMPORTANT]
    > Sometimes containers take a minute or two to fully start and be able to receive connections. If there's no response when you go to the IP address in your browser, wait a few moments and refresh the page.

    Once the app is available, you get this page:

    :::image type="content" source="../media/4-azure-vote.png" alt-text="Screenshot that shows the Azure voting application with two choices in a browser. Cats and Dogs." loc-scope="other"::: <!-- no-loc -->

    Try casting a vote for cats or dogs. Each vote is stored in your Azure Cosmos DB instance.

## Use secured environment variables to hide connection information

In the previous section, you used two environment variables to create your container. By default, these environment variables are accessible through the Azure portal and command-line tools in plain text.

In this section, learn how to prevent sensitive information, such as connection keys, from being displayed in plain text.

1. Let's start by seeing the current behavior in action. Run the following `az container show` command to display your container's environment variables:

    ```azurecli
    az container show \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo \
      --query containers[0].environmentVariables
    ```

    You get output with both values in plain text. Here's an example:

    ```json
    [
      {
        "name": "COSMOS_DB_ENDPOINT",
        "secureValue": null,
        "value": "https://aci-cosmos.documents.azure.com:443/"
      },
      {
        "name": "COSMOS_DB_MASTERKEY",
        "secureValue": null,
        "value": "Xm5BwdLlCllBvrR26V00000000S2uOusuglhzwkE7dOPMBQ3oA30n3rKd8PKA13700000000095ynys863Ghgw=="
      }
    ]
    ```

    Although these values don't appear to your users through the voting application, it's a good security practice to ensure that sensitive information (such as connection keys) isn't stored in plain text.

    Secure environment variables prevent clear text output. To use secure environment variables, use the `--secure-environment-variables` argument instead of the `--environment-variables` argument.

1. Run the following command to create a second container named **aci-demo-secure** that makes use of secured environment variables:

    ```azurecli
    az container create \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo-secure \
      --image mcr.microsoft.com/azuredocs/azure-vote-front:cosmosdb \
      --ip-address Public \
      --location eastus \
      --secure-environment-variables \
        COSMOS_DB_ENDPOINT=$COSMOS_DB_ENDPOINT \
        COSMOS_DB_MASTERKEY=$COSMOS_DB_MASTERKEY
    ```

    Note the use of the `--secure-environment-variables` argument.

1. Run the following `az container show` command to display your container's environment variables:

    ```azurecli
    az container show \
      --resource-group learn-deploy-aci-rg \
      --name aci-demo-secure \
      --query containers[0].environmentVariables
    ```

    This time, you can see that your environment variables don't appear in plain text:

    ```json
    [
      {
        "name": "COSMOS_DB_ENDPOINT",
        "secureValue": null,
        "value": null
      },
      {
        "name": "COSMOS_DB_MASTERKEY",
        "secureValue": null,
        "value": null
      }
    ]
    ```

    In fact, the values of your environment variables don't appear at all. That's OK because these values refer to sensitive information. Here, all you need to know is that the environment variables exist.
