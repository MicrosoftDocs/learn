In the following exercise, you deploy an AKS cluster to represent the AKS cluster that the deployment team at Nod Publishers set up earlier. Then, you apply patch updates and upgrade the AKS cluster to the latest supported Kubernetes version.

 :::image type="content" source="../media/4-apply-patches-and-upgrade-aks-cluster.png" border="false" alt-text="Diagram showing the lab process: applying patch upgrades to the out-of-support version before upgrading to the latest supported version.":::

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

## Create an AKS cluster

1. In [Azure Cloud Shell](https://shell.azure.com), create a resource group using the `az group create` command.

    ```azurecli-interactive
    az group create -l westus -n myResourceGroup
    ```

2. Check the current list of Kubernetes versions that AKS supports using the `az aks get-versions` command.

    ```azurecli-interactive
    az aks get-versions -l westus -o table
    ```

    You should get a list similar to the one below:

     :::image type="content" source="../media/4-current-aks-version-list.png" border="true" alt-text="Screenshot that shows the current Kubernetes version list supported by Azure Kubernetes Service.":::

3. Find the oldest supported Kubernetes version from the list and store it inside a variable named *KV*.

    ```azurecli-interactive
    KV=1.24.9
    ```

     :::image type="content" source="../media/4-select-oldest-supported-kubernetes-version.png" border="true" alt-text="Screenshot that shows the current Kubernetes version list supported by Azure Kubernetes Service with the oldest supported version outlined in a red box.":::

4. Get your resource group name and store in inside a variable named *RG*.

    ```azurecli-interactive
    az group list -o table 
    RG=myResourceGroup
    ```

     :::image type="content" source="../media/4-find-resource-group.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the name, location, and status of the resource group used in the lab.":::

5. Create an AKS cluster using the `az aks create` command.

    ```azurecli-interactive
    CLUSTERNAME=myAKSCluster
    az aks create -n $CLUSTERNAME -g $RG --kubernetes-version $KV --generate-ssh-keys
    ```

## Upgrade the AKS cluster

1. Check for available cluster upgrades using the `az aks get-upgrades` command.

    ```azurecli-interactive
    az aks get-upgrades -n $CLUSTERNAME -g $RG -o table
    ```

    You'll see the versions available for upgrades are the next three supported Kubernetes versions from the current AKS cluster version.

    For example:

     :::image type="content" source="../media/4-only-next-3-versions-available-for-upgrade.png" border="true" alt-text="Screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service with the n-1 and n-2 versions outlined in a red box.":::

2. Try to immediately upgrade to the latest supported Kubernetes version using the `az aks upgrade` command and replace `[latest-version]` with the latest Kubernetes version from the previous step.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG -k [latest-version]
    ```

    You should get an error message similar to the one below:

    ```output
    Operation failed with status: 'Bad Request'. Details: Upgrading Kubernetes version 1.18.17 to 1.21.1 is not allowed. Available upgrades: 1.18.19,1.19.9,1.19.11. Please see https://aka.ms/aks-supported-k8s-ver for version details.
    ```

    You can't skip minor versions when upgrading your AKS cluster. This means if you're running version 1.24.x, you can't immediately upgrade to version 1.26.x and above. However, you can skip patch version upgrades within a minor version.

## Apply patches updates

1. Apply patch updates to AKS cluster using the `az aks upgrade` command and replace `[next-patch-version]` with the next patch version from the previous section.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-patch-version]
    ```

    > [!NOTE]
    > It's possible to apply upgrades only to the control plane in the AKS cluster or only to the nodes in the AKS cluster by including the optional parameters `--control-plane-only` or `--node-image-only` when running the upgrade command. If the optional parameters aren't included, both the control plane and nodes in the AKS cluster are upgraded.

2. Confirm the patch upgrade using the `az aks show` command.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

## Upgrade to the next minor version

1. Upgrade the AKS cluster to the next supported Kubernetes minor version using the `az aks upgrade` command and replace `[next-minor-version]` with the next minor version from the previous section.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-minor-version]
    ```

2. Confirm the upgrade using the `az aks show` command.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

3. Upgrade the cluster to the latest stable Kubernetes version AKS supports using the `az aks upgrade` command and replace `[latest-stable-version]` with the latest stable version from the previous section.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [latest-stable-version]
    ```

4. Confirm the upgrade using the `az aks show` command.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

## Clean up your resources

In this module, you created resources using your Azure subscription. The following steps show you how to clean up these resources so you don't incur Azure costs after you complete this module.

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).
2. Select **Resource groups** > **myResourceGroup**.
3. Select **Delete resource group** and enter the name of the resource group to confirm.
4. Select **Delete** > **Delete**.
