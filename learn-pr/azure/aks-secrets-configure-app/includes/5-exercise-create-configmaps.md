The backend part of the application is deployed and now you need to deploy the front-end bit. You already know you're going to need a ConfigMap. So let's start by creating one.

## Create a ConfigMap

1. Log in to your Azure Cloud Shell. Get the DNS zone that has been made available with the HTTP application routing add-on:

    ```azurecli-interactive
    az aks show \
      -g $RESOURCE_GROUP \
      -n $CLUSTER_NAME \
      -o tsv \
      --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    Copy the output. You can also use the same value from the previous Ingress you created for the backend application.

1. Create a new file called `configmap.yaml`.
1. Open the file for changes using `code configmap.yaml`.
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
1. Apply the changes to the cluster using `kubectl apply -f configmap.yaml`
1. Check your work by querying the created ConfigMap:

    ```azurecli-interactive
    kubectl get configmap ship-manager-config
    ```

## Create the application

1. Create a new file called `frontend.yaml`
1. In this file paste the following contents:

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

    Notice how we're mounting the ConfigMap in the Deployment object. We're not specifying any keys, which means we need to specify a `subPath` key, this is the file name inside the container.

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
                backend:
                  service:
                    name: contoso-ship-manager-frontend
                    port:
                      name: http
    ```

    Change the DNS zone present in the Ingress to match the DNS you copied from the first step.

1. Save and close the file.
1. Deploy the application by using `kubectl apply -f frontend.yaml`
1. Check your work by querying the Kubernetes API:

    ```azurecli-interactive
    kubectl get deploy contoso-ship-manager-frontend
    ```

    The DNS propagation may take up to five minutes to complete. Check the DNS creation using the following command:

    ```azurecli-interactive
    az network dns zone list -o table
    ```

    Check if there are two new records with the same DNS zone but starting with `contoso-ship-manager`.
