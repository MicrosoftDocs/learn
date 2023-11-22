Let's review the features and uses of HDInsight on AKS. This overview will help you evaluate whether HDInsight on AKS addresses your organization's requirements.

## What is big data?

The term *big data* describes the vast volumes of structured *and* unstructured data that organizations collect. This data can be extremely useful for organizations. Specifically, if an organization can analyze the data for insights, it's better able to make decisions. The result is that these decisions can help an organization become more successful. For example, big-data analysis might enable a commercial organization to recognize customer habits, which could lead to increased sales.

## Azure HDInsight on AKS

HDInsight on AKS is a modern, reliable, secure, and fully managed Platform as a Service (PaaS) that runs on Azure Kubernetes Service (AKS).

Key features include:
- Fast cluster creation and scaling.
- Ease of maintenance and periodic security updates.
- Cluster resiliency powered by modern cloud-native AKS.
- Native support for modern auth with OAuth, and Microsoft Entra ID.
- Deep integration with Azure Services – Azure Data Factory (ADF), Power BI, Azure Monitor.
- Supports the use of open-source frameworks, such as:
  - Apache Spark
  - Apache Flink
  - Trino

HDInsight on AKS provides several benefits for organizations that are working with big data. It's:

- **Open-source**: Enables you to create optimized clusters for various open-source frameworks.
- **Reliable**: Provides an end-to-end SLA for all production workloads.
- **Auto Scale**: Enables you to Load based [Auto Scale](https://learn.microsoft.com/azure/hdinsight-aks/hdinsight-on-aks-autoscale-clusters#create-a-cluster-with-load-based-auto-scale), and Schedule based [Auto Scale](https://learn.microsoft.com/azure/hdinsight-aks/hdinsight-on-aks-autoscale-clusters#create-a-cluster-with-load-based-auto-scale) workloads to respond to demand changes. And also enables you to protect your enterprise data assets through integration with:
  - Azure Virtual Network
  - Azure encryption technologies
  - Microsoft Entra ID

  > [!TIP]
   > By creating clusters on demand, you can reduce your costs. You pay only for what you use.
  
- **Security**: Support for ARM RBAC, Support for MSI based authentication, Option to provide [cluster access](https://learn.microsoft.com/azure/hdinsight-aks/hdinsight-on-aks-manage-authorization-profile) to other users.
- **Storage**: ADLS Gen2 [Storage support](https://learn.microsoft.com/azure/hdinsight-aks/cluster-storage).

- **Metastore**: External Metastore support for [Trino](https://learn.microsoft.com/azure/hdinsight-aks/trino/trino-connect-to-metastore), [Spark](https://learn.microsoft.com/azure/hdinsight-aks/spark/use-hive-metastore) and [Flink](https://learn.microsoft.com/azure/hdinsight-aks/flink/use-hive-metastore-datastream), Integrate with [HDInsight](https://learn.microsoft.com/azure/hdinsight-aks/overview#connectivity-to-hdinsight).
- **Logging and Monitoring**: Log aggregation in Azure [log analytics](https://learn.microsoft.com/azure/hdinsight-aks/how-to-azure-monitor-integration), for server logs, Cluster and Service metrics via [Managed Prometheus and Grafana](https://learn.microsoft.com/azure/hdinsight-aks/monitor-with-prometheus-grafana), Support server metrics in [Azure monitor](https://learn.microsoft.com/azure/azure-monitor/overview), Service Status page for monitoring the Service health

## Concept in HDInsight on AKS

In HDInsight on AKS, two new concepts are introduced:

- Cluster Pools are used to group and manage clusters.
- Clusters are used for open source computes, they're hosted within a cluster pool.

### Cluster Pools

HDInsight on AKS runs on Azure Kubernetes Service (AKS). The top-level resource is the Cluster Pool and manages all clusters running on the same AKS cluster. When you create a Cluster Pool, an underlying AKS cluster is created at the same time to host all clusters in the pool. Cluster pools are a logical grouping of clusters, which helps in building robust interoperability across multiple cluster types and allow enterprises to have the clusters in the same virtual network. Cluster pools provide rapid and cost-effective access to all the cluster types created on-demand and at scale.One cluster pool corresponds to one cluster in AKS infrastructure.

### Clusters

Clusters are individual open source compute workloads, such as Apache Spark, Apache Flink, and Trino, which can be created rapidly in few minutes with preset configurations and few clicks. Though running on the same cluster pool, each cluster can have its own configurations, such as cluster type, version, node VM size, node count. Clusters are running on separated compute resources with its own DNS and endpoints.

### Versions

Azure HDInsight on AKS has the concept of Cluster pools and Clusters, which tie together essential component versions such as packages and connectors with a specific open-source component. Each of the version upgrade periodically includes new improvements, features, and patches.

Each number in the version indicates general compatibility with the previous version

- **Major versions** change when incompatible API updates or backwards compatibility may be broken.
- **Minor versions** change when functionality updates are made that are backwards compatible with the other minor releases (except for new feature additions or core security fixes/platform updates controlled by upstream).
- **Patch versions** change when backwards compatible bug fixes are made to a minor version.


### Enterprise security

Enterprise readiness for any software requires stringent security checks to prevent and address threats that may arise. HDInsight on AKS provides a multi-layered security model to protect you on multiple layers. The security architecture uses modern authorization methods using MSI. All the storage access is through MSI, and the database access is through username/password. The password is stored in Azure Key Vault, defined by the customer. This makes the setup robust and secure by default.

The below diagram illustrates a high-level technical architecture of security in HDInsight on AKS.

:::image type="content" source="../media/security-concept.png" alt-text="Screenshot shows a high-level technical architecture of security in HDInsight on AKS." lightbox="../media/security-concept.png":::

**Enterprise security** is divided into four main groups based on the type of control. These groups are also called security pillars and are of the following types: 

- Perimeter security
- Authentication
- Authorization
- Encryption

### Azure Monitor integration

HDInsight on AKS offers an integration with Azure Monitor that can be used to monitor cluster pools and their clusters.

Azure Monitor collects metrics and logs from multiple resources into an Azure Monitor Log Analytics workspace, which presents the data as structured, queryable tables that can be used to configure custom alerts. Azure Monitor logs provide an excellent overall experience for monitoring workloads and interacting with logs, especially if you have multiple clusters.


### Customize clusters

Azure HDInsight on AKS provides a configuration method called  Script Actions that invoke custom scripts to customize the cluster. These scripts can be used to install more packages/jars and change configuration settings. The Script actions can be used only during cluster creation. Post cluster creation script actions are in the roadmap. Currently Script Actions are available only with Spark clusters.


