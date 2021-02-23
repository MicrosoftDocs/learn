Now that you understand the basic concepts of external states and how to deal with them by using Kubernetes, let's create the resources that will support the application and then create the application itself.

## Create the state

As we described earlier, handling state in Kubernetes is possible. However, we don't recommend it because managing a highly available application state gets too difficult when you need to manage the state yourself.

To solve that problem, we'll externalize the state to an application that specializes in dealing with external state. We'll use Azure Cosmos DB.

> [!NOTE]
> Although we're creating an Azure Cosmos DB instance as part of the required resources to run the application, Azure Kubernetes Service (AKS) and Azure Cosmos DB are *not* related to one another.

To create a new Azure Cosmos DB instance, we'll use the Azure CLI. You can install the Azure CLI on your local machine, or you can use Azure Cloud Shell to access your subscription.

1. Sign in to Azure Cloud Shell by using the account where you want to deploy resources:

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash. If you haven't opened Cloud Shell yet, select **Bash** as the running shell.

1. Create Bash variables to store important information like the account name and resource group name:

    ```bash
    RESOURCE_GROUP=rg-ship-manager
    COSMOSDB_ACCOUNT_NAME=contoso-ship-manager-$RANDOM
    ```

1. Create a new resource group where you'll store all the resources related to this application:

    ```azurecli-interactive
    az group create -n $RESOURCE_GROUP -l eastus
    ```

1. Create a new Azure Cosmos DB account:

    ```azurecli-interactive
    az cosmosdb create --name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --kind MongoDB
    ```

    The creation process can take a few moments to complete.

1. Check if the creation has finished by creating a new database and listing it:

    ```azurecli-interactive
    az cosmosdb mongodb database create --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --name contoso-ship-manager
    ```

    Then, list the databases by using the `list` command:

    ```azurecli-interactive
    az cosmosdb mongodb database list --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP -o table
    ```

Now that you've created an external state to store all the data from the ship manager application, let's create the AKS resource to store the application itself.

## Create the AKS cluster

Now you're going to deploy the AKS cluster so you can push your application image to the internet.

1. Sign in to Azure Cloud Shell by using the account where you want to deploy resources:

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash. If you haven't opened Cloud Shell yet, select **Bash** as the running shell.

1. Create Bash variables to store important information like the cluster name and resource group name:

    ```bash
    RESOURCE_GROUP=rg-ship-manager
    AKS_CLUSTER_NAME=ship-manager-cluster
    ```

1. Run the AKS creation script:

    ```azurecli-interactive
    az aks create --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME  \
        --node-count 3 \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --enable-managed-identity \
        --location eastus \
        --enable-addons http_application_routing
    ```

    The script can take a while to create the resources.

1. Download the kubectl configuration:

    ```azurecli-interactive
    az aks get-credentials --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

1. Test the configuration:

    ```bash
    kubectl get nodes
    ```

## Deploy the application

To create the application, you'll need to create the YAML files that will be deployed to Kubernetes.

### Deploy the back-end API

You need to create three main files. Let's start by creating the *deploy.yaml* file for the back end.

1. Create a new file called *backend-deploy.yaml*, and then open it in your favorite editor.

1. In this file, you'll write the following deployment specification:

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
                  value: <your database connection string>
                - name: DATABASE_MONGODB_DBNAME
                  value: ship_manager
    ```

1. Replace the `<your database connection string>` tag with the actual connection string from Azure Cosmos DB. You can get this connection string through the following Azure CLI script:

    ```azurecli-interactive
    az cosmosdb keys list --type connection-strings -g $RESOURCE_GROUP -n $COSMOSDB_ACCOUNT_NAME --query "connectionStrings[0].connectionString" -o tsv
    ```

    Copy and paste it within the .yaml file to make it similar to the following code:

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
                  value: mongodb://YOURACCOUNTNAME:password@YOURACCOUNTNAME.documents.azure.com:PORT/?ssl=true&replicaSet=globaldb
                - name: DATABASE_MONGODB_DBNAME
                  value: ship_manager
    ```

1. Save and close the file.

1. Apply the update by using the `kubectl apply` command:

    ```bash
    kubectl apply -f backend-deploy.yaml
    ```

To make this application available to everyone, you'll need to create a service and an ingress to take care of all traffic between the application and the world.

1. Create a new file called *backend-network.yaml*, and add the following .yaml notation:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-backend
    spec:
      selector:
        app: ship-manager-backend
      ports:
        - name: http
          port: 80
          targetPort: 3000
    ---
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: ship-manager-backend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: ship-manager-backend.DNS_ZONE
          http:
            paths:
              - path: /
                backend:
                  serviceName: ship-manager-backend
                  servicePort: http
    ```

