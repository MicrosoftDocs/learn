In this exercise, you step through the process of applying pod security settings to an Azure Kubernetes Service (AKS) cluster by using Azure Policy. The exercise consists of the following tasks:

- Deploy an AKS cluster.
- Install the Azure Policy add-on for AKS.
- Assign an Azure Policy initiative to an AKS cluster.
- Validate the effect of Azure Policy.

### Deploy an AKS cluster

In this exercise, you deploy an AKS cluster. You use this cluster throughout all exercises in the module. While you can deploy a cluster using the Azure portal, you can use Azure CLI instead for simplicity.

> [!NOTE]
> To complete this exercise, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn). Your account must have permission to create AKS resources, register the **Microsoft.PolicyInsights** resource provider, enable AKS add-ons, and assign Azure Policy. Assigning Azure Policy typically requires the Owner or Resource Policy Contributor role at the assignment scope.

1. From your computer, open a web browser window and navigate to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
1. In the Azure portal, select the **Azure Cloud Shell** icon.
1. If prompted to select either **Bash** or **PowerShell**, select **Bash**.
1. Ensure that **Bash** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.
1. To create a resource group to host the AKS cluster, in the Bash session in the Azure Cloud Shell, run the following commands. You can replace eastus with the name of another Azure region where you can create AKS clusters:

    ```azurecli
    AKSRG='aks-01-RG'
    LOCATION='eastus'
    az group create --name $AKSRG --location $LOCATION
    ```

1. To create an AKS cluster, run the following commands:

    ```azurecli
    AKSNAME='aks-01'
    az aks create --resource-group $AKSRG --name $AKSNAME --node-count 1 --generate-ssh-keys
    ```

    > [!NOTE]
    > The `--generate-ssh-keys` flag creates SSH key files in `~/.ssh` if they don't already exist. In Azure Cloud Shell, those files persist in your Cloud Shell home directory and are reused on subsequent runs.

1. Once the cluster provisioning completes, to connect to the AKS cluster, run the following command:

    ```azurecli
    az aks get-credentials --resource-group $AKSRG --name $AKSNAME
    ```

1. To verify that the connection was successful, run the following command:

    ```bash
    kubectl get nodes
    ```

    The output of the command should include the listing of the AKS nodes.

### Install the Azure Policy add-on for AKS

In this task, you install the Azure Policy add-on for AKS.

1. To install the Azure Policy add-on, you need to ensure that the **Microsoft.PolicyInsights** resource provider is registered in your subscription. From the Bash session in the Azure Cloud Shell in the Azure portal, run the following commands to register the provider and verify its status:

    ```azurecli
    az provider register --namespace Microsoft.PolicyInsights --wait
    az provider show --namespace Microsoft.PolicyInsights --query "{Provider:namespace,State:registrationState}" --output table
    ```

1. Review the output and confirm that the provider status is **Registered**.
1. To install the add-on, run the following commands:

    ```azurecli
    AKSRG='aks-01-RG'
    AKSNAME='aks-01'
    az aks enable-addons --addons azure-policy --name $AKSNAME --resource-group $AKSRG
    ```

    > [!NOTE]
    > You can also enable the Azure Policy add-on during cluster deployment by adding `--enable-addons azure-policy` to the `az aks create` command.

1. To validate that the add-on installation was successful and that the *azure-policy* and *gatekeeper* pods are operational, run the following commands:

    ```bash
    kubectl get pods --namespace kube-system
    kubectl get pods --namespace gatekeeper-system
    ```

    > [!NOTE]
    > The Azure Policy add-on can take several minutes to roll out. If the `azure-policy` or Gatekeeper pods aren't yet `Running`, wait a moment and re-run the previous `kubectl get pods` commands until both sets of pods report `Running` and `Ready`.

1. To verify that, at this point, no Azure Policy constraint templates are present on the target cluster, run the following command:

    ```bash
    kubectl get constrainttemplates
    ```

The command should generate output `No resources found` only if no inherited or automatically applied Kubernetes policy assignments, such as assignments from Microsoft Defender for Cloud, already target the cluster.

### Assign an Azure Policy initiative to an AKS cluster

In this task, you assign an Azure Policy initiative to an AKS cluster. You use one of the built-in initiatives named *Kubernetes cluster pod security baseline standards for Linux-based workloads*.

1. In the Azure portal, in the **Search** text box, search for and select **Policy**.
1. In the left pane of the **Azure Policy** page, select **Definitions**.
1. From the **Category** dropdown list box, use **Select all** to clear the filter and then select **Kubernetes**.
1. In the **Definition type** dropdown list, select **Initiative**.
1. In the list of filtered definitions, select the policy initiative named **Kubernetes cluster pod security baseline standards for Linux-based workloads**, and then select **Assign**.
1. On the **Basics** tab of the **Assign initiative** page, set the **Scope** to your Azure subscription and the resource group named **aks-01-RG**, which hosts the newly deployed AKS cluster.
1. Ensure that the **Policy enforcement** is set to **Enabled**, and then select **Next** until you reach the **Parameters** tab.
1. On the **Parameters** tab, if **Effect** isn't visible, clear the **Only show parameters that need input or review** checkbox. In the **Effect** drop-down list, select **Deny**, and then select **Review + create**.

    > [!NOTE]
    > You can apply exclusions and inclusions to individual namespaces.

1. On the **Review + create** tab, select **Create**.
1. Wait until the assignment takes effect (about 20 minutes). In the Azure portal, navigate to the **Azure Policy** page, select **Compliance**, and check the compliance status for the newly created policy assignment. You can also rerun the `kubectl get constrainttemplates` command to verify that Gatekeeper constraint templates were downloaded to the cluster, but use Azure Policy compliance results to determine compliance status.

### Validate the effect of Azure Policy

In this task, you validate the effects of Azure Policy.

1. In the Azure portal, in the Bash session of Azure Cloud Shell, use a text editor, such as the built-in Cloud Shell editor, nano, or vi, to create a file named *nginx-privileged.yaml* and copy into it the following YAML manifest:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx-privileged
    spec:
      containers:
        - name: nginx-privileged
          image: mcr.microsoft.com/azurelinux/base/nginx:1.28
          securityContext:
            privileged: true
    ```

1. Save the changes to the file and close it to return to the Bash prompt.

1. Attempt deploying a pod based on the YAML manifest by running the following command:

    ```bash
    kubectl apply -f nginx-privileged.yaml
    ```

1. Verify that pod creation fails with an error message that resembles the following one.

    ```output
    Error from server ([denied by azurepolicy-container-no-privilege-00edd87bf80f443fa51d10910255adbc4013d590bec3d290b4f48725d4dfbdf9] Privileged container is not allowed: nginx-privileged, securityContext: {"privileged": true}): error when creating "nginx-privileged.yaml": admission webhook "validation.gatekeeper.sh" denied the request: [denied by azurepolicy-container-no-privilege-00edd87bf80f443fa51d10910255adbc4013d590bec3d290b4f48725d4dfbdf9] Privileged container is not allowed: nginx-privileged, securityContext: {"privileged": true}
    ```
