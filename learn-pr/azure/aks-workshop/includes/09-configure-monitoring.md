The ongoing performance of your cluster relies on the fact that you can monitor the different components in your application, view logs, and get alerts whenever your application goes down or some parts of it fail. You can use a combination of available tools to set up alerting capabilities for your application.

In this exercise, you explore some of these tools. First, you create a Log Analytics workspace and enable Azure Monitor for containers. Then you inspect the Azure Kubernetes Service (AKS) event logs and monitor your cluster's health.

Before you start with the exercise steps, let's define some of the items mentioned.

### What is Azure Monitor for containers?

[Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview?azure-portal=true) is a comprehensive monitoring solution for Azure Kubernetes Service. This solution gives you insight into the performance of your cluster by collecting memory and processor metrics from controllers, nodes, and containers.

### What is a Log Analytics workspace?

A [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace?azure-portal=true) is a container that includes data and configuration information and is used by [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview?azure-portal=true) to store log data. You also use your workspace to manage access to the data logged.

## Create a Log Analytics workspace

You use Log Analytics in Azure Monitor to store monitoring data, events, and metrics from your AKS cluster and the applications. You pre-create the Log Analytics workspace in your assigned environment resource group.

1. Sign in to [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with your Azure account.

1. Run the following command to create the workspace. You'll need a unique name for the workspace, so you'll use the first command below to generate a name similar to **aksworkshop-workspace-12345**. You'll then run the second command to create the workspace in the same resource group and region as your Azure Kubernetes Service (AKS) cluster, for example, **aksworkshop** in **East US**.

    ```bash
    WORKSPACE=aksworkshop-workspace-$RANDOM
    az resource create --resource-type Microsoft.OperationalInsights/workspaces \
            --name $WORKSPACE \
            --resource-group aksworkshop \
            --location eastus \
            --properties '{}' -o table
    ```

## Enable the monitoring add-on

After your workspace is ready, you can integrate the Azure Monitor add-on that's used for containers monitoring into it.

1. You need the resource ID of your workspace to enable the add-on. Run the following command to retrieve and store it in a Bash variable named `WORKSPACE_ID`.

    ```azurecli
    WORKSPACE_ID=$(az resource show --resource-type Microsoft.OperationalInsights/workspaces \
        --resource-group aksworkshop \
        --name $WORKSPACE \
        --query "id" -o tsv)
    ```

1. Next, enable the monitoring add-on by running the following command.

    ```bash
    az aks enable-addons \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME \
        --addons monitoring \
        --workspace-resource-id $WORKSPACE_ID
    ```

    > [!NOTE]
    > It might take some time to establish monitoring data flow for newly created clusters. Allow at least 5 to 10 minutes for data to appear for your cluster.

## Inspect the AKS event or logs and monitor cluster health

You can view utilization reports and charts for your cluster in the Azure portal by using Azure Monitor. Azure Monitor gives you a global perspective of all containers deployed across your subscriptions and resource groups. From here, you can track containers that are monitored and those containers that aren't monitored. You can also inspect each container's statistics individually.

1. Switch to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Azure Monitor** from the left pane in the Azure portal.

1. Under the **Insights** section, select **Containers** to see a list of all clusters that you have access to.

1. Select the **Cluster** tab at the top of the view to check the cluster utilization. Notice how this view is again a high-level view that provides you a view on the cluster, nodes, controllers, and containers.

    ![Screenshot showing a cluster utilization under load report](../media/09-clusterutilization.png#lightbox)

1. Select the **Health** tab at the top of the view to get a view on how the AKS infrastructure services of the cluster are doing.

    ![Screenshot showing health for a cluster](../media/09-clusterhealth.png#lightbox)

1. Select the **Nodes** tab at the top of the view to get a detailed view of your nodes' health and pods in the cluster.

    ![Screenshot showing nodes and pods in a cluster](../media/09-podmetrics.png#lightbox)

## View the live container logs and AKS events

In addition to the high-level overview of your cluster's health, you can also view live log data of specific containers.

To enable and set permissions for the agent to collect the data, first create a *Role* that has access to pod logs and events. Then you assign permissions to users by using *RoleBinding*.

In your exercise, you want to set up *Roles* and *RoleBindings* that aren't limited to a specific namespace. You can configure *Roles* and *RoleBindings* to grant permissions and bind roles to users across the entire cluster or to cluster resources outside a given namespace.

1. Create a file called `logreader-rbac.yaml` by using the integrated editor.

    ```bash
    code logreader-rbac.yaml
    ```

1. Paste the following text in the file.

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
        name: containerHealth-log-reader
    rules:
        - apiGroups: ["", "metrics.k8s.io", "extensions", "apps"]
          resources:
             - "pods/log"
             - "events"
             - "nodes"
             - "pods"
             - "deployments"
             - "replicasets"
          verbs: ["get", "list"]
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
        name: containerHealth-read-logs-global
    roleRef:
        kind: ClusterRole
        name: containerHealth-log-reader
        apiGroup: rbac.authorization.k8s.io
    subjects:
    - kind: User
      name: clusterUser
      apiGroup: rbac.authorization.k8s.io
    ```

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

1. Apply the configuration by using the `kubectl apply` command.

    ```bash
    kubectl apply \
        -f logreader-rbac.yaml
    ```

1. Switch back to the AKS cluster in the Azure portal.

1. Select **Insights** under **Monitoring**.

1. Select the **Controllers** tab, and choose a container to view its live logs or event logs. For example, choose the **ratings-api** container. The new view allows you to debug the status of the container.

    ![Screenshot showing an example of the event logs for an Azure Kubernetes Service cluster](../media/09-livelogs.png#lightbox)
