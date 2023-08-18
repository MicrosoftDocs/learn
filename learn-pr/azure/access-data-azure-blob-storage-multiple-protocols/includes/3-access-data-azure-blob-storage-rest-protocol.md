Now that you understand the use-case scenarios for object storage, you can explore how to access data from users or client applications. Blob Storage supports multiple protocols for data access.

## Multiprotocol access for object storage

By enabling multiprotocol support for data that resides in Blob Storage, your company can eliminate data silos, which occur when different data sources are stored in separate locations. Your company will also no longer need to refactor the data prior to moving it to the cloud. This is because Blob Storage allows users to choose different tools to work directly with all the data they need.

:::image type="content" source="../media/3-azure-blob-storage-architecture.svg" alt-text="Illustration depicting Azure Blob Storage and the supported protocols used to access data stored in a hierarchical file system." lightbox="../media/3-azure-blob-storage-architecture.svg":::

### REST protocol support for Azure Blob Storage

When you use Blob Storage, you don’t have to maintain a separate storage solution for object storage and analytics storage. Blob APIs and Azure Data Lake Storage Gen2 APIs can operate on the same data in storage accounts that have a hierarchical namespace.

Azure Data Lake Storage Gen2 is primarily designed to work with Hadoop and all frameworks that use the Apache HDFS as their data access layer. Hadoop distributions include the Azure Blob File System (ABFS) driver, which enables many applications and frameworks to access Azure Blob Storage data directly.

Users or client applications can access objects in Blob Storage by using the HTTP or HTTPS protocols from anywhere in the world. They can also access objects in Blob Storage by using the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library.

### Using the HDFS CLI with Azure Data Lake Storage Gen2

Azure Data Lake Storage Gen2 allows you to access a data container by using the shell that directly interacts with HDFS and any other Hadoop-supported file systems. You can use the following example to connect to your Hadoop Cluster running in Azure by using a secure shell (SSH) connection, and then running some basic HDFS commands.

First, establish remote access to services. If you opt to use SSH, you could use the following sample code:

```azurecli 
# Connect to the cluster via SSH.

ssh sshuser@clustername-ssh.azurehdinsight.net

# Execute basic HDFS commands. Display the hierarchy.

hdfs dfs -ls /

# Create a sample directory.

hdfs dfs -mkdir /samplefolder

# Create a container

hdfs dfs -D "fs.azure.createRemoteFileSystemDuringInitialization=true" -ls abfs://<container-name>@<storage-account-name>.dfs.core.windows.net/

# Get a list of files or directories

hdfs dfs -ls <path>
```

Your company can maintain the same storage solution for both object storage and analytics storage. You can use existing tools, applications, and services to access data in Blob Storage that have a hierarchical namespace, without having to modify your solution depending on the data.
