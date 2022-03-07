
In the following exercise, you will deploy an AKS cluster to represent the AKS cluster that the deployment team at Songify had set up earlier. Then you will apply patch updates and upgrade that AKS cluster. 

 :::image type="content" source="../media/4-apply-patches-and-upgrade-aks-cluster.png" border="false" alt-text="An image that shows the process of the lab from applying patch upgrades first to the out of support version before upgrading to the latest supported version.":::

## Activate the Sandbox

1. Start by activating the Azure Sandbox environment. 


## Create an AKS cluster 

2. Run the following command in the Sandbox Azure Cloud Shell to check the current list of Kubernetes versions supported by Azure Kubernetes Service.

    ```azurecli-interactive
    az aks get-versions -l westus -o table
    ```

    You should see a list similar to the one below:
    
     :::image type="content" source="../media/4-current-aks-version-list.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service.":::

3. Select the oldest supported Kubernetes version from the list and store it inside a variable, *KV*. 

    ```azurecli-interactive
    KV=1.18.17
    ```
    
     :::image type="content" source="../media/4-select-oldest-supported-kubernetes-version.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service with the oldest supported version outlined in a red box.":::

4. Run the next command to find the resource group name and store in inside a variable, *RG*.

    ```azurecli-interactive
    az group list -o table 
    RG=<rgn>[sandbox resource group name]</rgn>
    ```
     :::image type="content" source="../media/4-find-sandbox-resource-group.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the name, location, and status of the resource group used in the lab.":::
 
5. Run the following command to create an AKS cluster using the oldest supported Kubernetes version. 

    ```azurecli-interactive
    CLUSTERNAME=myakscluster
    az aks create -n $CLUSTERNAME -g $RG --kubernetes-version $KV --generate-ssh-keys
    ```
    Make sure your AKS cluster has been successfully provisioned before moving onto the next step. You can check by running the following command. 
    
    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```
    
## Upgrade the AKS cluster

6. First check if you need to upgrade your existing AKS clusters by running the following command. 

    ```azurecli-interactive
    az aks get-upgrades -n $CLUSTERNAME -g $RG -o table
    ```
    
    You will see the versions available for upgrades are the next three supported Kubernetes versions from the current AKS cluster version. 
    
    For example:
    
     :::image type="content" source="../media/4-only-next-3-versions-available-for-upgrade.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service with the n-1 and n-2 versions outlined in a red box.":::

7. Let's try to upgrade to the latest supported Kubernetes version immediately by running the following command.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG -k [latest-version] # e.g. 1.21.1
    ```
    
    You should see an error message similar to the one below:
    
    ```output
    Operation failed with status: 'Bad Request'. Details: Upgrading Kubernetes version 1.18.17 to 1.21.1 is not allowed. Available upgrades: 1.18.19,1.19.9,1.19.11. Please see https://aka.ms/aks-supported-k8s-ver for version details.
    ```
    
    When upgrading your AKS clusters, you cannot skip minor versions. This means if you are running version 1.18.x, you cannot immediately upgrade to version 1.20.x and above.
    
    However, you can skip patch version upgrades within a minor version.

## Apply patches updates 

8. Run the following command to apply patch updates to the current AKS cluster.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-patch-version] # e.g. 1.18.19
    ```
    
    Wait until the patch upgrade is completed before by moving onto the next step by running the following command.
    
    ```azurecli-interactive
    az aks wait -g $RG -n $CLUSTERNAME --update
    ```

    
    > [!NOTE]
    > It is possible to apply upgrades only to the control plane in the AKS cluster or only to the nodes in the AKS cluster by including the optional parameters `--control-plane-only` or `--node-image-only` when running the upgrade command. If the optional parameters are not included, both the control plane and nodes in the AKS cluster are upgraded.


    Once complete, run the following command to confirm the patch upgrade. Check the `KubernetesVersion` is the next patch version.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```
## Upgrade to the next minor version

9. Run the following command to upgrade the AKS cluster to the next supported Kubernetes minor version.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-minor-version] # e.g. 1.19.11
    ```
    
    Wait until the minor upgrade is completed before by moving onto the next step by running the following command.
    
    ```azurecli-interactive
    az aks wait -g $RG -n $CLUSTERNAME --update
    ```

    Once complete, run the following command to confirm the upgrade. Check the `KubernetesVersion` is the next minor version.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

10. Finally, run the following command to upgrade the cluster to the latest stable Kubernetes version supported by Azure Kubernetes Service.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [latest-stable-version] # e.g. 1.20.7
    ```
    Wait until the upgrade is completed before by moving onto the next step by running the following command.
    
    ```azurecli-interactive
    az aks wait -g $RG -n $CLUSTERNAME --update
    ```
    Once complete, run the following command to confirm the upgrade. Check the `KubernetesVersion` is the latest stable Kubernetes version.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

## Clean up your resources 

Before exiting the lab, it is always good practice to delete and remove resources that are no longer used.

11. Delete the AKS cluster by running the following command before you exit the lab. 

    ```azurecli-interactive
    az aks delete -n $CLUSTERNAME -g $RG --no-wait 
    ```
