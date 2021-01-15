As we previously mentioned in the ["Before We Start"](https://docs.microsoft.com/learn/modules/aks-secrets-configure-app/1-introduction) step, we'll assume there's an AKS cluster already created. So now you'll create the needed resources to support the application's backend.

## Create the Secret

According to the [application documentation](https://github.com/Azure-Samples/aks-contoso-ships-sample/tree/main/kubernetes), there are two parts of this application, the frontend and the backend. Only the backend will need to use a Secret as it has the MongoDB connection string as an environment variable.

1. The first step is to deploy a MongoDB database to support this application; for that you'll use CosmosDB:

    ```azurecli-interactive
    DATABASE_NAME=contoso-ship-manager-$RANDOM
    az cosmosdb create \
     -n $DATABASE_NAME \
     -g $RESOURCE_GROUP \
     --kind MongoDB \
     --enable-free-tier
    ```

    The database creation can take up to three minutes. Once the database is created, you'll fetch the connection string:

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

1. Use `code backend-secret.yaml` to open the editor and edit the file. In this file you'll create the Secret spec.

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

    Save and close the file.

1. Apply the secret using the `kubectl apply command`:

    ```azurecli-interactive
    kubectl apply -f backend-secret.yaml
    ```

1. Check the result of your work by querying the secret:

    ```azurecli-interactive
    kubectl get secret ship-manager-database
    ```

    You should get an output similar to the following:

    ```output
    NAME                    TYPE     DATA   AGE
    ship-manager-database   Opaque   1      5s
    ```

## Create the application

Now it's time to create the application and apply the secret to this application.

1. Get the DNS zone that has been made available with the HTTP application routing add-on:

    ```azurecli-interactive
    az aks show \
      -g $RESOURCE_GROUP \
      -n $CLUSTER_NAME \
      -o tsv \
      --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    Copy the output value for later use.

1. Create a new file called `backend-application.yaml`.
1. Open the file using `code backend-application.yaml`.
1. Create the Deployment specification as follows:

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

    Notice that we're using the `valueFrom` and then `secretKeyRef` keys in the `env` section. This is telling the deployment that we'll use the value from the `key` present in the Secret defined in the `name` key.

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

1. Let's add the Ingress so we can access the application, below the last three dashes, add the following YAML:

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
                backend:
                  service:
                    name: ship-manager-backend
                    port:
                      name: http
    ```

1. Save and close the file.
1. Apply the changes using `kubectl apply -f backend-application.yaml`

    The changes can take up to five minutes to propagate, check the DNS creation using the following command:

    ```azurecli-interactive
    az network dns zone list -o table
    ```

    Check if there are two new records with the same DNS zone but starting with `ship-manager-backend`.