1. Replace the `DNS_ZONE` placeholder with your cluster DNS zone. You can get that information by running the following AKS command:

    ```azurecli-interactive
    az aks show -g $RESOURCE_GROUP -n $AKS_CLUSTER_NAME -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    You'll end up with a network file that's similar to this:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-backend
    spec:
      selector:
        app: ship-manager-backend
      ports:
        - name: http
          port: 80
          targetPort: 3000
    ---
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: ship-manager-backend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: ship-manager-backend.somedns.location.aksapp.io
          http:
            paths:
              - path: /
                backend:
                  serviceName: ship-manager-backend
                  servicePort: http
    ```

1. Save and close the file.

1. Apply the update by using the `kubectl apply` command:

    ```bash
    kubectl apply -f backend-network.yaml
    ```

You can access the API through the host name that you pasted in your ingress resource. The Azure DNS zone resource can take up to five minutes to complete the DNS detection. If you can't access the API right away, wait a few minutes and try again.

You can check the status of the DNS zone by going to the Azure portal, entering the resource group that starts with **MC_**, and selecting the **DNS Zone** resource. When the API is online, you should see four zone records.

### Deploy the front-end interface

To create the front-end interface, you'll do a similar process:

1. Create a new file called *frontend-deploy.yaml*.

1. Open this file in your favorite editor, and paste the following specification:

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
                  name: http
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
            'VUE_APP_BACKEND_BASE_URL': 'YOUR_BACKEND_URL',
          }
        })()
    ```

    Replace the `YOUR_BACKEND_URL` placeholder with the URL of the back-end API that you just put in the ingress in the previous step.

1. Save and close the file.

1. Apply the template by using `kubectl apply`:

    ```bash
    kubectl apply -f frontend-deploy.yaml
    ```

Next, you'll create the networking resources that this application needs to be open to the web.

1. Create a new file called *frontend-network.yaml*, and add the following .yaml notation:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-frontend
    spec:
      selector:
        app: ship-manager-frontend
      ports:
        - name: http
          port: 80
          targetPort: 80
    ---
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: ship-manager-frontend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-ship-manager.DNS_ZONE
          http:
            paths:
              - path: /
                backend:
                  serviceName: ship-manager-frontend
                  servicePort: http
    ```

1. Replace the `DNS_ZONE` placeholder with your cluster DNS zone. You can get that information by using the following AKS command:

    ```azurecli-interactive
    az aks show -g $RESOURCE_GROUP -n $AKS_CLUSTER_NAME -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    You'll end up with a network file that's similar to this:

    ```yml
    apiVersion: v1
    kind: Service
    metadata:
      name: ship-manager-frontend
    spec:
      selector:
        app: ship-manager-frontend
      ports:
        - name: http
          port: 80
          targetPort: 80
    ---
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: ship-manager-frontend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-ship-manager.some-zone.eastus.aksapp.io
          http:
            paths:
              - path: /
                backend:
                  serviceName: ship-manager-frontend
                  servicePort: http
    ```

1. Save and close the file.

1. Apply the update by using the `kubectl apply` command:

    ```bash
    kubectl apply -f frontend-network.yaml
    ```

You can access the API through the host name that you pasted in your ingress resource. The Azure DNS zone resource can take up to five minutes to complete the DNS detection. If you can't access the API right away, wait a few minutes and try again.

You can check the status of the DNS zone by going to the Azure portal, entering the resource group that starts with **MC_**, and selecting the **DNS Zone** resource. When the API is online, you should see four zone records.

You can now access the URL from the ingress resource's host name to enter the ship manager application.
