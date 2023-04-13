The back-end part of the application is deployed and now you need to deploy the front-end portion. You already know you're going to need a ConfigMap. So let's start by creating one.

<!--

## Activate the Azure sandbox

>[!NOTE]
> The Learn sandbox system that enables you to complete these modules without using your own subscription is currently down for maintenance. This module can still be completed using a subscription you own, but please be aware that the steps might skip some instructions necessary for you to deploy, such as logging into your subscription or cleaning up the deployment at the end of the module. Let's go!

1. Start by **activating the Azure sandbox above**.

1. Once it's activated, sign in to the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

-->

## Before we start

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

Let's assume an AKS cluster is already created and running. Before creating a new cluster, run the following commands to be sure there's no other clusters or resources already created:

```azurecli-interactive
export RESOURCE_GROUP=rg-ship-manager
export CLUSTER_NAME=ship-manager-cluster
```

```azurecli-interactive
az aks show -n $CLUSTER_NAME -g $RESOURCE_GROUP
```

If the list is empty, proceed to create your AKS cluster, running the following commands in Cloud Shell:

```azurecli-interactive
az aks create \
 -g $RESOURCE_GROUP \
 -n $CLUSTER_NAME \
 --node-count 1 \
 --node-vm-size Standard_B2s \
 --generate-ssh-keys \
 --enable-addons http_application_routing
```

After the previous command runs, or if the list isn't empty (the cluster is already created), get the administration config:

```azurecli-interactive
az aks get-credentials -n $CLUSTER_NAME -g $RESOURCE_GROUP
```

The complete cluster creation can take up to five minutes.

> [!IMPORTANT]
> Make a note of the `RESOURCE_GROUP` and `CLUSTER_NAME` variables for later use.

## Create a ConfigMap

1. In your Azure Cloud Shell. Get the DNS zone that has been made available with the HTTP application routing add-on:

    ```azurecli-interactive
    az aks show \
      -g $RESOURCE_GROUP \
      -n $CLUSTER_NAME \
      -o tsv \
      --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    Copy the output. You can also use the same value from the previous Ingress you created for the back-end application.

1. Create a new file called `configmap.yaml`.

1. Open the file for changes running `code configmap.yaml`.

1. Paste the following YAML definition for the ConfigMap:

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ship-manager-config
      namespace: default
    data:
      config.js: |
        const config = (() => {
          return {
            'VUE_APP_BACKEND_BASE_URL': 'http://ship-manager-backend.{yourdns-zone}.aksapp.io',
          }
        })()
    ```

    Replace the DNS zone by the value you copied in the first step.

1. Save and close the file.

1. Apply the changes to the cluster by running `kubectl apply -f configmap.yaml`.

1. Check your work by querying the created ConfigMap:

    ```azurecli-interactive
    kubectl get configmap ship-manager-config
    ```

## Create the application

1. Create a new file called `frontend.yaml`.

1. In this file, paste the following contents:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-ship-manager-frontend
      namespace: default
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: contoso-ship-manager-frontend
      template:
        metadata:
          labels:
            app: contoso-ship-manager-frontend
        spec:
          containers:
            - image: mcr.microsoft.com/mslearn/samples/contoso-ship-manager:frontend
              name: contoso-ship-manager-frontend
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
                name: ship-manager-config
    ---
    ```

    Notice how we're mounting the ConfigMap in the Deployment object. We're not specifying any keys, which means we need to specify a `subPath` key. The `subpath` is the filename inside the container.

1. Continue to edit the file by adding the following lines below the last three dashes (`---`):

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-ship-manager-frontend
      namespace: default
    spec:
      selector:
        app: contoso-ship-manager-frontend
      ports:
        - name: http
          port: 80
          targetPort: 80
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-ship-manager-frontend
      namespace: default
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-ship-manager.{your-dns-zone}.aksapp.io
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: contoso-ship-manager-frontend
                    port: 
                      name: http
    ```

    Change the DNS zone present in the Ingress to match the DNS you copied from the first step.

1. Save and close the file.

1. Deploy the application by running the following command:

    ```bash
    kubectl apply -f frontend.yaml
    ```

1. Check your work by querying the Kubernetes API:

    ```azurecli-interactive
    kubectl get deploy contoso-ship-manager-frontend
    ```

    The DNS propagation may take up to five minutes to complete.

    When the API is available, you should get an output similar to:

    ```output
    NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-ship-manager-frontend  1/1     1            1           18s
    ```
