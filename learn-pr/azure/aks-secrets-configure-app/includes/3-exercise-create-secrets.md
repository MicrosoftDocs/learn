<!--

As we mentioned in the ["Before We Start"](/learn/modules/aks-secrets-configure-app/1-introduction) exercise, we'll assume an AKS cluster has already been created. So, you'll create the needed resources to support the application's backend.

## Activate the Azure sandbox

>[!NOTE]
> The Learn sandbox system that enables you to complete these modules without using your own subscription is currently down for maintenance. This module can still be completed using a subscription you own, but please be aware that the steps might skip some instructions necessary for you to deploy, such as logging into your subscription or cleaning up the deployment at the end of the module. Let's go!

1. Start by **activating the Azure sandbox.**

1. When the sandbox is activated, sign in to the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

-->

## Create a resource group and AKS cluster

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

1. Create environment variables for your resource group, cluster, DNS zone, and location. Make sure you update the LOCATION variable with the region closest to you, for example, `eastus`.

    ```azurecli-interactive
    export RESOURCE_GROUP=rg-ship-manager
    export CLUSTER_NAME=ship-manager-cluster
    export ZONE_NAME=ship-$RANDOM.com
    export LOCATION={location}
    ```

1. Run the following command to view the values of your environment variables and make a note of them for later use.

    ```azurecli-interactive
    echo "RESOURCE_GROUP:" $RESOURCE_GROUP
    echo "CLUSTER_NAME:"$CLUSTER_NAME
    echo "ZONE_NAME:" $ZONE_NAME
    echo "LOCATION:"$LOCATION
    ```

1. Create a resource group using the `az group create` command.

    ```azurecli-interactive
    az group create --location $LOCATION --name $RESOURCE_GROUP
    ```

1. Create an AKS cluster using the `az aks create` command.

    ```azurecli-interactive
    az aks create \
     -g $RESOURCE_GROUP \
     -n $CLUSTER_NAME \
     --location $LOCATION \
     --node-count 1 \
     --node-vm-size Standard_B2s \
     --generate-ssh-keys
    ```

1. Enable the application routing add-on with the following command.

   ```azurecli-interactive
   az aks approuting enable -g $RESOURCE_GROUP -n $CLUSTER_NAME
   ```

   > [!NOTE]
   > If you see a message asking you to install the **aks-preview** extension, enter `Y` to install it and continue.

1. Create a DNS zone using the `az network dns zone create` command.

   ```azurecli-interactive
   az network dns zone create -g $RESOURCE_GROUP -n $ZONE_NAME
   ```

1. Retrieve the ID of your DNS zone and use it as part of the command to add the zone to your cluster for app routing.

   ```azurecli-interactive
   ZONEID=$(az network dns zone show -g $RESOURCE_GROUP -n $ZONE_NAME --query "id" --output tsv)
   az aks approuting zone add -g $RESOURCE_GROUP -n $CLUSTER_NAME --ids=${ZONEID} --attach-zones
   ```

1. Get the credentials for your cluster using the `az aks get-credentials` command.

    ```azurecli-interactive
    az aks get-credentials -n $CLUSTER_NAME -g $RESOURCE_GROUP
    ```

## Create a Secret

> [!NOTE]
> In the [application documentation](https://github.com/Azure-Samples/aks-contoso-ships-sample/tree/main/kubernetes), you can see this application has two parts: the front end and the back end. Only the back end needs to use a Secret, because it has the MongoDB connection string as an environment variable.

1. Deploy a MongoDB database to support the application using the `az cosmosdb create` command.

    ```azurecli-interactive
    export DATABASE_NAME=contoso-ship-manager-$RANDOM && \
    az cosmosdb create \
     -n $DATABASE_NAME \
     -g $RESOURCE_GROUP \
     --kind MongoDB
    ```

1. Once the database is created, get the connection string using the `az cosmosdb keys list` command and copy the output value.

    ```azurecli-interactive
    az cosmosdb keys list \
      --type connection-strings \
      -g $RESOURCE_GROUP \
      -n $DATABASE_NAME \
      -o tsv \
      --query "connectionStrings[0].connectionString"
    ```

1. Create a new YAML file named `backend-secret.yaml` and paste in the following code to create the Secret spec. Make sure to replace the placeholder string with the connection string from the previous output.

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: ship-manager-database
      namespace: default
    type: Opaque
    stringData:
      database_mongodb_uri: "<paste the connection string here>"
    ```

1. Save and close the file.

1. Apply the secret using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f backend-secret.yaml
    ```

1. Check the result by querying for the secret using the `kubectl get secret` command.

    ```azurecli-interactive
    kubectl get secret ship-manager-database
    ```

    You should get an output similar to the following example:

    ```output
    NAME                    TYPE     DATA   AGE
    ship-manager-database   Opaque   1      5s
    ```

## Create the application

1. Create a new YAML file named `backend-application.yaml` and paste in the following code to create the Deployment spec.
  
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: ship-manager-backend
      namespace: default
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
              ports:
                - containerPort: 3000
                  name: http
              env:
                - name: DATABASE_MONGODB_URI
                  valueFrom:
                    secretKeyRef:
                      key: database_mongodb_uri
                      name: ship-manager-database
                - name: DATABASE_MONGODB_DBNAME
                  value: ship_manager
    ```

    Notice that in the `env` section, we use the `valueFrom` and the `secretKeyRef` keys. The order of these keys tells the deployment to use the value from the `key` present in the Secret defined in the `name` key.

1. Add three dashes below the last line in the `backend-application.yaml` file to separate the next section.

    ```yaml
    # Previous lines from the deployment
    value: ship_manager
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-backend
      namespace: default
    spec:
      selector:
        app: ship-manager-backend
      ports:
        - name: http
          port: 80
          targetPort: 3000
    ---
    ```

1. Below the three dashes, paste in the following code to create the Ingress spec.

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-backend
      namespace: default
      annotations:
        spec.ingressClassName: webapprouting.kubernetes.azure.com
    spec:
      rules:
        - host: ship-manager-backend.<paste the ZONE_NAME here>
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: ship-manager-backend
                    port:
                      name: http
    ```

1. Change the DNS zone in the `host:` to match the name of your DNS zone. Use the value of the ZONE_NAME variable you created earlier.

1. Save and close the file.

1. Apply the changes to your cluster using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f backend-application.yaml
    ```
