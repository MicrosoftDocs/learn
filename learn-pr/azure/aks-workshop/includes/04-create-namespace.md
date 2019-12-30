Kubernetes provides features that let you logically isolate teams and workloads in the same cluster. The goal should be to provide the least number of privileges, scoped to the resources each team needs. A namespace in Kubernetes creates a logical isolation boundary. Names of resources need to be unique within a namespace, but not across namespaces.

If you don't specify the namespace when working with Kubernetes resources, the **default** namespace is implied.

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Create a Kubernetes namespace for the application

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) with your Azure subscription.

1. Open the Azure Cloud Shell from the Azure portal using the Cloud Shell icon.

    ![Image showing Cloud Shell icon in the Azure portal](../media/2-portal-cloudshell-access.png)

1. List the current namespaces in the cluster.

    ```azurecli
    kubectl get namespace
    ```

    You should get a list of namespaces, similar to this.

    ```output
    NAME              STATUS   AGE
    default           Active   1h
    kube-node-lease   Active   1h
    kube-public       Active   1h
    kube-system       Active   1h
    ```

1. You'll be using `kubectl create namespace` command to create a namespace for the application called **ratingsapp**.

    ```azurecli
    kubectl create namespace ratingsapp
    ```

    You will get a confirmation that the namespace was created.

    ```output
   namespace/ratingsapp created
    ```
