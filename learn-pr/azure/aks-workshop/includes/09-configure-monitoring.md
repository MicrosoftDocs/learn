The ongoing performance of our cluster relies on the fact that we can monitor the different components in your application, view logs, and get alerts whenever your application goes down or some parts of it fail. We can use a combination of available tools to set up alerting capabilities for our application.  

In this exercise, we'll explore some of these tools. First, we'll create a Log Analytics workspace and enable Azure Monitor for containers. We'll then inspect the Kubernetes event logs and monitor our cluster's health.

We also can use third party monitoring tools such as Prometheus. As a last and optional step, we'll explore such a Prometheus implementation.

Before we start with the exercise steps, let's define some of the items we've mentioned.

### What is Azure Monitor for containers?

[Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview) is a comprehensive monitoring solution for Kubernetes. This solution gives you insight into the performance of your cluster by collecting memory and processor metrics from controllers, nodes, and containers.

### What is a Log Analytics workspace?

A [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace) is a container that includes data and configuration information and is used by [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview) to store log data. We also use our workspace to manage access to the data logged.

### What is Prometheus?

[Prometheus](https://prometheus.io/) is an open-source system monitoring and alerting toolkit. Prometheus has several features that include but isn't limited to, the collection of data into a multi-dimensional data model of time series data and multiple modes of graphing and dashboarding support.

## Create a Log Analytics workspace

We'll use Azure Monitor's Log Analytics to store monitoring data, events, and metrics from our Kubernetes cluster and the applications. We'll pre-create the Log Analytics workspace in our assigned environment resource group

1. Let's sign into the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with our Azure account.

1. Run the following command to create the workspace. We'll name the workspace **aksworkshop-workspace** and use the same resource group and region as our Azure Kubernetes Service (AKS) cluster, for example, **aksworkshop** in **East US**.

    ```bash
    az resource create --resource-type Microsoft.OperationalInsights/workspaces \
            --name aksworkshop-workspace \
            --resource-group aksworkshop \
            --location eastus \
            --properties '{}' -o table
    ```

## Enable the monitoring addon

Once our workspace is ready, we can integrate the Azure Monitor for containers monitoring addon into it.

1. We need the **resource id** of our workspace to enable the addon. Run the following command and make a note of the result.

    ```bash
    az resource show --resource-type Microsoft.OperationalInsights/workspaces \
        --resource-group aksworkshop \
        --name aksworkshop-workspace \
        --query "id" -o tsv
    ```

1. Next, enable the monitoring addon by running the command below, replace the **workspace-resource-id** value with the output from the previous command.

    ```bash
    az aks enable-addons \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME \
        --addons monitoring \
        --workspace-resource-id <workspace-resource-id>
    ```

    Keep in mind that it might be several minutes before the data will appear for our cluster once we enable the monitoring addon.

## Inspect the Kubernetes event or logs and monitor  cluster health

We can view utilization reports and charts for our cluster in the Azure portal using Azure Monitor. Azure monitor gives us a global perspective of all containers deployed across our subscriptions and resource groups. From here, we can track containers that are monitored and those containers that aren't and inspect each container's statistics individually.

1. Switch to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Azure Monitor** from the left pane in the Azure portal.

1. Under the **Insights** section, select **Containers** to see a list of all clusters that we have access to.

1. Select the name of our cluster to check the cluster utilization under load. Notice how this view is again a high-level view that provides us a view on the cluster, nodes, controllers, and containers.

    [![](../media/09-clusterutilization.png "Screenshot showing a cluster utilization under load report")](../media/09-clusterutilization.png#lightbox)

1. Select the **Nodes** tab at the top of the view to get a detailed view of our deployed pods in the cluster and to identify which pods are causing trouble.

    [![](../media/09-podmetrics.png "Screenshot showing podmetrics for a cluster")](../media/09-podmetrics.png#lightbox)

## View the live container logs and Kubernetes events

In addition to the high-level overview of our cluster's health, we can also view live log data from the **Containers** tab in the Insights view using the **View live data (preview)** option.

By default, our cluster is enabled with Azure role-based access controls (RBAC). With RBAC enabled, we'll get an error when we use the view live data option in the portal. We can fix the error by setting up RBAC roles and accounts in our cluster. We'll first create a *Role* that has access to pod logs and events. Then we'll assign permissions to users using a *RoleBinding*.

In our exercise, we want to set up *Roles* and *RoleBindings that aren't limited to a specific namespace. We can configure Roles* and *RoleBindings* to grant permissions and bind roles to users across the entire cluster or to cluster resources outside a given namespace.

If our Kubernetes cluster isn't configured with Kubernetes RBAC authorization or integrated with Azure AD single-sign-on, we don't need to follow the steps above.

1. In Cloud Shell, save the YAML below as in a file named `logreader-rbac.yaml`. The file contains the instructions to create the appropriate **ClusterRole** and **ClusterRoleBinding**.

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
       name: containerHealth-log-reader
    rules:
       - apiGroups: [""]
         resources: ["pods/log", "events"]
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

1. Deploy the `logreader-rbac.yaml` configuration using `kubectl`.

    ```bash
        kubectl apply -f logreader-rbac.yaml
    ```

1. Switch back to the AKS cluster on the Azure portal.

1. Select **Insights** under **Monitoring**

1. Select the **Controllers** tab and pick a *container* to view its live logs or event logs. The new view will allow us to debug the status of the container.

    [![](../media/09-livelogs.png "Screenshot showing an example of the event logs for an Azure Kubernetes cluster")](../media/09-livelogs.png#lightbox)

## Collect Prometheus metrics (optional)

This section is optional. There are a few items that we'll have to install and configure before we can view the captured log data.

The first, we'll run an application that exposes a Prometheus endpoint. Our application has instrumentation added to it to track metrics using Prometheus client libraries.

We'll then generate traffic for the application and configure Prometheus to collect this data. 

Prometheus scrapes the collected data from our application's exposed endpoints using a `ConfigMap` template. This template allows us to specify various parameters, for example, the services to scrape and the interval between scrapes.

Finally, we'll query the collected metrics and plot visualization.

>[!NOTE]
>The minimum `omsagent` version supported by this feature is `microsoft/oms:ciprod07092019` or later.

1. In Cloud Shell, save the YAML below as `prommetrics-demo.yaml`. This file contains the service declaration to run a demo application called **prommetrics-demo**, which already has the Prometheus endpoint exposed.

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
        name: prommetrics-demo
        labels:
        app: prommetrics-demo
    spec:
        selector:
        app: prommetrics-demo
        ports:
        - name: metrics
        port: 8000
        protocol: TCP
        targetPort: 8000
        - name: http
        port: 8080
        protocol: TCP
        targetPort: 8080
        type: ClusterIP
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: prommetrics-demo
        labels:
        app: prommetrics-demo
    spec:
        replicas: 4
        selector:
        matchLabels:
            app: prommetrics-demo
        template:
        metadata:
            annotations:
            prometheus.io/scrape: "true"
            prometheus.io/path: "/"
            prometheus.io/port: "8000"
            labels:
            app: prommetrics-demo
        spec:
            containers:
            - name: prommetrics-demo
            image: vishiy/tools:prommetricsv5
            imagePullPolicy: Always
            ports:
            - containerPort: 8000
            - containerPort: 8080
    ```

1. Deploy the **prommetrics-demo** service using `kubectl`.

    ```bash
    kubectl apply -f prommetrics-demo.yaml
    ```

    This application on purpose generates “Bad Request 500” when traffic is generated and it exposes a Prometheus metric called `prommetrics_demo_requests_counter_total`.  We'll use `curl` to generate traffic to the application.

1. Find the pod in which our **prommetrics-demo** service is running.

    ```output
    kubectl get pods | grep prommetrics-demo

    prommetrics-demo-7f455766c4-gmpjb   1/1       Running   0          2m
    prommetrics-demo-7f455766c4-n7554   1/1       Running   0          2m
    prommetrics-demo-7f455766c4-q756r   1/1       Running   0          2m
    prommetrics-demo-7f455766c4-vqncw   1/1       Running   0          2m
    ```

1. Select one of the pods and log in.

    ```bash
    kubectl exec -it prommetrics-demo-7f455766c4-gmpjb bash
    ```

1. While logged on, execute curl to generate traffic.

    ```bash
    while (true); do curl 'http://prommetrics-demo.default.svc.cluster.local:8080'; sleep 5; done 
    ```

    >[!NOTE]
    >Leave the window open and keep running this. You will see “Internal Server Error” but do not close the window.

1. In Cloud Shell, save the below `ConfigMap` template YAML to a file name `configmap.yml`.

    This `ConfigMap` is pre-configured to scrape the application pods and collect Prometheus metric `prommetrics_demo_requests_counter_total` from the demo application in 1-minute intervals.

    ```yaml
    kind: ConfigMap
    apiVersion: v1
    data:
      schema-version: 
        #string.used by agent to parse config. supported versions are {v1}. Configs with other schema versions will be rejected by the agent.
        v1
      config-version:
        #string.used by customer to keep track of this config file's version in their source control/repository (max allowed 10 chars, other chars will be truncated)
        ver1noprom
      log-data-collection-settings: |-
        # Log data collection settings
        [log_collection_settings]
           [log_collection_settings.stdout]
              # In the absense of this configmap, default value for enabled is true
              enabled = true
              # exclude_namespaces setting holds good only if enabled is set to true
              # kube-system log collection is disabled by default in the absence of 'log_collection_settings.stdout' setting. If you want to enable kube-system, remove it from the following setting.
              # If you want to continue to disable kube-system log collection keep this namespace in the following setting and add any other namespace you want to disable log collection to the array.
              # In the absense of this configmap, default value for exclude_namespaces = ["kube-system"]
              exclude_namespaces = ["kube-system", "no-logs"]

           [log_collection_settings.stderr]
              # Default value for enabled is true
              enabled = true
              # exclude_namespaces setting holds good only if enabled is set to true
              # kube-system log collection is disabled by default in the absence of 'log_collection_settings.stderr' setting. If you want to enable kube-system, remove it from the following setting.
              # If you want to continue to disable kube-system log collection keep this namespace in the following setting and add any other namespace you want to disable log collection to the array.
              # In the absense of this cofigmap, default value for exclude_namespaces = ["kube-system"]
              #exclude_namespaces = ["kube-system"]

           [log_collection_settings.env_var]
              # In the absense of this configmap, default value for enabled is true
              enabled = false
      prometheus-data-collection-settings: |-
        # Custom Prometheus metrics data collection settings
        [prometheus_data_collection_settings.cluster]
            # Cluster level scrape endpoint(s). These metrics will be scraped from agent's Replicaset (singleton)

            #Interval specifying how often to scrape for metrics. This is duration of time and can be specified for supporting settings by combining an integer value and time unit as a string value. Valid time units are ns, us (or µs), ms, s, m, h.
            interval = "1m"

            fieldpass = ["prommetrics_demo_requests_counter_total"]
            # fielddrop = []

            # An array of urls to scrape metrics from.
            # urls = []

            # An array of Kubernetes services to scrape metrics from kube-state-metrics
            # kubernetes_services = []

            # When monitor_kubernetes_pods = true, replicaset will scrape Kubernetes pods for the following prometheus annotations:
            # below will scrape, demo app (:8000/)
            monitor_kubernetes_pods = true
        [prometheus_data_collection_settings.node]
            # Node level scrape endpoint(s). These metrics will be scraped from agent's DaemonSet running in every node in the cluster

            #Interval specifying how often to scrape for metrics. This is duration of time and can be specified for supporting settings by combining an integer value and time unit as a string value. Valid time units are ns, us (or µs), ms, s, m, h.
            interval = "1m"

            # An array of urls to scrape metrics from. $NODE_IP (all upper case) will substitute of running Node's IP address
            # urls = []

            fieldpass = ["metric_to_pass"]
            fielddrop = ["metric_to_drop"]

    metadata:
      name: container-azm-ms-agentconfig
      namespace: kube-system
    ```

1. Deploy the `configmap.yaml` file using `kubectl`.

    ```bash
    kubectl apply -f configmap.yaml
    ```

1. In the portal, go to the AKS overview page and click **Logs** in the table of contents under **Monitor** to access Log Analytics.

1. Query the Prometheus metrics and plot a chart by copying the query below and selecting run.
n7-0
    ```command
    InsightsMetrics
      | where Name == "prommetrics_demo_requests_counter_total"
      | extend dimensions=parse_json(Tags)
      | extend request_status = tostring(dimensions.request_status)
      | where request_status == "bad"
      | project request_status, Val, TimeGenerated | render timechart
    ```

    You should be able to plot a chart based on the Prometheus metrics collected.

    [![](../media/09-prommetric.png "Screenshot showing Prometheus metrics collected for an AKS cluster")](../media/09-prommetric.png#lightbox)
