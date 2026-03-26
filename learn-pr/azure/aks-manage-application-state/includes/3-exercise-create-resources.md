Now that we've reviewed the basic concepts of external states and how to deal with them using Kubernetes, let's create the resources that support your freight company's application and then create the application itself.

## Create a resource group

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign into [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your own subscription.
1. Open the Cloud Shell and select **Bash**.
1. Create an Azure resource group using the `az group create` command and specify a region. This example creates a resource group named _rg-ship-manager_ in the _eastus_ region:

    ```azurecli-interactive
    az group create --name rg-ship-manager --location eastus
    ```

    The creation process can take a few moments to complete.

## Create the state

As we described earlier, it's possible but not recommended to handle state in Kubernetes. Managing a highly available application state can become too difficult when you need to manage the state yourself.

To solve that problem, we externalize the state to an application that specializes in dealing with external state: Azure Cosmos DB.

> [!NOTE]
> Although we're creating an Azure Cosmos DB instance as part of the required resources to run the application, Azure Kubernetes Service (AKS) and Azure Cosmos DB aren't related to each other.

1. For Azure Cosmos DB, verify that the resource provider `Microsoft.DocumentDB` is registered in your subscription.

    ```azurecli-interactive
    az provider show --namespace Microsoft.DocumentDB --query "registrationState"
    ```

    If the output is `NotRegistered`, register the resource provider.

    ```azurecli-interactive
    az provider register --namespace Microsoft.DocumentDB
    ```

1. Create Bash variables to store the Azure Cosmos DB account name and the resource group name for use throughout the rest of the module.

    ```azurecli-interactive
    export RESOURCE_GROUP=rg-ship-manager
    export COSMOSDB_ACCOUNT_NAME=contoso-ship-manager-$RANDOM
    ```

1. Create a new Azure Cosmos DB account using the `az cosmosdb create` command.

    ```azurecli-interactive
    az cosmosdb create \
      --name $COSMOSDB_ACCOUNT_NAME \
      --resource-group $RESOURCE_GROUP \
      --kind MongoDB
    ```

    The creation process can take a few moments to complete.

1. Create a new database using the `az cosmosdb mongodb database create` command. In this example, the database is named _contoso-ship-manager_.

    ```azurecli-interactive
    az cosmosdb mongodb database create \
      --account-name $COSMOSDB_ACCOUNT_NAME \
      --resource-group $RESOURCE_GROUP \
      --name contoso-ship-manager
    ```

1. Verify the database was successfully created using the `az cosmosdb mongodb database list` command.

    ```azurecli-interactive
    az cosmosdb mongodb database list \
      --account-name $COSMOSDB_ACCOUNT_NAME \
      --resource-group $RESOURCE_GROUP \
      --output table
    ```

    Your output should look similar to the following example output:

    ```output
    Name                  ResourceGroup
    --------------------  ---------------
    contoso-ship-manager  rg-ship-manager
    ```

Now that you created an external state to store all the data from the ship manager application, let's create the AKS resource to store the application itself.

## Create the AKS cluster

1. For AKS, verify that the resource provider `Microsoft.ContainerService` is registered in your subscription.

    ```azurecli-interactive
    az provider show --namespace Microsoft.ContainerService --query "registrationState"
    ```

    If the output is `NotRegistered`, register the resource provider.

    ```azurecli-interactive
    az provider register --namespace Microsoft.ContainerService
    ```
1. Create a Bash variable to store the cluster name for use throughout the rest of the module.

    ```azurecli-interactive
    AKS_CLUSTER_NAME=ship-manager-cluster
    ```

1. Create an AKS cluster using the `az aks create` command.

    ```azurecli-interactive
    az aks create --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME  \
        --node-count 3 \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --enable-app-routing
    ```

    The creation process can take a few moments to complete.

    [!INCLUDE [aks-regional-quota](../../includes/aks-regional-quota.md)]

1. Download the kubectl configuration using the `az aks get-credentials` command.

   ```azurecli-interactive
   az aks get-credentials --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP
   ```

   If you receive any messages about existing clusters, for example:

   ```output
   A different object named ship-manager-cluster already exists in your kubeconfig file.
   Overwrite? (y/n):
   ```

   Enter `y` to overwrite.

1. Test the configuration using the `kubectl get nodes` command.

    ```azurecli-interactive
    kubectl get nodes
    ```

    Your output should look similar to the following example output:

    ```output
    NAME                                STATUS   ROLES    AGE    VERSION
    aks-nodepool1-12345678-vmss000000   Ready    <none>   107s   v1.33.7
    aks-nodepool1-12345678-vmss000001   Ready    <none>   104s   v1.33.7
    aks-nodepool1-12345678-vmss000002   Ready    <none>   107s   v1.33.7
    ```

## Deploy the application

To create the application, you need to create the YAML files to deploy to Kubernetes. You can create the files on your computer and then upload them to your Bash session in Cloud Shell. In the Cloud Shell session select **Manage files** > **Upload**.

### Deploy the back-end API

1. Export your Azure Cosmos DB database connection string to a variable using the `az cosmosdb keys list` command.

    ```azurecli-interactive
    export COSMOS_CONNECTION_STRING=$(az cosmosdb keys list \
      --type connection-strings \
      --resource-group $RESOURCE_GROUP \
      --name $COSMOSDB_ACCOUNT_NAME \
      --query "connectionStrings[0].connectionString" --output tsv)
    ```

   > [!IMPORTANT]
   > Don't use connection strings for a production environment because the connection string contains sensitive information. For more information, see the [security overview for Azure Cosmos DB](/azure/cosmos-db/security).

1. Create a new file named _backend-deploy.yml_ and paste in the following deployment specification:

    ```yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: ship-manager-backend
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: ship-manager-backend
      template:
        metadata:
          labels:
            app: ship-manager-backend
        spec:
          containers:
            - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:backend
              name: ship-manager-backend
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 3000
                  name: http
              env:
                - name: DATABASE_MONGODB_URI
                  value: "${COSMOS_CONNECTION_STRING}"
                - name: DATABASE_MONGODB_DBNAME
                  value: contoso-ship-manager
    ```

1. Save the file and upload it to Cloud Shell session by selecting **Manage files** > **Upload**.
1. Apply the back-end API deployment using the `kubectl apply` command.

    ```azurecli-interactive
    envsubst '${COSMOS_CONNECTION_STRING}' < backend-deploy.yml | kubectl apply -f -
    ```

    The command uses `envsubst` to replace the `${COSMOS_CONNECTION_STRING}` placeholder in the YAML file with the value of the `COSMOS_CONNECTION_STRING` environment variable. The dash (`-`) at the end of the command tells `kubectl` to read the input from the standard input stream. The value of the `COSMOS_CONNECTION_STRING` variable isn't saved to the file you uploaded to Cloud Shell.

    You should see a message similar to the following example output:

    ```output
    deployment.apps/ship-manager-backend created
    ```

To make this application available to everyone, you need to create a service and an ingress to take care of the traffic.

1. Create a new file named _backend-network.yml_ and paste in the following networking specification:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-backend
    spec:
      type: ClusterIP
      ports:
      - port: 80
        targetPort: 3000
      selector:
        app: ship-manager-backend
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-backend
    spec:
      ingressClassName: webapprouting.kubernetes.azure.com
      rules:
      - host:
        http:
          paths:
          - backend:
              service:
                name: ship-manager-backend
                port:
                  number: 80
            path: /api
            pathType: Prefix
    ```

1. Save the file and upload it to Cloud Shell session by selecting **Manage files** > **Upload**.
1. Apply the back-end networking deployment using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f backend-network.yml
    ```

    Your output should look similar to the following example output:

    ```output
    service/ship-manager-backend created
    ingress.networking.k8s.io/ship-manager-backend created
    ```

    This ingress routes requests to the back-end API on the `/api` path.

1. Check the ingress status by querying Kubernetes for the available ingresses using the `kubectl get ingress` command.

    ```azurecli-interactive
    kubectl get ingress
    ```

    Once the **ADDRESS** field in the output is filled, it means the ingress was deployed and it's ready to be accessed, as shown in the following example output:

    ```output
    NAME                   CLASS                                HOSTS   ADDRESS        PORTS   AGE
    ship-manager-backend   webapprouting.kubernetes.azure.com   *       xx.xx.xx.xx    80      2m40s
    ```

    The `HOSTS` value is `*` because this ingress doesn't specify a `host:` rule. Ingress host names are optional. When you omit `host:`, the ingress matches requests for any host name, and you access the app using the ingress **ADDRESS**.

1. Store the ingress address in a variable. You'll use it for the front-end configuration.

    ```azurecli-interactive
    export HOST_NAME=$(kubectl get ingress ship-manager-backend -o jsonpath='{.status.loadBalancer.ingress[0].ip}{.status.loadBalancer.ingress[0].hostname}')
    ```

### Deploy the front-end interface

1. Create a new file named _frontend-deploy.yml_ and paste in the following deployment specification:

    ```yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: ship-manager-frontend
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: ship-manager-frontend
      template:
        metadata:
          labels:
            app: ship-manager-frontend
        spec:
          containers:
            - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:frontend
              name: ship-manager-frontend
              imagePullPolicy: Always
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 80
              volumeMounts:
                - name: config
                  mountPath: /usr/src/app/dist/config.js
                  subPath: config.js
          volumes:
            - name: config
              configMap:
                name: frontend-config
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: frontend-config
    data:
      config.js: |
        const config = (() => {
          return {
            'VUE_APP_BACKEND_BASE_URL': 'http://${HOST_NAME}',
          }
        })()
    ```

1. Save the file and upload it to Cloud Shell session by selecting **Manage files** > **Upload**.
1. Apply the front-end deployment using the `kubectl apply` command.

    ```azurecli-interactive
    envsubst '${HOST_NAME}' < frontend-deploy.yml | kubectl apply -f -
    ```

    Your output should look similar to the following example output:

    ```output
    deployment.apps/ship-manager-frontend created
    configmap/frontend-config created
    ```

Next, you can create the networking resources that this application needs to be open to the web.

1. Create a new file named _frontend-network.yml_ and paste in the following networking specification:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-frontend
    spec:
      type: ClusterIP
      ports:
      - port: 80
        targetPort: 80
      selector:
        app: ship-manager-frontend
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-frontend
    spec:
      ingressClassName: webapprouting.kubernetes.azure.com
      rules:
      - host:
        http:
          paths:
          - backend:
              service:
                name: ship-manager-frontend
                port:
                  number: 80
            path: /
            pathType: Prefix
    ```

1. Save the file and upload it to Cloud Shell session by selecting **Manage files** > **Upload**.
1. Apply the front-end networking deployment using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f frontend-network.yml
    ```

    Your output should look similar to the following example output:

    ```output
    service/ship-manager-frontend created
    ingress.networking.k8s.io/ship-manager-frontend created
    ```

    You can access the application in your browser using `http://$HOST_NAME`. Run `echo $HOST_NAME` to display the value of the `HOST_NAME` variable.

1. Check the ingress status by querying Kubernetes for the available ingresses using the `kubectl get ingress` command.

    ```azurecli-interactive
    kubectl get ingress
    ```

    When the **ADDRESS** field in the output is filled, it means the ingress was deployed and is ready to be accessed, as shown in the following example output:

    ```output
    NAME                   CLASS                                HOSTS   ADDRESS        PORTS   AGE
    ship-manager-backend   webapprouting.kubernetes.azure.com   *       xx.xx.xx.xx    80      2m40s
    ship-manager-frontend  webapprouting.kubernetes.azure.com   *       xx.xx.xx.xx    80      100s
    ```

    You can now access the application at `http://$HOST_NAME`.

## Clear your variables

It's a good practice to clear variable values, especially when they contain sensitive data like the database connection string.

```bash
unset COSMOS_CONNECTION_STRING
```
