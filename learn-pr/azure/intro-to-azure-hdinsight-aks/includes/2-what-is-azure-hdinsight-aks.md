HDInsight on AKS introduces the concept of cluster pools and clusters, which allow you to realize the complete value of data lakehouse. Cluster pools allow you to use multiple compute workloads on a single data lake, thereby removing the overhead of network management and resource planning.

Cluster pools are a logical grouping of clusters that help build robust interoperability across multiple cluster types and allow enterprises to have the clusters in the same virtual network. Cluster pools provide rapid and cost-effective access to all the cluster types created on-demand and at scale. One cluster pool corresponds to one cluster in AKS infrastructure.

Clusters are individual compute workloads, such as Apache Spark, Apache Flink, and Trino that can be created rapidly in few minutes with preset configurations.

You can create the pool with a single cluster or a combination of cluster types, which are based on the need and can custom configure the following options:
- Storage
- Network
- Logging
- Monitoring
  
The following diagram shows the logical technical architecture of components installed in a default cluster pool. The clusters are isolated using namespaces in AKS clusters.

:::image type="content" source="../media/hdinsight-on-aks-technical-architecture.png" alt-text="Screenshot shows the HDInsight on AKS architecture." border="true" lightbox="../media/hdinsight-on-aks-technical-architecture.png":::

## Storage

Azure HDInsight on AKS can seamlessly integrate with Azure Storage, which is a general-purpose storage solution that works well with many other Azure services. Azure Data Lake Storage Gen2 (ADLS Gen 2) is the default file system for the clusters.
The storage account could be used as the default location for data, cluster logs, and other output that are generated during cluster operation. It could also be a default storage for the Hive catalog that depends on the cluster type.

Azure HDInsight on AKS uses managed identities (MSI) to secure cluster access to files in Azure Data Lake Storage Gen2. Managed identity is a feature of Microsoft Entra ID that provides Azure services with a set of automatically managed credentials. These credentials can be used to authenticate to any service that supports Active Directory authentication. Moreover, managed identities don't require you to store credentials in code or configuration files.

In Azure HDInsight on AKS, once you select a managed identity and storage during cluster creation, the managed identity can seamlessly work with storage for data management, provided the Storage Blob Data Owner role is assigned to the user-assigned MSI.

The following diagram provides an abstract view of the Azure HDInsight on AKS architecture of Azure Storage.

:::image type="content" source="../media/storage-architecture.png" alt-text="Screenshot showing storage architecture." lightbox="../media/storage-architecture.png":::
