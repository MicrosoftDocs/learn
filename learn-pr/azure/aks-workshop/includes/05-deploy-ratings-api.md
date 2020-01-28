The ratings API is a Node.js application written using the Express framework. It stores and retrieves items and their ratings in a MongoDB.

Recall that we've already created an Azure Container Registry and used it to build a Docker image of the API and store it in a repository.

In this exercise, we're going to deploy that Docker image of the API to the Azure Kubernetes Service (AKS) by creating a Kubernetes [deployment](https://docs.microsoft.com/azure/aks/concepts-clusters-workloads#deployments-and-yaml-manifests?azure-portal=true), and expose it through a load balancer by creating a Kubernetes [service](https://docs.microsoft.com/azure/aks/concepts-network#services?azure-portal=true). Additionally, we're going to configure the API to connect to the MongoDB database by attaching the Kubernetes [secret](https://docs.microsoft.com/azure/aks/concepts-security#kubernetes-secrets?azure-portal=true).

By the end of this unit, we'll have the ratings API deployed and configured to communicate with MongoDB.

![Deployed resources on the Azure Kubernetes Service cluster](../media/05-arch-2.svg)

> [!TIP]
> Azure Cloud Shell includes an [integrated file editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor). The Cloud Shell editor supports features such as language highlighting, the command palette, and a file explorer. For simple file creation and editing, launch the editor by running `code .` in the Cloud Shell terminal. This action opens the editor with your active working directory set in the terminal. To directly open a file for quick editing, run `code <filename>` to open the editor without the file explorer. To open the editor via UI button, click the `{}` editor icon from the toolbar. This will open the editor and default the file explorer to the `/home/<user>` directory.

## Create a Kubernetes deployment file for the ratings API

1. Create a file called `ratings-api-deployment.yaml` using the integrated editor.

    ```bash
    code ratings-api-deployment.yaml
    ```

1. Paste the following text in the file.

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: ratings-api
    spec:
      selector:
        matchLabels:
          app: ratings-api
      template:
        metadata:
          labels:
            app: ratings-api # the label for the pods and the deployments
        spec:
          containers:
          - name: ratings-api
            image: <acrname>.azurecr.io/ratings-api:v1 # IMPORTANT: update with your own repository
            imagePullPolicy: Always
            ports:
            - containerPort: 3000 # the application listens to this port
            env:
            - name: MONGODB_URI # the application expects to find the MongoDB connection details in this environment variable
              valueFrom:
                secretKeyRef:
                  name: mongosecret # the name of the Kubernetes secret containing the data
                  key: MONGOCONNECTION # the key inside the Kubernetes secret containing the data
            resources:
              requests: # minimum resources required
                cpu: 250m
                memory: 64Mi
              limits: # maximum resources allocated
                cpu: 500m
                memory: 256Mi
            readinessProbe: # is the container ready to receive traffic?
              httpGet:
                port: 3000
                path: /healthz
            livenessProbe: # is the container healthy?
              httpGet:
                port: 3000
                path: /healthz
    ```

    In this file, update the `<acrname>` value in the `image` key with the name of our Azure Container Registry instance.

1. Review the file, and note the following points:

    - **Image**

        We'll create a deployment with two replicas running the image we pushed to the Azure Container Registry we created previously, for example, **`acr4229.azurecr.io/ratings-api:v1`**. The container listens to port **3000**. The deployment and the pods are going to be labeled with **app=ratings-api**.

    - **Environment variables and secrets**

        The ratings API expects to find the connection details to the MongoDB in an environment variable named **MONGODB_URI**. By using `valueFrom` and `secretRef`, we can reference values stored in the Kubernetes secret **mongosecret** created when we deployed MongoDB.

    - **Resource requests and limits**

        Each container instance will be allocated a minimum of **0.25 cores** and **64 Mb of memory**. The Kubernetes Scheduler will look for a node with available capacity to schedule such pod. A Container may or may not be allowed to exceed its CPU limit for extended periods. However, it won't be killed for excessive CPU usage. If a container exceeds its memory limit, it could be terminated.

    - **Readiness and liveness probes**

        The application exposes a health check endpoint at **/healthz**. If the API is unable to connect to MongoDB, the health check endpoint will return a failure. We can use these probes to configure Kubernetes and check whether the container is healthy and ready to receive traffic.

1. To save and close the editor, open the ``...`` action panel in the top right of the editor and select **Save**, then select **Close editor**. We can also use <kbd>Ctrl-s</kbd> to save, and <kbd>Ctrl-q</kbd> to close the editor.

## Apply the Kubernetes deployment file

1. Apply the configuration using the `kubectl apply` command. We'll deploy the service in the **ratingsapp** namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-api-deployment.yaml
    ```

    We'll see an output like the example below.

    ```output
    deployment.apps/ratings-api created
    ```

1. Watch the pods rolling out. We'll query for pods in the **ratingsapp** namespace that are labeled with **app=ratings-api**.

    ```bash
    kubectl get pods \
        --namespace ratingsapp \
        -l app=ratings-api -w
    ```

    In a few seconds, we'll see the pods transition to the `Running` state. Use `CTRL+C` to stop watching.

    ```output
    NAME                           READY   STATUS    RESTARTS   AGE
    ratings-api-564446d9c4-6rvvs   1/1     Running   0          42s
    ```

    If the pods aren't starting, not ready or are crashing, we can view their logs using `kubectl logs <pod name> --namespace ratingsapp` and `kubectl describe pod <pod name> --namespace ratingsapp`.

1. Check the status of the deployment

    ```bash
    kubectl get deployment ratings-api --namespace ratingsapp
    ```

    The deployment should show one replica is ready.

    ```output
    NAME          READY   UP-TO-DATE   AVAILABLE   AGE
    ratings-api   1/1     1            1           2m
    ```

## Create a Kubernetes service file for the ratings API service

To simplify the network configuration for application workloads, Kubernetes uses [Services](https://docs.microsoft.com/azure/aks/concepts-network#services?azure-portal=true) to group a set of pods and provide network connectivity logically.

1. Create a file called `ratings-api-service.yaml` using the integrated editor.

    ```bash    
    code ratings-api-service.yaml
    ```

1. Paste the following text in the file.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: ratings-api
    spec:
      selector:
        app: ratings-api
      ports:
      - protocol: TCP
        port: 80
        targetPort: 3000
      type: ClusterIP
    ```

1. Review the file, and note the following points:

    - **Selector**

     The selector determines the set of pods targeted by a service. In the example below, Kubernetes will load balance traffic to pods that have the label `app: ratings-api`, which was defined when creating the deployment. The controller for the service continuously scans for pods matching that label to add them to the load balancer.

    - **Ports**

    A service can map an incoming `port` to a `targetPort`. The incoming port is what the service would respond to, while the target port is what the pods are configured to listen to. For example, the service will be exposed internally within the cluster at `ratings-api.ratingsapp.svc.cluster.local:80` and will load balance the traffic to the ratings-api pods listening on port `3000`.

    - **Type**

    A service of type **Cluster IP** creates an internal IP address for use within the cluster. Choosing this value makes the Service only reachable from within the cluster. Cluster IP is the default service type.

1. To save and close the editor, open the ``...`` action panel in the top right of the editor and select **Save**, then select **Close editor**. We can also use <kbd>Ctrl-s</kbd> to save, and <kbd>Ctrl-q</kbd> to close the editor.

## Apply the Kubernetes service file to create a load balanced service

1. Apply the configuration using the `kubectl apply` command and use the  **ratingsapp** namespace.

    ```bash
    kubectl apply \
        --namespace ratingsapp \
        -f ratings-api-service.yaml
    ```

    We'll see an output like the example below.

    ```output
    service/ratings-api created
    ```

1. Check the status of the service

    ```bash
    kubectl get service ratings-api --namespace ratingsapp
    ```

    The service should show an internal IP where it would be accessible. By default, Kubernetes will create a DNS entry mapping to `[service name].[namespace].svc.cluster.local`, meaning this service will also be accessible at `ratings-api.ratingsapp.svc.cluster.local`. Notice how the **CLUSTER-IP** comes from the *Kubernetes service address range* we defined when creating the cluster.

    ```output
    NAME          TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
    ratings-api   ClusterIP   10.2.0.102   <none>        80/TCP    60s
    ```

1. Finally, let's validate the endpoints. Services load balance traffic to the pods through endpoints. The endpoint has the same name as the service. Validate that the service is pointing to one endpoint, corresponding to the pod. As we add more replicas, or as pods come and go, Kubernetes automatically keeps the endpoints updated.

    ```bash
    kubectl get endpoints ratings-api --namespace ratingsapp
    ```

    We'll get a similar output. Notice how the **ENDPOINTS** IPs come from the subnet we defined when creating the cluster.

    ```output
    NAME          ENDPOINTS                          AGE
    ratings-api   10.240.0.11:3000                   1h
    ```

We've now created a deployment of the **ratings-api** consisting of two replicas and exposed it as an internal (ClusterIP) service.

- **Deployment/ratings-api**. The API, running two replicas, which read the MongoDB connection details by mounting the **mongosecret** as an environment variable.
- **Service/ratings-api**. The API will be exposed internally within the cluster at `ratings-api.ratingsapp.svc.cluster.local:80`.
