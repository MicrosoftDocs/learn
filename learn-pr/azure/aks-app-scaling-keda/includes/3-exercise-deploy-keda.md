In this exercise, you'll deploy KEDA to an Azure Kubernetes Service (AKS) cluster to autoscale a sample component for your video rendering service. You'll deploy KEDA with deployment manifests using `kubectl`.  This is one of several options to deploy KEDA. For our purposes, using the default deployment files method is most appropriate.

> [!TIP]
> For more detailed information about installation options view the [official documentation](https://keda.sh/docs/2.2/deploy/).

## Setup environment

You start the AKS cluster deployment by provisioning the cluster within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select "Bash" as the running shell.

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by using the following command in Cloud Shell.

    Remember your variables from the introduction step or set them again.

    ```bash
    RESOURCE_GROUP=rg-contoso-video
    CLUSTER_NAME=contoso-video
    ```

    ```azurecli
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl allows you to manage multiple clusters from a single command-line interface.

2. Execute the `kubectl get nodes` command to check that you can connect to your cluster and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

    You should receive a list similar to what you see here:

    ```output
    NAME                                STATUS   ROLES   AGE    VERSION
    aks-nodepool1-14167704-vmss000000   Ready    agent   105s   v1.16.10
    aks-nodepool1-14167704-vmss000001   Ready    agent   105s   v1.16.10
    ```

## Deploy KEDA

1. Use `kubectl` to deploy the KEDA manifest files.

    `kubectl apply -f https://github.com/kedacore/keda/releases/download/v2.2.0/keda-2.2.0.yaml`

2. Use `kubectl` to verify the installation of KEDA.

    `kubectl get pods --namespace keda`

    You should see something similar to the following:

    ```text
    NAME                                      READY   STATUS    RESTARTS   AGE
    keda-metrics-apiserver-55dc9f9498-qswbh   1/1     Running   0          4m54s
    keda-operator-59dcf989d6-5kqfx            1/1     Running   0          4m53s
    ```
