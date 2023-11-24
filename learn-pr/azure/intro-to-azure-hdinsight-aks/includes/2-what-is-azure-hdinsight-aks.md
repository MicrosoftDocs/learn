HDInsight on AKS introduces the concept of cluster pools and clusters, which allow you to realize the complete value of data lakehouse. Cluster pools allow you to use multiple compute workloads on a single data lake, thereby removing the overhead of network management and resource planning.

Cluster pools are a logical grouping of clusters that help build robust interoperability across multiple cluster types and allow enterprises to have the clusters in the same virtual network. Cluster pools provide rapid and cost-effective access to all the cluster types created on-demand and at scale. One cluster pool corresponds to one cluster in AKS infrastructure.

Clusters are individual compute workloads, such as Apache Spark, Apache Flink, and Trino that can be created rapidly in few minutes with preset configurations.

You can create the pool with a single cluster or a combination of cluster types, which are based on the need and can custom configure the following options:
- Storage
- Network
- Logging
- Monitoring
  
The following diagram shows the logical technical architecture of components installed in a default cluster pool. The clusters are isolated using namespaces in AKS clusters.

:::image type="content" source="../media/overview/hdinsight-on-aks-technical-architecture.png" alt-text="Screenshot shows the HDInsight on AKS architecture." border="true" lightbox="../media/overview/hdinsight-on-aks-technical-architecture.png":::
