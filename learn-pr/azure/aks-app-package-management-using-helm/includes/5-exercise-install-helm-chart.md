Helm charts make it easy to install preconfigured cloud-native apps on a Kubernetes cluster.

In this exercise, you'll use Helm to install the pet store application on your Kubernetes cluster.

## Deploy a Helm chart

1. Navigate to the [Azure Cloud Shell](https://shell.azure.com) and make sure you're in the *aks-store-demo* directory. If not, change to the directory using `cd`.

    ```bash
    cd aks-store-demo
    ```

2. Change into the *charts/aks-store-demo* directory using `cd`.

    ```bash
    cd charts
    ```

3. Deploy the pet store front Helm chart using the `helm install` command.

    ```bash
    helm install aks-store-demo ./aks-store-demo
    ```

    The command should return a result similar to the following output:

    ```output
    NAME: aks-store-demo
    LAST DEPLOYED: Tue Feb 20 21:05:51 2024
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    NOTES:
    1. Get the application URL by running these commands:
      export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=aks-store-demo,app.kubernetes.io/instance=storedemo2" -o jsonpath="{.items[0].metadata.name}")
      export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
      echo "Visit http://127.0.0.1:8080 to use your application"
      kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
    ```

4. Helm allows you to query all the installed release on the cluster. List all Helm releases using the `helm list` command.

    ```bash
    helm list
    ```

    The command should return a result similar to the following output:

    ```output
    NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
    aks-store-demo  default         1               2024-02-20 21:05:51.557392349 +0000 UTC deployed        aks-store-demo-0.1.0    1.16.0
    ```

5. Helm allows you to fetch manifest information related to each release. Fetch manifest information using the `helm get manifest` command.

    ```bash
    helm get manifest aks-store-demo
    ```

    The command should return a result similar to the following condensed output:

    ```output
    ---
    # Source: aks-store-demo-chart/templates/order-service.yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: order-service-secret
    ...
    ---
    # Source: aks-store-demo-chart/templates/rabbitmq.yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: rabbitmq-secret
    ...
    ---
    # Source: aks-store-demo-chart/templates/order-service.yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: makeline-service-configmap
    ...
    ```

6. Validate that the pod is deployed using the `kubectl get pods` command.

    ```bash
    kubectl get pods -o wide -w
    ```

    The command should return a result similar to the following output:

    ```output
    NAME                                         READY   STATUS    RESTARTS   AGE     IP            NODE                                NOMINATED NODE   READINESS GATES
    makeline-service-8747ddb89-j6mvz             1/1     Running   0          6m11s   10.244.2.7    aks-nodepool1-41853373-vmss000001   <none>           <none>
    mongodb-0                                    1/1     Running   0          6m11s   10.244.2.3    aks-nodepool1-41853373-vmss000001   <none>           <none>
    order-service-7854888498-mlsvv               1/1     Running   0          6m11s   10.244.2.8    aks-nodepool1-41853373-vmss000001   <none>           <none>
    product-service-5d7d4f5c47-gr4sc             1/1     Running   0          6m11s   10.244.2.6    aks-nodepool1-41853373-vmss000001   <none>           <none>
    rabbitmq-0                                   1/1     Running   0          6m11s   10.244.2.2    aks-nodepool1-41853373-vmss000001   <none>           <none>
    store-admin-894788d77-k5qjw                  1/1     Running   0          6m11s   10.244.2.10   aks-nodepool1-41853373-vmss000001   <none>           <none>
    store-front-6749d8579c-xdkv8                 1/1     Running   0          6m11s   10.244.2.4    aks-nodepool1-41853373-vmss000001   <none>           <none>
    virtual-customer-76c4bb9b7-dq6lc             1/1     Running   0          6m11s   10.244.2.9    aks-nodepool1-41853373-vmss000001   <none>           <none>
    virtual-worker-56b79f9547-9dkm9              1/1     Running   0          6m11s   10.244.2.5    aks-nodepool1-41853373-vmss000001   <none>           <none>
    ```

    Use `Ctrl+C` to exit the command once done.

## Delete a Helm release

1. Delete the Helm release using the `helm delete` command.

    ```bash
    helm delete aks-store-demo
    ```

    The command should return a result similar to the following output:

    ```output
    release "aks-store-demo" uninstalled
    ```

## Install a Helm chart with set values

You can override values for a Helm chart by passing either a value parameter or your own `values.yaml` file. For now, use the following commands to see how to update a value using the `--set` parameter. You'll learn how to use a `values.yaml` file in the next unit.

1. Install the Helm chart using the `helm install` command with the `--set` parameter to set the `replicaCount` of the deployment template to five replicas.

    ``` bash
    helm install --set replicaCount=5 aks-store-demo ./aks-store-demo
    ```

2. Validate that five pod replicas were deployed using the `kubectl get pods` command.

    ```bash
    kubectl get pods -o wide -w
    ```

    The command should return a result similar to the following output:

    ```output
    NAME                                         READY   STATUS     RESTARTS   AGE   IP            NODE                                NOMINATED NODE   READINESS GATES
    aks-store-demo-c8dfddf78-2v8fv               1/1     Running   0          31s   10.244.1.5    aks-nodepool1-41853373-vmss000000   <none>           <none>
    aks-store-demo-c8dfddf78-8t4rq               1/1     Running   0          31s   10.244.2.16   aks-nodepool1-41853373-vmss000001   <none>           <none>
    aks-store-demo-c8dfddf78-h2p8m               1/1     Running   0          31s   10.244.2.15   aks-nodepool1-41853373-vmss000001   <none>           <none>
    aks-store-demo-c8dfddf78-l8qq2               1/1     Running   0          31s   10.244.0.10   aks-nodepool1-41853373-vmss000002   <none>           <none>
    aks-store-demo-c8dfddf78-xwcpw               1/1     Running   0          31s   10.244.0.9    aks-nodepool1-41853373-vmss000002   <none>           <none>
    ```

    Use `Ctrl+C` to exit the command once done.

3. Delete the Helm chart using the `helm delete` command.

    ```bash
    helm delete aks-store-demo
    ```
