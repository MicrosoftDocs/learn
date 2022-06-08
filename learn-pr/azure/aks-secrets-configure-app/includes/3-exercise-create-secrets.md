<!--

As we mentioned in the ["Before We Start"](/learn/modules/aks-secrets-configure-app/1-introduction) exercise, we'll assume an AKS cluster has already been created. So, you'll create the needed resources to support the application's backend.

## Activate the Azure sandbox

>[!NOTE]
> The Learn sandbox system that enables you to complete these modules without using your own subscription is currently down for maintenance. This module can still be completed using a subscription you own, but please be aware that the steps might skip some instructions necessary for you to deploy, such as logging into your subscription or cleaning up the deployment at the end of the module. Let's go!

1. Start by **activating the Azure sandbox.**

1. When the sandbox is activated, sign in to the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

-->

## Before we start

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

Before creating a new cluster, run the following commands to create a resource group. Update the LOCATION variable with the region closest to you; for example, `eastus`:

```azurecli-interactive
export RESOURCE_GROUP=rg-ship-manager
export CLUSTER_NAME=ship-manager-cluster
export LOCATION={location}
az group create --location $LOCATION --name $RESOURCE_GROUP
```

Then, create your AKS cluster by running the following command in a Cloud Shell environment:

```azurecli-interactive
az aks create \
 -g $RESOURCE_GROUP \
 -n $CLUSTER_NAME \
 --node-count 1 \
 --node-vm-size Standard_B2s \
 --generate-ssh-keys \
 --enable-addons http_application_routing
```

After your cluster is created, get the administration config:

```azurecli-interactive
az aks get-credentials -n $CLUSTER_NAME -g $RESOURCE_GROUP
```

The complete cluster creation can take up to five minutes.

> [!IMPORTANT]
> Make a note of the `RESOURCE_GROUP` and `CLUSTER_NAME` variables for later use.

## Create the Secret

According to the [application documentation](https://github.com/Azure-Samples/aks-contoso-ships-sample/tree/main/kubernetes), there are two parts of this application: the front end, and the back end. Only the back end will need to use a Secret, because it has the MongoDB connection string as an environment variable.

1. The first step is to deploy a MongoDB database to support this application by using CosmosDB:

    ```azurecli-interactive
    export DATABASE_NAME=contoso-ship-manager-$RANDOM && \
    az cosmosdb create \
     -n $DATABASE_NAME \
     -g $RESOURCE_GROUP \
     --kind MongoDB \
     --enable-free-tier
    ```

    The database creation can take up to three minutes. Once the database is created, fetch the connection string:

    ```azurecli-interactive
    az cosmosdb keys list \
      --type connection-strings \
      -g $RESOURCE_GROUP \
      -n $DATABASE_NAME \
      -o tsv \
      --query "connectionStrings[0].connectionString"
    ```

    Copy the output value.

1. Create a new file called `backend-secret.yaml`.

    ```bash
    touch backend-secret.yaml
    ```

1. Enter the following command to open the file in the editor. 

    ```bash
    code backend-secret.yaml
    ```

1. Add the following code to this file to create the Secret spec. Be sure to replace the placeholder string with the connection string.

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

1. Apply the secret by running the `kubectl apply` command:

    ```azurecli-interactive
    kubectl apply -f backend-secret.yaml
    ```

1. Check the result of your work by querying the secret:

    ```azurecli-interactive
    kubectl get secret ship-manager-database
    ```

    You should get an output similar to:

    ```output
    NAME                    TYPE     DATA   AGE
    ship-manager-database   Opaque   1      5s
    ```

## Create the application

Let's create the application and apply the secret to this application.

1. Get the DNS zone that has been made available with the HTTP application routing add-on:

    ```azurecli-interactive
    az aks show \
      -g $RESOURCE_GROUP \
      -n $CLUSTER_NAME \
      -o tsv \
      --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    Copy the output value for later use.

1. Create a new file called `backend-application.yaml` and open it in the editor.

    ```bash
    touch backend-application.yaml
    code backend-application.yaml
    ```

1. Create the Deployment specification by adding the following code to the file:

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

    Notice that we're using the `valueFrom` and then `secretKeyRef` keys in the `env` section. The order of these keys is telling the deployment that we'll use the value from the `key` present in the Secret defined in the `name` key.

1. Add three dashes below the last line to separate the Deployment from the Service you're about to create.

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

1. Let's add the Ingress so that we can access the application. Below the last three dashes, add the following code:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-backend
      namespace: default
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: ship-manager-backend.<paste the DNS ZONE here>
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

1. Save and close the file.

1. Apply the changes by running the following command:

    ```bash
    kubectl apply -f backend-application.yaml
    ```

    The changes can take up to five minutes to propagate.
