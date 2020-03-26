The success of Fruit Smoothies' marketing campaign is the ongoing performance of the ratings website. The performance is depended on our cluster's performance and relies on the fact that we can monitor the different components in our application, view logs, and get alerts whenever our application goes down or some parts of it fail. We can use a combination of available tools to set up alerting capabilities for our application.

In this exercise, we explore some of these tools. First, we'll create a Log Analytics workspace and enable Azure Monitor for containers. Then we'll inspect the Azure Kubernetes Service (AKS) event logs and monitor our cluster's health.

We'll also see how to create a *Role* and a *RoleBinding*. These objects enable and set permissions for the agent to collect the data from the cluster.

Before we start with the exercise steps, let's define some of the items mentioned.

### What is Azure Monitor for containers?

Azure Monitor for containers is a comprehensive monitoring solution for Azure Kubernetes Service. This solution gives us insight into the performance of our cluster by collecting memory and processor metrics from controllers, nodes, and containers.

### What is a Log Analytics workspace?

A Log Analytics workspace is a container that includes data and configuration information and is used by Azure Monitor to store log data. We also use the workspace to manage access to the data logged.

### What is Role-based access control (RBAC)?

We use Role-based access control (RBAC) in Kubernetes as a way of regulating access to resources based on the roles of individual users within our organization. RBAC authorization uses a set of related paths in the Kubernetes API to allow us to dynamically configure policies. The RBAC API defines four Kubernetes objects:

- Role
- ClusterRole
- RoleBinding
- ClusterRoleBinding

### What is a Kubernetes Role?

The RBAC Role and ClusterRole objects allow us to set up rules that represent a set of permissions. The main difference between a Role and a ClusterRole is that a Role is used with resources in a specific namespace and ClusterRole is used with non-namespace resources in a cluster. We'll see how to define a ClusterRole later in the exercise.

### What is a Kubernetes RoleBinding?

We use a role binding to grant the permissions defined in a role to a user or set of users. A role binding contains the list of users, groups, or service accounts, and a reference to the role being granted. Like the Role and ClusterRole, a RoleBinding grants permission within a specific namespace and the ClusterRoleBinding grants access to the cluster. We'll use a ClusterRoleBinding bind our ClusterRole to all the namespaces in our cluster.

## Create a Log Analytics workspace

We use Log Analytics in Azure Monitor to store monitoring data, events, and metrics from our AKS cluster and the applications. First, we'll pre-create the Log Analytics workspace in our assigned environment resource group.

1. Sign in to [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with an Azure account.

1. We need a unique name for the workspace. Run the command below to generate a name similar to **aksworkshop-workspace-12345**.

    ```bash
    WORKSPACE=aksworkshop-workspace-$RANDOM
    ```

1. Run the `az resource create` command to create the workspace in the same resource group and region as our Azure Kubernetes Service (AKS) cluster. For example, **aksworkshop** in **East US**.

    ```bash
    az resource create --resource-type Microsoft.OperationalInsights/workspaces \
            --name $WORKSPACE \
            --resource-group $RESOURCE_GROUP \
            --location $REGION_NAME \
            --properties '{}' -o table
    ```

## Enable the monitoring add-on

Once the workspace is ready, we can integrate the Azure Monitor add-on that's used for containers monitoring into it.

1. We need provided the resource ID of our workspace to enable the add-on. Run the following command to retrieve and store the workspace ID in a Bash variable named `WORKSPACE_ID`.

    ```azurecli
    WORKSPACE_ID=$(az resource show --resource-type Microsoft.OperationalInsights/workspaces \
        --resource-group $RESOURCE_GROUP \
        --name $WORKSPACE \
        --query "id" -o tsv)
    ```

1. Next, enable the monitoring add-on by running the `az aks enable-addons` command.

    ```bash
    az aks enable-addons \
        --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME \
        --addons monitoring \
        --workspace-resource-id $WORKSPACE_ID
    ```

    > [!NOTE]
    > It might take some time to establish monitoring data flow for newly created clusters. Allow at least 5 to 10 minutes for data to appear for our cluster.

## Inspect the AKS event or logs and monitor cluster health

We view utilization reports and charts for our cluster in the Azure portal by using Azure Monitor. Azure Monitor gives us a global perspective of all containers deployed across subscriptions and resource groups. From here, we can track containers that are monitored and those containers that aren't monitored. We can also inspect each container's statistics individually.

Let's look at the steps we need to take to get a detailed view of the health of nodes and pods in a cluster.

1. Switch to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Azure Monitor** from the left pane in the Azure portal.

1. Under the **Insights** section, select **Containers** to see a list of all clusters that we have access to.

1. Select the **Cluster** tab at the top of the view to check the cluster utilization. Notice how this view is again a high-level view that provides us a view on the cluster, nodes, controllers, and containers.

    ![Screenshot showing a cluster utilization under load report.](../media/09-clusterutilization.png#lightbox)

1. Select the **Health** tab at the top of the view to get a view on how the AKS infrastructure services of the cluster are doing.

    ![Screenshot showing health for a cluster.](../media/09-clusterhealth.png#lightbox)

1. Select the **Nodes** tab at the top of the view to get a detailed view of our nodes' health and pods in the cluster.

    ![Screenshot showing nodes and pods in a cluster.](../media/09-podmetrics.png#lightbox)

## View the live container logs and AKS events

In addition to the high-level overview of our cluster's health, we can also view live log data of specific containers.

To enable and set permissions for the agent to collect the data, first, create a *Role* that has access to pod logs and events. Then we'll assign permissions to users by using *RoleBinding*.

In our exercise, we want to set up *Roles* and *RoleBindings* that aren't limited to a specific namespace. We can configure *Roles* and *RoleBindings* to grant permissions and bind roles to users across the entire cluster, or to cluster resources outside a given namespace.

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

1. Select the **Controllers** tab, and choose a container to view its live logs or event logs. For example, choose the **ratings-api** container. The new view allows us to debug the status of the container.

    ![Screenshot showing an example of the event logs for an Azure Kubernetes Service cluster](../media/09-livelogs.png#lightbox)
