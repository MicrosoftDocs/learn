AKS clusters will automatically generate platform metrics that track such information as the processor and memory utilization of the node pool. You can view these metrics on the **Monitoring** tab of the **Overview** page for the cluster in the Azure portal or by using metrics explorer in Azure Monitor. 

:::image type="content" source="../media/2-aks-overview-page.png" lightbox="../media/2-aks-overview-page.png" alt-text="Screenshot of overview page for AKS cluster showing metric charts.":::

When you enable Container insights for the cluster, it collects more performance and log data and provides various methods for analysis. You can use prebuilt workbooks in the Azure portal that provide curated views of the most important data collected for your cluster and its workloads. Or use standard Azure Monitor features such as Log Analytics and Metrics Explorer to perform your own ad-hoc analysis.

:::image type="content" source="../media/2-container-insights-cluster-page.png" lightbox="../media/2-container-insights-cluster-page.png" alt-text="Screenshot of Cluster page in Container insights for AKS cluster.":::


Container insights isn't enabled by default for AKS clusters. You can either enable it for an existing cluster or have it enabled when you create a new cluster. In this module, you’ll use the Azure portal to enable it, but other methods are available including CLI, ARM, and Terraform.  

Data collected by Container insights is stored in a Log Analytics workspace. You can create as many workspaces as you want, but it's easier to query and manage your data if you use a single workspace for your clusters and resource logs. Container insights will offer to use a default workspace for you when you enable it using the Azure portal, but you can choose to use one that already exists in your subscription.

:::image type="content" source="../media/2-container-insights-overview-diagram.png" lightbox="../media/2-container-insights-overview-diagram.png" alt-text="Diagram of Container insights showing data collection paths.":::
