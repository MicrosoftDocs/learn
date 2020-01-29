The ongoing performance of your cluster relies on the fact that you can monitor the different components in your application, view logs, and get alerts whenever your application goes down or some parts of it fail. You can use a combination of available tools to set up alerting capabilities for your application.  

In this exercise, you'll explore some of these tools. First, you'll create a Log Analytics workspace and enable Azure Monitor for containers. You'll then inspect the Kubernetes event logs and monitor your cluster's health.

Before you start with the exercise steps, let's define some of the items mentioned.

### What is Azure Monitor for containers?

[Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview?azure-portal=true) is a comprehensive monitoring solution for Kubernetes. This solution gives you insight into the performance of your cluster by collecting memory and processor metrics from controllers, nodes, and containers.

### What is a Log Analytics workspace?

A [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace?azure-portal=true) is a container that includes data and configuration information and is used by [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview?azure-portal=true) to store log data. You also use your workspace to manage access to the data logged.

## Create a Log Analytics workspace

You'll use Azure Monitor's Log Analytics to store monitoring data, events, and metrics from your Kubernetes cluster and the applications. You'll pre-create the Log Analytics workspace in your assigned environment resource group

1. Let's sign into the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with your Azure account.

1. Run the following command to create the workspace. You'll name the workspace **aksworkshop-workspace** and use the same resource group and region as your Azure Kubernetes Service (AKS) cluster, for example, **aksworkshop** in **East US**.

    ```bash
    az resource create --resource-type Microsoft.OperationalInsights/workspaces \
            --name aksworkshop-workspace \
            --resource-group aksworkshop \
            --location eastus \
            --properties '{}' -o table
    ```

## Enable the monitoring addon

Once your workspace is ready, you can integrate the Azure Monitor for containers monitoring addon into it.

1. You need the resource ID of your workspace to enable the addon. Run the following command to retrieve and store it in a Bash variable named `WORKSPACE_ID`.

    ```azurecli
    WORKSPACE_ID=$(az resource show --resource-type Microsoft.OperationalInsights/workspaces \
        --resource-group aksworkshop \
        --name aksworkshop-workspace \
        --query "id" -o tsv)
    ```

1. Next, enable the monitoring addon by running the command below.

    ```bash
    az aks enable-addons \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME \
        --addons monitoring \
        --workspace-resource-id $WORKSPACE_ID
    ```

    > [!NOTE]
    > It may take some time to establish monitoring data flow for newly created clusters. Please allow at least 5-10 minutes for data to appear for your cluster.

## Inspect the Kubernetes event or logs and monitor cluster health

You can view utilization reports and charts for your cluster in the Azure portal using Azure Monitor. Azure monitor gives you a global perspective of all containers deployed across your subscriptions and resource groups. From here, you can track containers that are monitored and those containers that aren't and inspect each container's statistics individually.

1. Switch to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Azure Monitor** from the left pane in the Azure portal.

1. Under the **Insights** section, select **Containers** to see a list of all clusters that you have access to.

1. Select the **Cluster** tab at the top of the view to check the cluster utilization. Notice how this view is again a high-level view that provides you a view on the cluster, nodes, controllers, and containers.

    [![](../media/09-clusterutilization.png "Screenshot showing a cluster utilization under load report")](../media/09-clusterutilization.png#lightbox)

1. Select the **Health** tab at the top of the view to get view on how the Kubernetes infrastructure services of the cluster are doing.

    [![](../media/09-clusterhealth.png "Screenshot showing health for a cluster")](../media/09-clusterhealth.png#lightbox)

1. Select the **Nodes** tab at the top of the view to get a detailed view of your nodes' health and pods in the cluster.

    [![](../media/09-podmetrics.png "Screenshot showing nodes and pods in a cluster")](../media/09-podmetrics.png#lightbox)

## View the live container logs and Kubernetes events

In addition to the high-level overview of your cluster's health, you can also view live log data of specific containers.

To enable and set permissions for the agent to collect the data, you'll first create a *Role* that has access to pod logs and events. Then you'll assign permissions to users using a *RoleBinding*.

In your exercise, you want to set up *Roles* and *RoleBindings that aren't limited to a specific namespace. You can configure Roles* and *RoleBindings* to grant permissions and bind roles to users across the entire cluster or to cluster resources outside a given namespace.

1. Create a file called `logreader-rbac.yaml` using the integrated editor.

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

1. Save the file with <kbd>Ctrl-s</kbd> and close the editor with <kbd>Ctrl-q</kbd>.

1. Apply the configuration using the `kubectl apply` command.

    ```bash
    kubectl apply \
        -f logreader-rbac.yaml
    ```

1. Switch back to the AKS cluster in the Azure portal.

1. Select **Insights** under **Monitoring**

1. Select the **Controllers** tab and pick a container to view its live logs or event logs.For example, pick the **ratings-api** container. The new view will allow you to debug the status of the container.

    [![](../media/09-livelogs.png "Screenshot showing an example of the event logs for an Azure Kubernetes cluster")](../media/09-livelogs.png#lightbox)
