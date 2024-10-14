In this section, we'll [create first Apache Flink cluster](/azure/hdinsight-aks/flink/flink-create-cluster-portal) from the Azure portal. Additionally, Apache Flink clusters can also be created using [ARM templates](/azure/hdinsight-aks/create-cluster-using-arm-template-script), [PowerShell](/azure/hdinsight-aks/powershell-cluster-create), [REST API](/azure/hdinsight-aks/rest-api-cluster-creation) or [.NET SDK](/azure/hdinsight-aks/sdk-cluster-creation).  

 

## Prerequisites 

**Subscription prerequisites**: 

Ensure you meet the  [subscription prerequisites](/azure/hdinsight-aks/prerequisites-subscription) before proceeding to the next step. 

**Resource prerequisites**

- [Create a cluster pool](/azure/hdinsight-aks/quickstart-create-cluster#create-a-cluster-pool) 
- An ADLS Gen2 storage account 
- A user assigned Managed Identity 

 

**Optional resources**

- Virtual Network (VNet) and Subnet 
- Log Analytics Workspace 
- Hive metastore 

 
>[!NOTE]
>You may choose perform minimum configuration and utilize a pre-filled template. The following template will create the cluster pool, Apache Flink cluster, Storage account and managed identity: [Apache Flink Cluster One Click Deployment](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fabhishjain002%2Fgarbage-bag%2Fmain%2Ftest%2FOneClickF.json)


Let’s go over the steps to create an HDInsight on AKS Apache Flink Cluster.  

1. On the selected cluster pool page, click 'New cluster' and provide the following information: 

    :::image type="content" source="../media/flink-training.png" alt-text="Screenshot shows cluster pool page." border="true" lightbox="../media/flink-training.png":::

    |	Property	|	Description	|
    |	-	|	-	|
    |	Subscription	|	This field is autopopulated with the Azure subscription that was registered for the Cluster Pool.	|
    |	Resource Group	|	This field is autopopulated and shows the resource group on the cluster pool.	|
    |	Region	|	This field is autopopulated and shows the region selected on the cluster pool.	|
    |	Cluster Pool	|	This field is autopopulated and shows the cluster pool name where the cluster is being created. To create a cluster in a different pool, find that cluster pool in the portal and click + New cluster.	|
    |	HDInsight on AKS Pool Version	|	This field is autopopulated and shows the cluster pool version on which the cluster is now getting created.	|
    |	HDInsight on AKS Version	|	Select the minor or patch version of the HDInsight on AKS of the new cluster.	|
    |	Cluster type	|	From the drop-down list, select Apache Flink.	|
    |	Cluster name	|	Enter the name of the new cluster.	|
    |	User-assigned managed identity	|	From the drop-down list, select the managed identity to use with the cluster. If you're the owner of the Managed Service Identity (MSI), and the MSI doesn't have Managed Identity Operator role on the cluster, click the link below the box to assign the permission needed from the AKS agent pool MSI. If the MSI already has the correct permissions, no link is shown. See the Prerequisites for other role assignments required for the MSI.	|
    |	Storage account	|	From the drop-down list, select the storage account to associate with the Apache Flink cluster and specify the container name. The managed identity is further granted access to the specified storage account, using the 'Storage Blob Data Owner' role during cluster creation.	|
    |	Virtual network	|	The virtual network for the cluster.	|
    |	Subnet	|	The virtual subnet for the cluster.	|

    If you chose to enable Hive Catalog for Apache Flink SQL, switch on the 'Use Hive Catalog' toggle and provide the below details:

    |	Property	|	Description	|
    |	-	|	-	|
    |	Use Hive catalog	|	Enable this option to use an external Hive metastore.	|
    |	SQL Database for Hive	|	From the drop-down list, select the SQL Database in which to add hive-metastore tables.	|
    |	SQL admin username	|	Enter the SQL server admin username. This account is used by metastore to communicate to SQL database.	|
    |	Key vault	|	From the drop-down list, select the Key Vault, which contains a secret with password for SQL server admin username. You're required to set up an access policy with all required permissions such as key permissions, secret permissions, and certificate permissions to the MSI, which is being used for the cluster creation. The MSI needs a Key Vault Administrator role, add the required permissions using IAM.	|
    |	SQL password secret name	|	Enter the secret name from the Key Vault where the SQL database password is stored.	|


    :::image type="content" source="../media/create-cluster.png" alt-text="Screenshot shows create cluster." border="true" lightbox="../media/create-cluster.png":::

   >[!Important] 
    > For creating a cluster in new cluster pool, assign AKS agentpool MSI "Managed Identity Operator" role on the user-assigned managed identity created as part of resource prerequisite. In case you have required permissions, this step is automated during creation.
    > AKS agentpool managed identity gets created during cluster pool creation. You can identify the AKS agentpool managed identity by (your clusterpool name)-agentpool. Follow these steps to assign the role.

1. On the Configuration page, provide the node information, the [service configuration properties](/azure/hdinsight-aks/flink/flink-configuration-management) and whether you want to enable [Auto Scale](/azure/hdinsight-aks/hdinsight-on-aks-autoscale-clusters) and SSH.

    **Node Configuration**:
    
    | Property |	Description |
    | - | - |
    | Node size |	Select the node size to use for the Apache Flink nodes both head and worker nodes. |
    | Number of nodes |	Select the number of nodes for Apache Flink cluster; by default head nodes are two. The worker nodes sizing helps determine the task manager configurations for the Apache Flink. The job manager and history server are on head nodes. |

    > [!Note]
    > Virtual Machine SKU size is prefilled with the least costing recommended SKU. In the absence of any recommended SKU, it is prefilled with the SKU with the least vCores and maximum quota available at the time of cluster creation. The cluster would be created with a default constant number of five nodes. Apache Flink clusters have two head nodes.
    
    **Service Configuration**:

    | Property	| Description |
    | - | - |
    | Task manager CPU	| Integer. Enter the size of the Task manager CPUs (in cores). |
    | Task manager memory in MB	| Enter the Task manager memory size in MB. Min of 1,800 MB. |
    | Job manager CPU	| Integer. Enter the number of CPUs for the Job manager (in cores). |
    | Job manager memory in MB	| Enter the memory size in MB. Minimum of 1,800 MB.| 
    | History server CPU	| Integer. Enter the number of CPUs for the Job manager (in cores).| 
    | History server memory in MB	| Enter the memory size in MB. Minimum of 1,800 MB.|

    **Auto Scale & SSH**:
   
    | Property	| Description |
    | - | - |
    | Auto Scale | Upon selection, you would be able to choose the schedule based autoscale to configure the schedule for scaling operations. |
    | Enable SSH | Upon selection, you can opt for total number of SSH nodes required, which are the access points for the Apache Flink CLI using Secure Shell. The maximum SSH nodes allowed is 5. |
   
   
    :::image type="content" source="../media/configuration-page.png" alt-text="Screenshot shows configuration page." border="true" lightbox="../media/configuration-page.png":::

1. On the Integration page, provide the following information:

    | Property	| Description |
    | - | - |
    |Log analytics	| This feature is available only if the cluster pool has associated log analytics workspace, once enabled the logs to collect can be selected.|
    |Azure Prometheus	| This feature is to view Insights and Logs directly in your cluster by sending metrics and logs to Azure Monitor workspace.|

    You can choose to integrate with Log Analytics to monitor & collect logs for cluster pool and cluster operations on HDInsight on AKS. To enable it, turn on the switch for log Analytics under the Integrations blade. Note that Log Analytics must be enabled at cluster pool level first to enable it at a cluster level. Learn more about [how to integrate with Log Analytics](/azure/hdinsight-aks/how-to-azure-monitor-integration).

    :::image type="content" source="../media/integration-page.png" alt-text="Screenshot shows integration page." border="true" lightbox="../media/integration-page.png":::

1. Enter any tags (optional) you’d like to assign to the cluster pool on the Tags page.

   
    | Property	| Description |
    | - | - |
    | Name	| Optional. Enter a name such as HDInsight on AKS to easily identify all resources associated with your cluster resources.|
    | Value	| You can leave this blank.|
    |Resource	| Select All resources selected.|

1. Review the selected configuration on the Review+Create page. If the Validation succeeds, click on the create button. 

    :::image type="content" source="../media/review-create-page.png" alt-text="Screenshot shows review+create page." border="true" lightbox="../media/review-create-page.png":::

    After your cluster is created, you can [view the cluster details](/azure/hdinsight-aks/manage-cluster#view-cluster-details) and perform several customizations such as [manage access control](/azure/hdinsight-aks/hdinsight-on-aks-manage-authorization-profile), check [Service Health](/azure/hdinsight-aks/service-health) or [customize configurations](/azure/hdinsight-aks/service-configuration).
