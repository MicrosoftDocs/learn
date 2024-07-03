## Enable the KEDA add-on on an AKS cluster

1. Use the following commands to create environment variables for the resource group name, location, and cluster name for use throughout this module:

    ```azurecli-interactive
    RESOURCE_GROUP=<resource-group-name>
    LOCATION=<location>
    CLUSTER_NAME=<aks-cluster-name>
    ```

2. Create an Azure resource group using the `az group create` command.

    ```azurecli-interactive
    az group create --name $RESOURCE_GROUP --location $LOCATION
    ```

3. Create an AKS cluster with the KEDA add-on enabled using the `az aks create` command and the `--enable-keda` flag.

    ```azurecli-interactive
    az aks create --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --enable-keda --generate-ssh-keys
    ```

    This command can take a few minutes to run.

4. Connect to your AKS cluster using the `az aks get-credentials` command.

    ```azurecli-interactive
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

5. Verify the KEDA add-on is installed on your cluster using the `az aks show` command and set the `--query` flag to `workloadAutoScalerProfile.keda.enabled`.

    ```azurecli-interactive
    az aks show --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP --query "workloadAutoScalerProfile.keda.enabled"
    ```

    Your output should look like the following example output, which shows the KEDA add-on is installed on the cluster:

    ```output
    true
    ```

## Create an Azure Cache for Redis instance

1. Use the following command to create an environment variable for the Redis name for use throughout this module:

    ```azurecli-interactive
    REDIS_NAME=contoso-redis-$RANDOM
    ```

1. Create an Azure Cache for Redis instance using the `az redis create` command:

    ```azurecli-interactive
    az redis create --location $LOCATION --name $REDIS_NAME --resource-group $RESOURCE_GROUP --sku Basic --vm-size c0 --enable-non-ssl-port
    ```

    This command can take several minutes to run.

1. Create environment variables for the Redis host and key for use throughout this module using the `az redis show` and `az redis list-keys` commands:

    ```azurecli-interactive
    REDIS_HOST=$(az redis show -n $REDIS_NAME -g $RESOURCE_GROUP -o tsv --query "hostName")
    REDIS_KEY=$(az redis list-keys --name $REDIS_NAME --resource-group $RESOURCE_GROUP -o tsv --query "primaryKey")
    ```
