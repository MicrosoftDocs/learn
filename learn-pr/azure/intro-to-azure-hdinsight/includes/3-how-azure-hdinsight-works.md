Here, you'll learn how Azure works. You'll learn all about the following components and how they fit together to provide data control and management:

- Apache Hadoop
- HDInsight storage
- HDInsight processing

## What is Apache Hadoop?

Apache Hadoop <!--Andy, please verify edit--> is a cloud distributed data processing system that lies at the core of HDInsight. It consists of three components, which the following table describes.

| Apache Hadoop Component | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| HDFS              | The Apache Hadoop Distributed File System (HDFS) is used to provide storage for the system. |
| YARN                    | The Apache Hadoop Yet Another Resource Negotiator (YARN) component provides the processing for the system. |
| MapReduce           | MapReduce is a programming model that enables you to process and analyze data. |

### How do the components interact?

The following diagram depicts a representation of the interaction between the storage and processing components in a typical Hadoop cluster in HDInsight. The following components are depicted:

- Head node and worker node. Nodes in the cluster perform the processing.
- Within the nodes, HDFS interacts with Windows Azure Storage Blob (WASB) storage.
- Azure Blob storage is accessible to the two nodes. Default, linked storage, and unlinked storage is available, each supporting a number of containers.

:::image type="content" source="../media/overall.png" alt-text="A diagram depicting the interactions described in the preceding text.":::

Let's now examine how storage and processing work.

## How does storage work?

The storage component of a cluster is not created automatically when you provision an HDInsight cluster. Instead, it is provided by an HDFS-compliant system such as:

- Azure Storage
- Azure Data Lake

There are benefits in separating the storage component of the cluster from the processing component. For example, you can safely delete any HDInsight clusters used only for computation without worrying about losing data. When you're adding an HDInsight cluster, you must define a default file system.

> [!IMPORTANT]
> For Azure Storage, you must specify a blob container as the default file system.

Providing a default file system helps ensure that HDInsight can resolve relative file references when searching for files.

> [!TIP]
> When you want to increase available storage, you can link and unlink additional file systems as required.

:::image type="content" source="../media/storage.png" alt-text="A diagram depicting only the storage element from the previous diagram.":::

## How does processing work?

When processing data, the compute component of a Hadoop cluster on HDInsight is broken down into two logical areas. These are described in the following table.

| Component   | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| Head node   | The head node is responsible for accepting and managing client requests and passing the request to the worker nodes. |
| Worker node | The worker nodes are responsible for processing the data.    |

> [!NOTE]
> The head node is sometimes referred to as a master node.

Most clusters contain two head nodes. These are:

- An active head node. This node manages the client connections.
- A passive head node. This node provides resilience in the event the active node should go offline.

:::image type="content" source="../media/processing.png" alt-text="A diagram depicting the processing element in a typical Hadoop cluster.":::

Both the head and worker nodes can connect either directly to a locally attached HDFS, or access data that is stored in Azure Blob or Azure Data Lake. The data managed is dependent on the following factors:

- How the MapReduce programming model has defined how to work with the data
- How the head node allocates the work

### What does YARN do?

The YARM performs the resource management within an HDInsight cluster. When you're processing data, this service manages resources and job scheduling.

YARN sits between the HDFS and the computation system of the HDInsight cluster. It works with the head node to help distribute the job across the worker nodes of the cluster. This helps to ensure that the data processing jobs are parallelized.
