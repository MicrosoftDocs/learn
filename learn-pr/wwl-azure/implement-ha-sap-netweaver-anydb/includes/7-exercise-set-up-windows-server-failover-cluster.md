Setting up a Windows Server failover cluster for an SAP ASCS/SCS instance involves these tasks:

- Add cluster nodes to the cluster.
- Configure Cloud Witness.

## Add cluster nodes to the cluster

Set up the failover cluster by using Failover Cluster Manager:

1. In Failover Cluster Manager, select **Create Cluster**, and then add only the name of the first cluster (node A). Don't add the second node yet; you add the second node in a later step.
2. Enter the network name (virtual host name) of the cluster.
3. After you've created the cluster, run a cluster validation test.
4. You can ignore any warnings about disks at this point in the process. At this stage, you don't need to worry about having a quorum.
5. Bring the cluster virtual host name online.
6. Add the second cluster node.

## Configure Cloud Witness

To configure Cloud Witness, you must have a valid Azure Storage Account which can be used to store the blob file (used for arbitration). Cloud Witness creates a well-known Container **msft-cloud-witness** under the Microsoft Storage Account. Cloud Witness writes a single blob file with the corresponding cluster's unique ID used as the file name of the blob file under this msft-cloud-witness container. This means that you can use the same Microsoft Azure Storage Account to configure a Cloud Witness for multiple different clusters.

When you use the same Azure Storage Account for configuring Cloud Witness for multiple different clusters, a single msft-cloud-witness container gets created automatically. This container will contain one-blob file per cluster.

When creating a storage account, keep in mind that:

- You can't use a Blob storage account for a Cloud Witness.
- You can't use Azure Premium Storage for a Cloud Witness.
- For Replication, select Locally redundant storage (LRS). Failover Clustering uses the blob file as the arbitration point, which requires some consistency guarantees when reading the data. Therefore you must select Locally redundant storage for Replication type.

When you create a storage account, it's associated with two Access Keys that are automatically generated - Primary Access key and Secondary Access key. For a first-time creation of Cloud Witness, use the Primary Access Key. There is no restriction regarding which key to use for Cloud Witness. You can identify the values of a Storage Account keys directly from the Azure portal or programmatically.

When you create a Storage Account, the following URLs are generated using the format: `https://[Storage Account Name].[Storage Type].[Endpoint];`. Cloud Witness always uses Blob as the storage type. Azure uses .core.windows.net as the Endpoint. When configuring Cloud Witness, you can configure it with a different endpoint as per your scenario (for example the Microsoft Azure datacenter in China has a different endpoint).

> [!NOTE]
> The endpoint URL is generated automatically by Cloud Witness resource and there's no extra step of configuration necessary for the URL.

### To configure Cloud Witness as a Quorum Witness

1. Launch Failover Cluster Manager.
2. Right-click the cluster -&gt; **More Actions** \-&gt; **Configure Cluster Quorum Settings**. This launches the Configure Cluster Quorum wizard.
3. On the **Select Quorum Configurations** page, select **Select the quorum witness**.
4. On the **Select Quorum Witness** page, select **Configure a cloud witness**.
5. On the **Configure Cloud Witness** page, enter the following information:

     - (Required parameter) **Azure Storage Account Name**.
     - (Required parameter) **Access Key** corresponding to the Storage Account.

         - When creating for the first time, use **Primary Access Key**
         - When rotating the Primary Access Key, use **Secondary Access Key**
     - (Optional parameter) If you intend to use a different Azure service endpoint (for example the Microsoft Azure service in China), then update the **endpoint server name**.

Upon successful configuration of Cloud Witness, you can view the newly created witness resource in the Failover Cluster Manager snap-in.

When configuring a Cloud Witness as a quorum witness for your Failover Cluster, consider the following:

- Instead of storing the Access Key, your Failover Cluster will generate and securely store a Shared Access Security (SAS) token.
- The generated SAS token is valid as long as the Access Key remains valid. When rotating the Primary Access Key, it's important to first update the Cloud Witness (on all your clusters that are using that Storage Account) with the Secondary Access Key before regenerating the Primary Access Key.
- Cloud Witness uses HTTPS REST interface of the Azure Storage Account service. This means it requires the HTTPS port to be open on all cluster nodes.

## Configure failover detection parameters

After you successfully install the Windows failover cluster, you need to change some thresholds so they adapt failover detection to conditions in Azure. Assuming that your two virtual machines that make up the Windows cluster configuration for ASCS/SCS are in the same subnet, change the following parameters to these values:

- **SameSubNetDelay** = 2000
- **SameSubNetThreshold** = 15
- **RoutingHistoryLength** = 30

These settings were tested with customers. They're resilient enough, but they also provide failover that's fast enough in real error conditions on an SAP software or in a node or virtual machine failure.
