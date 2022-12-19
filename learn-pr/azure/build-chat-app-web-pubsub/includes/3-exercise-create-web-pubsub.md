1. Sign in to the Azure CLI by activating the Sandbox.

1. Create a globally unique name for your Azure Web PubSub resource. 

    ```azurecli
    WPS_NAME=<my-unique-name>
    ```

1. Install or upgrade the *webpubsub* Azure CLI extension to the current version.

    ```azurecli
    az extension add --upgrade --name webpubsub
    ```

1. Create a Web PubSub resource in the automatically created resource group in the Sandbox. It can take a few minutes to create the Web PubSub resource.

    ```azurecli
    az webpubsub create \
      --name $WPS_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --location "eastus2" \
      --sku Free_F1
    ```

1. Retrieve the Azure Web PubSub access key and store it in the `AWPS_ACCESS_KEY` variable for later use.

    ```azurecli
    AWPS_ACCESS_KEY=$(az webpubsub key show \
      --name $WPS_NAME \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query primaryConnectionString --output tsv)
    ```
