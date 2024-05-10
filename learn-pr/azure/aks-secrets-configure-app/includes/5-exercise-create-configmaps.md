You deployed the application back end, and now you need to deploy the application front end using a ConfigMap.

<!--

## Activate the Azure sandbox

>[!NOTE]
> The Learn sandbox system that enables you to complete these modules without using your own subscription is currently down for maintenance. This module can still be completed using a subscription you own, but please be aware that the steps might skip some instructions necessary for you to deploy, such as logging into your subscription or cleaning up the deployment at the end of the module. Let's go!

1. Start by **activating the Azure sandbox above**.

1. Once it's activated, sign in to the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

-->

## Before we start

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

## Create a ConfigMap

1. Create a new YAML file named `configmap.yaml` and paste in the following code to create the ConfigMap spec:

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
            'VUE_APP_BACKEND_BASE_URL': 'http://ship-manager-backend.{your-dns-zone}.aksapp.io',
          }
        })()
    ```

1. Replace `{your-dns-zone}` with the value of the ZONE_NAME variable you created earlier.

1. Save and close the file.

1. Apply the changes to your cluster using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f configmap.yaml
    ```

1. Check the result by querying for the ConfigMap using the `kubectl get configmap` command.

    ```azurecli-interactive
    kubectl get configmap ship-manager-config
    ```

## Create the application

1. Create a new YAML file named `frontend.yaml` and paste in the following code to create the Deployment spec:

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

    Notice how the ConfigMap is mounted in the Deployment object. We don't specify any keys, which means we need to specify a `subPath` key. The `subpath` is the filename inside the container.

1. Below the three dashes, paste in the following code to create the Service and Ingress specs:

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
        spec.ingressClassName: webapprouting.kubernetes.azure.com
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

1. Replace `{your-dns-zone}` in the Ingress with the value of the ZONE_NAME variable you created earlier.

1. Save and close the file.

1. Deploy the application using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f frontend.yaml
    ```

1. Check the result by querying the Kubernetes API using the `kubectl get deployment` command.

    ```azurecli-interactive
    kubectl get deployment contoso-ship-manager-frontend
    ```

    When the API is available, you should get an output similar to the following example:

    ```output
    NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-ship-manager-frontend  1/1     1            1           18s
    ```
