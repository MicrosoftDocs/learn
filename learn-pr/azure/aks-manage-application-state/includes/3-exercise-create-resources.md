Now that we've reviewed the basic concepts of external states and how to deal with them using Kubernetes, let's create the resources that will support your freight company's application and then create the application itself.

## Create a resource group

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign into [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your own subscription.
2. Open the Cloud Shell and select **Bash**.
3. Create an Azure resource group using the `az group create` command and specify a region. This example creates a resource group named *rg-ship-manager* in the *eastus* region:

    ```azurecli-interactive
    az group create --name rg-ship-manager --location eastus
    ```

    The creation process can take a few moments to complete.

## Create the state

As we described earlier, it's possible but not recommended to handle state in Kubernetes. Managing a highly available application state can become too difficult when you need to manage the state yourself.

To solve that problem, we'll externalize the state to an application that specializes in dealing with external state: Azure Cosmos DB.

> [!NOTE]
> Although we're creating an Azure Cosmos DB instance as part of the required resources to run the application, Azure Kubernetes Service (AKS) and Azure Cosmos DB are *not* related to one another.

1. Create Bash variables to store the Azure Cosmos DB account name and the resource group name for use throughout the rest of the module.

    ```azurecli-interactive
    export RESOURCE_GROUP=rg-ship-manager
    export COSMOSDB_ACCOUNT_NAME=contoso-ship-manager-$RANDOM
    ```

2. Create a new Azure Cosmos DB account using the `az cosmosdb create` command.

    ```azurecli-interactive
    az cosmosdb create --name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --kind MongoDB
    ```

    The creation process can take a few moments to complete.

3. Create a new database using the `az cosmosdb mongodb database create` command. In this example, the database is named *contoso-ship-manager*.

    ```azurecli-interactive
    az cosmosdb mongodb database create --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --name contoso-ship-manager
    ```

4. Verify the database was successfully created using the `az cosmosdb mongodb database list` command.

    ```azurecli-interactive
    az cosmosdb mongodb database list --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP -o table
    ```

    Your output should look similar to the following example output:

    ```output
    Name                  ResourceGroup
    --------------------  ---------------
    contoso-ship-manager  rg-ship-manager
    ```

Now that you've created an external state to store all the data from the ship manager application, let's create the AKS resource to store the application itself.

## Create the AKS cluster

1. Create a Bash variable to store the cluster name for use throughout the rest of the module.

    ```azurecli-interactive
    AKS_CLUSTER_NAME=ship-manager-cluster
    ```

2. Create an AKS cluster using the `az aks create` command.

    ```azurecli-interactive
    az aks create --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME  \
        --node-count 3 \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --enable-addons http_application_routing
    ```

    The creation process can take a few moments to complete.

    [!INCLUDE [aks-regional-quota](../../includes/aks-regional-quota.md)]

4. Download the kubectl configuration using the `az aks get-credentials` command.

   ```azurecli-interactive
   az aks get-credentials --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP
   ```

   If you receive any messages about existing clusters, for example:

   ```output
   A different object named ship-manager-cluster already exists in your kubeconfig file.
   Overwrite? (y/n):
   ```

   Enter `y` to overwrite.

5. Test the configuration using the `kubectl get nodes` command.

    ```azurecli-interactive
    kubectl get nodes
    ```

    Your output should look similar to the following example output:

    ```output
    NAME                                STATUS   ROLES   AGE     VERSION
    aks-nodepool1-12345678-vmss000000   Ready    agent   3m19s   v1.27.7
    aks-nodepool1-12345678-vmss000001   Ready    agent   3m25s   v1.27.7
    aks-nodepool1-12345678-vmss000002   Ready    agent   3m20s   v1.27.7
    ```

## Deploy the application

To create the application, you need to create the YAML files to deploy to Kubernetes.

### Deploy the back-end API

1. Get your Azure Cosmos DB database connection string using the `az cosmosdb keys list` command.

    ```azurecli-interactive
    az cosmosdb keys list --type connection-strings -g $RESOURCE_GROUP -n $COSMOSDB_ACCOUNT_NAME --query "connectionStrings[0].connectionString" -o tsv
    ```

    Your output should look similar to the following example output:

    ```output
    mongodb://contoso-ship-manager-12345678.documents.azure.com:10255/?ssl=true&replicaSet=globaldb
    ```

2. Create a new file named *backend-deploy.yml* and paste in the following deployment specification:

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
                  value: "{your database connection string}"
                - name: DATABASE_MONGODB_DBNAME
                  value: contoso-ship-manager
    ```

3. Replace the `{your database connection string}` placeholder with the database connection string you retrieved in the previous step.

    > [!NOTE]
    > Don't forget to add quotes `"` to the environment variables, as the connection string sometimes presents invalid YAML characters.
    > You might consider using [secrets](/training/modules/aks-secrets-configure-app/) as a secure way to store and retrieve connection string in AKS.

4. Save and close the file.
5. Apply the back-end API deployment using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f backend-deploy.yml
    ```

    You should see a message similar to the following example output:

    ```output
    deployment.apps/ship-manager-backend created
    ```

To make this application available to everyone, you need to create a service and an ingress to take care of the traffic.

1. Get your cluster API server address using the `az aks show` command.

    ```azurecli-interactive
    az aks show -g $RESOURCE_GROUP -n $AKS_CLUSTER_NAME -o tsv --query fqdn
    ```

    Your output should look similar to the following example output:

    ```output
    ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io
    ```

2. Create a new file named *backend-network.yml* and paste in the following networking specification:

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
      - host: <host-name>
        http:
          paths:
          - backend:
              service:
                name: ship-manager-backend
                port:
                  number: 80
            path: /
            pathType: Prefix
    ```

3. Replace the `<host-name>` placeholder with the connection string you retrieved in the previous step.
4. Save and close the file.
5. Apply the back-end networking deployment using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f backend-network.yml
    ```

    Your output should look similar to the following example output:

    ```output
    service/ship-manager-backend created
    ingress.networking.k8s.io/ship-manager-backend created
    ```

    You can access the API through the host name that you pasted in your ingress resource. The Azure DNS zone resource can take up to five minutes to complete the DNS detection. If you can't access the API right away, wait a few minutes and try again.

6. Check the ingress status by querying Kubernetes for the available ingresses using the `kubectl get ingress` command.

    ```azurecli-interactive
    kubectl get ingress
    ```

    Once the **ADDRESS** field in the output is filled, it means the ingress has been deployed and it's ready to be accessed, as shown in the following example output:

    ```output
    NAME                   CLASS                                HOSTS                                                               ADDRESS        PORTS   AGE
    ship-manager-backend   webapprouting.kubernetes.azure.com   ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io     xx.xx.xx.xx    80      2m40s
    ```

### Deploy the front-end interface

1. Create a new file named *frontend-deploy.yml* and paste in the following deployment specification:

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
            'VUE_APP_BACKEND_BASE_URL': 'http://{YOUR_BACKEND_URL}',
          }
        })()
    ```

2. Replace the `{YOUR_BACKEND_URL}` placeholder with the host name URL of the back-end API that you retrieved in the previous section.
3. Save and close the file.
4. Apply the front-end deployment using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f frontend-deploy.yml
    ```

    Your output should look similar to the following example output:

    ```output
    deployment.apps/ship-manager-frontend created
    configmap/frontend-config created
    ```

Next, you can create the networking resources that this application needs to be open to the web.

1. Create a new file named *frontend-network.yml* and paste in the following networking specification:

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
      - host: <host-name>
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

2. Replace the `<host-name>` placeholder with the connection string you retrieved in the previous section.
3. Save and close the file.
4. Apply the front-end networking deployment using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f frontend-network.yml
    ```

    Your output should look similar to the following example output:

    ```output
    service/ship-manager-frontend created
    ingress.networking.k8s.io/ship-manager-frontend created
    ```

    You can access the API through the host name that you pasted in your ingress resource. The Azure DNS zone resource can take up to five minutes to complete the DNS detection. If you can't access the API right away, wait a few minutes and try again.

5. Check the ingress status by querying Kubernetes for the available ingresses using the `kubectl get ingress` command.

    ```azurecli-interactive
    kubectl get ingress
    ```

    Once the **ADDRESS** field in the output is filled, it means the ingress has been deployed and it's ready to be accessed, as shown in the following example output:

    ```output
    NAME                   CLASS                                HOSTS                                                               ADDRESS        PORTS   AGE
    ship-manager-backend   webapprouting.kubernetes.azure.com   ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io     xx.xx.xx.xx    80      2m40s
    ship-manager-frontend  webapprouting.kubernetes.azure.com   ship-manag-rg-ship-manager-a1bcd2-efghij56.hcp.eastus.azmk8s.io     xx.xx.xx.xx    80      100s
    ```

You can now access the URL from the ingress resource's host name to enter the ship manager application.
