Azure Policy for Kubernetes helps organizations meet governance and legal requirements, implement best practices, and establish organizational conventions for cloud environments.

Development teams in your company are embracing Azure Kubernetes Service (AKS) as a development platform. You realize you need to manage costs by enforcing business rules that define workload-resource limits. You want to make sure developers can deploy workloads only within specific limits for CPU and memory allocation. The system must prevent workloads that exceed those limits.

In this exercise, you'll configure Azure Policy for Azure Kubernetes Service on your AKS cluster. You'll configure a **[Preview]: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy. Finally, you'll test that the policy denies the scheduling of workloads that exceed the policy's resource parameters.

## Enable the ContainerService and PolicyInsights resource providers

1. Sign in to Azure Cloud Shell by using your Azure account. Select the Bash version of Cloud Shell.

    >[!div class="nextstepaction"]
    >[Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    >[!CAUTION]
    >
    >This exercise uses preview features. After you enable some preview features in Azure, defaults might be used for all AKS clusters created in the subscription. Test any preview features in non-production subscriptions to avoid unforeseen side effects in production deployments.

1. Azure Policy for AKS requires the cluster version to be 1.14 or later. Run the following script to validate your AKS cluster version:

    ```azurecli
    az aks list
    ```

    Make sure that the reported cluster version is 1.14 or later.

1. Register the Azure Kubernetes Service provider by running the `az provider register` command:

    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    ```

1. Register the Azure Policy provider by running the `az provider register` command:

    ```azurecli
    az provider register --namespace Microsoft.PolicyInsights
    ```

1. Enable the installation of the add-on by running the `az feature register` command:

    ```azurecli
    az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove
    ```

1. Check that the registration is successful by querying the feature-list table. Use the `az feature list` command to run the query. The feature's registration can take several minutes to finish, so you'll have to check the result periodically.

    ```azurecli
    az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AKS-AzurePolicyAutoApprove')].   {Name:name,State:properties.state}"
    ```

    If the Cloud Shell session times out, you can track the registration process via the Azure portal by using the [preview onboarding pane](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/JoinPreview/?azure-portal=true).

1. Run the `az provider register` command to propagate the update after you confirm that the feature-list query command shows 'Registered'.

    ```azurecli
    az provider register -n Microsoft.ContainerService
    ```

## Install the Azure CLI preview extensions

1. To work with this preview, you have to use the `aks-preview` Azure CLI preview extension for AKS. (You can ignore this step if you completed it in the previous exercise.)

    Install the latest version of the Azure CLI preview extension by running the `az extension add` command:

    ```azurecli
    az extension add --name aks-preview
    ```

    You can check the installed version of the extension if you've already installed the preview version. Run the `az extension show` command to query the extension version.

    ```azurecli
    az extension show --name aks-preview --query [version]
    ```

    If you've previously installed the extension and need to update it to a newer version, run the `az extension update` command:

    ```azurecli
    az extension update --name aks-preview
    ```

## Enable the Azure Policy Add-on

1. Run the `az aks enable-addons` command to enable the `azure-policy` add-on for your cluster:

    ```azurecli
    az aks enable-addons \
        --addons azure-policy \
        --name $AKS_CLUSTER_NAME \
        --resource-group $RESOURCE_GROUP
    ```

1. Verify that the azure-policy pod is installed in the `kube-system` namespace and that the gatekeeper pod is installed in the `gatekeeper-system` namespace. To do so, run the following `kubectl get pods` commands:

    ```bash
    kubectl get pods -n kube-system
    ```

    Here's an example of the output from the command:

    ```output
    NAME                                    READY   STATUS    RESTARTS   AGE
    azure-policy-78c8d74cd4-7fqn2           1/1     Running   0          12m
    azure-policy-webhook-545c898766-gsjrc   1/1     Running   0          12m
    ...
    ```

    ```bash
    kubectl get pods -n gatekeeper-system
    ```

    Here's an example of the output from the command:

    ```output
    NAME                                            READY   STATUS    RESTARTS   AGE
    gatekeeper-controller-manager-d5cd87796-5tmhq   1/1     Running   0          15m
    ...
    ```

1. Finally, verify that the latest add-on is installed by running `az aks show` command. This command retrieves the configuration information for your cluster.

    ```azurecli
    az aks show \
     --resource-group $RESOURCE_GROUP\
     --name $AKS_CLUSTER_NAME \
     -o table --query "addonProfiles.azurepolicy.config.version"
    ```

    ```output
    Result
    --------
    v2
    ```

    You're now ready to switch to the Azure portal to configure the policy named **[Preview]: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster**.

## Assign a built-in policy definition

To configure the new Azure Policy, use the Policy service in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. Locate the **Policy** service in the Azure portal. To do so, enter the term "policy" in the search bar at the top of the portal.

1. Select the **Policy** service from the list of services, as shown here:

    :::image type="content" source="../media/7-search-result.png" alt-text="Screenshot of the general Azure portal search box with a result that shows the Azure Policy service.":::

    The Policy dashboard opens with an overview that shows all your assigned policies, the status of resources, and how the policies affect them. If you haven't assigned any policies, the dashboard will be empty.

1. Select the **Assignments** option in the **Authoring** section of the **Policy** navigation panel:

    :::image type="content" source="../media/7-assignment-option.png" alt-text="Screenshot of the Policy service navigation panel that shows the location of the Assignments option.":::

1. Recall from earlier discussion that you have two options to create a policy assignment: you assign either an initiative or a policy. Select the **Assign policy** option:

    :::image type="content" source="../media/7-assign-policy.png" alt-text="Screenshot that shows the new policy assignment option." lightbox="../media/7-assign-policy.png":::

1. Create your policy by completing sets of information presented in the familiar Azure tab navigation view. The first tab, **Basics**, captures basic information:

    | Option | Value |
    | --- | --- |
    | **Scope** | Use the ellipsis button to open the **Scope** panel. Select the **subscription** that holds your resource group. Then, select the **akscostsavinggrp** resource group. |
    | **Exclusions** | Leave this value empty. |
    | **Policy definition** | Use the ellipsis button to open the **Available Definitions** panel. Filter the selection by using "CPU" as the term in the search box. Select the **[Preview]: Ensure container CPU and memory resource limits do not exceed the specified limits in Kubernetes cluster** policy from the list of options. |
    | **Assignment name** | Leave this value set to the default. |
    | **Description** | Leave this value empty for this exercise. |
    | **Policy enforcement** | Make sure this option is enabled. |
    | **Assigned by** | Leave this value set to the default. |

    Here's an example of the completed **Basics** tab:

    :::image type="content" source="../media/7-complete-basic-tab.png" alt-text="Screenshot that shows the information captured in the Basics tab.":::

1. Select the **Parameters** tab to specify the parameters for the policy.

1. Set the following values for each of the parameter options:

    | Option | Value
    | --- | --- |
    | **Max allowed CPU units** | Set the value to **200m**. The policy matches this value to both the workload resource-request value and the workload limit value specified in the workload's manifest file. |
    | **Max allowed memory bytes** | Set the value to **256Mi**. The policy matches this value to both the workload resource-request value and the workload limit value specified in the workload's manifest file. |
    | **Effect** | Set the value to **deny**. |
    | **Namespace exclusions** | Leave the default values set to **kube-system;gatekeeper-system;azure-arc**. |

    Here's an example of the completed **Parameters** tab:

    :::image type="content" source="../media/7-complete-parameters-tab.png" alt-text="Screenshot that shows the information captured in the Parameters tab.":::

1. Select the **Remediation** tab. In this tab, you select how the new policy impacts resources that already exist. By default, only newly created resources are affected by the new policy. Leave the default configuration as it is on this tab.

    Here's an example of the completed **Remediation** tab:

    :::image type="content" source="../media/7-complete-remediation-tab.png" alt-text="Screenshot that shows the information captured in the Remediation tab.":::

1. Select the **Review + save** tab. Review the values you've chosen, and then select **Save**.

## Test resource requests

The final step is to test the new policy. You'll deploy a test workload that includes resource requests and limits that violate the new policy.

1. Open Azure Cloud Shell and be sure to select the Bash version of Cloud Shell.

1. Create a manifest file for the Kubernetes deployment by using the integrated editor. Call the file `test-policy.yaml`:

    ```bash
    code test-policy.yaml
    ```

    > [!TIP]
    > Cloud Shell includes an [integrated file editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor). The Cloud Shell editor supports features such as language highlighting, the command palette, and a file explorer. For simple file creation and editing, start the editor by running `code .` in the Cloud Shell terminal. This action opens the editor with your active working directory set in the terminal. To open your manifest file directly for quick editing, run `code test-policy.yaml`. Ths command opens the editor without the file explorer.

1. Paste the following text into the file:

    ```yml
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
      labels:
        env: test
    spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
        resources:
          requests:
            cpu: 500m
            memory: 256Mi
          limits:
            cpu: 1000m
            memory: 500Mi
    ```

1. Select <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file. Select <kbd>Ctrl</kbd>+<kbd>Q</kbd> to close the editor.

1. Use the `kubectl apply` command to apply the configuration and deploy the application in the `costsavings` namespace:

    ```bash
    kubectl apply \
    --namespace costsavings \
    -f test-policy.yaml
    ```

    You'll see output like this:

    ```output
    Error from server (
    [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> memory limit <500Mi> is higher than the maximum allowed of <256Mi>
    [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> cpu limit <1> is higher than the maximum allowed of <200m>)
     : error when creating "test-deploy.yml"
     : admission webhook "validation.gatekeeper.sh" denied the request: 
    [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> memory limit <500Mi> is higher than the maximum allowed of <256Mi>
    [denied by azurepolicy-container-limits-52f2942767eda208f8ac3980dc04b548c4a18a2d1f7b0fd2cd1a7c9e50a92674] container <nginx> cpu limit <1> is higher than the maximum allowed of <200m>
    ```

    Notice how the admission webhook, `validation.gatekeeper.sh`, denied the request to schedule the pod.

1. Open the manifest file and fix the resource request:

    ```bash
    code test-policy.yaml
    ```

    Paste the following text in the file:

    ```yml
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
      labels:
        env: test
    spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
        resources:
          requests:
            cpu: 200m
            memory: 256Mi
          limits:
            cpu: 200m
            memory: 256Mi
    ```

1. Select <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file. Select <kbd>Ctrl</kbd>+<kbd>Q</kbd> to close the editor.

1. Use the `kubectl apply` command to apply the configuration and deploy the application in the `costsavings` namespace:

    ```bash
    kubectl apply \
    --namespace costsavings \
    -f test-policy.yaml
    ```

    You'll see output like this:

    ```output
    pod/nginx created
    ```

1. Use the `kubectl get pods` command to view the newly created pod. Make sure to query for pods in the `costsavings` namespace.

    ```bash
    kubectl get pods --namespace costsavings
    ```

    In a few seconds, you'll see the pods transition to the `Running` state. Select <kbd>CTRL</kbd>+<kbd>C</kbd>` to stop watching.

    ```output
    NAME    READY   STATUS    RESTARTS   AGE
    nginx   1/1     Running   0          50s
    ```
