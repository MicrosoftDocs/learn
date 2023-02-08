Now that you understand the basic concepts of external states and how to deal with them by using Kubernetes, let's create the resources that will support the application and then create the application itself.

## Create a resource group

>[!NOTE]
> The Learn sandbox system that enables you to complete these modules without using your own subscription is currently down for maintenance. This module can still be completed using a subscription you own, but please be aware that the steps might skip some instructions necessary for you to deploy, such as logging into your subscription or cleaning up the deployment at the end of the module. Let's go!

1. Sign into [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your own subscription.

1. Select **Resource groups**.

1. Select **Create** to open the **Create a resource group** pane.

1. Enter *rg-ship-manager* for the **Resource group** name. Leave the default selections for **Subscription** and **Region**.
  
1. Select **Review + create**, and then **Create**.

## Create the state

As we described earlier, handling state in Kubernetes is possible. However, we don't recommend it because managing a highly available application state gets too difficult when you need to manage the state yourself.

To solve that problem, we'll externalize the state to an application that specializes in dealing with external state. We'll use Azure Cosmos DB.

> [!NOTE]
> Although we're creating an Azure Cosmos DB instance as part of the required resources to run the application, Azure Kubernetes Service (AKS) and Azure Cosmos DB are *not* related to one another.

1. Create Bash variables to store important information like the Azure Cosmos DB account name and the resource group name:

    ```bash
    export RESOURCE_GROUP=rg-ship-manager
    export COSMOSDB_ACCOUNT_NAME=contoso-ship-manager-$RANDOM
    ```

1. Create a new Azure Cosmos DB account:

    ```azurecli
    az cosmosdb create --name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --kind MongoDB
    ```

    The creation process can take a few moments to complete.

1. Check if the creation has finished by creating a new database and listing it:

    ```azurecli
    az cosmosdb mongodb database create --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --name contoso-ship-manager
    ```

    Then, list the databases by using the `list` command:

    ```azurecli
    az cosmosdb mongodb database list --account-name $COSMOSDB_ACCOUNT_NAME --resource-group $RESOURCE_GROUP -o table
    ```

Now that you've created an external state to store all the data from the ship manager application, let's create the AKS resource to store the application itself.

## Create the AKS cluster

Now you're going to deploy the AKS cluster so you can push your application image to the internet.

1. Create Bash variables to store important information like the cluster name and resource group name:

    ```bash
    export AKS_CLUSTER_NAME=ship-manager-cluster
    ```

1. Run the AKS creation script:

    ```azurecli
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

   ```azurecli
   az aks get-credentials --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP
   ```

   If you receive any messages about existing clusters, for example:

   ```output
   A different object named ship-manager-cluster already exists in your kubeconfig file.
    Overwrite? (y/n):
   ```

   Enter `y` to overwrite.

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
                  value: "{your database connection string}"
                - name: DATABASE_MONGODB_DBNAME
                  value: contoso-ship-manager
    ```

1. Replace the `{your database connection string}` placeholder with the actual connection string from Azure Cosmos DB. You can get this connection string through the following Azure CLI script:

    ```azurecli
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
                  value: "mongodb://YOURACCOUNTNAME:password@YOURACCOUNTNAME.documents.azure.com:PORT/?ssl=true&replicaSet=globaldb"
                - name: DATABASE_MONGODB_DBNAME
                  value: contoso-ship-manager
    ```

    > [!NOTE]
    > Don't forget to add quotes `"` to the environment variables as the connection string sometimes presents invalid YAML characters.
    > You may consider using [secrets](/training/modules/aks-secrets-configure-app/) as a secure way to store and retieve connection string in AKS.

1. Save and close the file.

1. Apply the update by using the `kubectl apply` command:

    ```bash
    kubectl apply -f backend-deploy.yaml
    ```

To make this application available to everyone, you'll need to create a service and an ingress, to take care of all traffic between the application and the world.

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
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-backend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: ship-manager-backend.{DNS_ZONE}
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: ship-manager-backend
                    port:
                        number: 80
    ```

1. Replace the `{DNS_ZONE}` placeholder with your cluster DNS zone. You can get that information by running the following AKS command:

    ```azurecli
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
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-backend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: ship-manager-backend.dnszone.location.aksapp.io
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: ship-manager-backend
                    port:
                        number: 80
    ```

1. Save and close the file.

1. Apply the update by using the `kubectl apply` command:

    ```bash
    kubectl apply -f backend-network.yaml
    ```

You can access the API through the host name that you pasted in your ingress resource. The Azure DNS zone resource can take up to five minutes to complete the DNS detection. If you can't access the API right away, wait a few minutes and try again.

You can check the status of the DNS zone by querying Kubernetes for the available ingresses, once the **ADDRESS** field is filled, it means the ingress has been deployed and it's ready to be accessed:

```bash
kubectl get ingress
```

You'll get a result similar to this:

```output
NAME                   CLASS    HOSTS                                               ADDRESS        PORTS   AGE
ship-manager-backend   <none>   ship-manager-backend.dnszone.location.aksapp.io   xx.xx.xx.xx    80      2m40s
```

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
            'VUE_APP_BACKEND_BASE_URL': 'http://{YOUR_BACKEND_URL}',
          }
        })()
    ```

    Replace the `{YOUR_BACKEND_URL}` placeholder with the URL of the back-end API that you just put in the ingress in the previous step.

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
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-frontend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-ship-manager.{DNS_ZONE}
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: ship-manager-frontend
                    port:
                        number: 80
    ```

1. Replace the `{DNS_ZONE}` placeholder with your cluster DNS zone. You can get that information by using the following AKS command:

    ```azurecli
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
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: ship-manager-frontend
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-ship-manager.dnszone.location.aksapp.io
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: ship-manager-frontend
                    port:
                        number: 80
    ```

1. Save and close the file.

1. Apply the update by using the `kubectl apply` command:

    ```bash
    kubectl apply -f frontend-network.yaml
    ```

You can access the API through the host name that you pasted in your ingress resource. The Azure DNS zone resource can take up to five minutes to complete the DNS detection. If you can't access the API right away, wait a few minutes and try again.

You can check the status of the DNS zone by querying Kubernetes for the available ingresses, once the **ADDRESS** field is filled, it means the ingress has been deployed and it's ready to be accessed:

```bash
kubectl get ingress
```

You'll get a result similar to this:

```output
NAME                   CLASS    HOSTS                                             ADDRESS        PORTS   AGE
ship-manager-frontend  <none>   contoso-ship-manager.dnszone.location.aksapp.io   xx.xx.xx.xx    80      2m40s
```

You can now access the URL from the ingress resource's host name to enter the ship manager application.
