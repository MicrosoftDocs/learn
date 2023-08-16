In this exercise, you step through the process of applying pod security settings to an AKS cluster by using Azure Policy. The exercise consists of the following tasks:

 -  Deploy an AKS cluster.
 -  Install the Azure Policy add-on for AKS.
 -  Assign an Azure Policy initiative to an AKS cluster.
 -  Validate the effect of Azure Policy.

### Deploy an AKS cluster.

In this exercise, you deploy an AKS cluster. You use this cluster throughout all exercises in the module. While you can deploy a cluster using the Azure portal, you can use on Azure CLI instead for simplicity.

> [!NOTE]
> To complete this exercise, you need an [Azure Subscription](https://azure.microsoft.com/free/).

4.  From your computer, open a web browser window and navigate to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
5.  In the Azure portal, select the **Azure Cloud Shell** icon.
6.  If prompted to select either **Bash** or **PowerShell**, select **Bash**.
7.  Ensure that **Bash** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.
8.  To create a resource group to host the AKS cluster, in the Bash session in the Azure Cloud Shell, run the following commands. You can replace eastus with the name of another Azure region where you can create AKS clusters:
    
    ```azurecli
    AKSRG='aks-01-RG'
    LOCATION='eastus'
    az group create --name $AKSRG --location $LOCATION
    ```

6.  To create an AKS cluster, run the following commands:

```azurecli
AKSNAME='aks-01'
az aks create --resource-group $AKSRG --name $AKSNAME --enable-managed-identity --node-count 1 --generate-ssh-keys
```

    > [!NOTE]
    > Wait for the cluster provisioning to complete. Provisioning takes a few minutes.

7.  Once the cluster provisioning completes, to connect to the AKS cluster, run the following command:
    
    ```azurecli
    az aks get-credentials --resource-group $AKSRG --name $AKSNAME
    ```

8.  To verify that the connection was successful, run the following command:
    
    ```azurecli
    kubectl get nodes
    ```
    
    The output of the command should include the listing of the AKS nodes.

### Install the Azure Policy add-on for AKS.

In this task, you install the Azure Policy add-on for AKS.

1.  To install the Azure Policy add-on, you need to ensure that the **Microsoft.PolicyInsights** resource provider is registered in your subscription. From the Bash session in the Azure Cloud Shell in the Azure portal, run the following commands to verify:
    
    ```azurecli
    az provider register --namespace Microsoft.PolicyInsights
    az provider show --namespace Microsoft.PolicyInsights --output table
    ```

2.  Review the output and, if necessary, wait until the provider status changes to registered (you can run the second command to display the updated status).
3.  To install the add-on, run the following commands:
    
    ```azurecli
    AKSRG='aks-01-RG'
    AKSNAME='aks-01'
    az ads enable-addons --addons azure-policy --name $AKSNAME --resource-group $AKSRG
    ```
    
    > [!NOTE]
    > It's possible to enable the add-on during cluster deployment.

4.  To validate that the add-on installation was successful and that the *azure-policy* and *gatekeeper* pods are operational, run the following commands:
    
    ```azurecli
    kubectl get pods --namespace kube-system
    kubectl get pods --namespace gatekeeper-system
    ```

5.  To verify that, at this point, no Azure Policy constraints are applied to the target cluster, run the following command:
    
    ```azurecli
    kubectl get constrainttemplates
    ```

The command should generate output `No resources found.`

### Assign an Azure Policy initiative to an AKS cluster.

In this task, you assign an Azure Policy initiative to an AKS cluster. You use one of the built-in initiatives named *Kubernetes cluster pod security baseline standards for Linux-based workloads*.

1.  In the Azure portal, in the **Search** text box, search for and select **Policy**.
2.  In the left pane of the **Azure Policy** page, select **Definitions**.
3.  From the **Category** dropdown list box, use **Select all** to clear the filter and then select **Kubernetes**.
4.  In the **Definition type** dropdown list, select **Initiative**.
5.  In the list of the filtered policies, select the policy initiative named **Kubernetes cluster pod security baseline standards for Linux-based workloads**, and then select the **Assign initiative**.
6.  On the **Basics** tab of the **Assign initiative** page, set the **Scope** to your Azure subscription and the resource group named **aks-01-RG**, which hosts the newly deployed AKS cluster.
7.  Ensure that the **Policy enforcement** is set to **Enabled**, and then select **Next**.
8.  On the **Basics** tab of the **Assign initiative** page, select **Next**.
9.  On the **Advanced** tab, select **Next**.
10. On the Parameters tab, remove the **Only show parameters that need input or review** parameter**.** Next, in the **Effect drop-down** list, select **Deny** and then select **Review + create**.
    
    > [!NOTE]
    > You can apply exclusions and inclusions to individual namespaces.

10. On the **Review + create** tab, select **Create.**
11. Wait until the assignment takes effect (about 20 minutes). In the Azure portal, navigate to the **Azure Policy** page, select **Compliance**, and check if it displays the compliance status for the newly created policy assignment. Alternatively, you can rerun the kubectl get constraint templates command.

### Validate the effect of Azure Policy

In this task, you validate the effects of Azure Policy.

1.  In the Azure portal, in the Bash session of Azure Cloud Shell, use the built-in editor to create a file named *nginx-privileged.yaml* and copy it into the YAML manifest.
    
    <!--- raw content start --->
apiVersion: v1
kind: Pod
metadata:
  name: nginx-privileged
spec:
  containers:
    - name: nginx-privileged
      image: mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
      securityContext:
        privileged: true
<!--- raw content end --->

2.  Save the changes to the file and close it to return to the Bash prompt.

3.  Attempt deploying a pod based on the YAML manifest by running the following command:
    
    <!--- raw content start --->
kubectl apply -f nginx-privileged.yaml
<!--- raw content end --->

4.  Verify that the deployment fails with an error message that resembles the following one:
    
    <!--- raw content start --->
Error from server (Forbidden): error when creating "nginx-privileged.yaml": admission webhook "validation.gatekeeper.sh" denied the request: [azurepolicy-k8sazurev2noprivilege-a759592cb6adc510dcfa] Privileged container isn't allowed: nginx-privileged, securityContext: {"privileged": true}
<!--- raw content end --->
