> [!IMPORTANT]
> The modules in this learning path form a progression. To complete this exercise, you need to first complete the [preceding modules in this path](/training/paths/get-started-azure-arc-sql-managed-instance/).

## Exercise 1 - Configuring readable secondaries

In this exercise, you'll configure and use readable secondaries to take advantage of the secondary replica for read-only workloads.

1. Open Azure Data Studio.
1. Expand the **Connections** Tab.
1. Expand **Azure Arc Controllers**.
1. Expand the data controller.
1. Set up the following details for the Business Critical Tier Arc-enabled SQL Managed Instance:

    ```powershell
    $Env:SQLMIName = 'enter Business Critical Tier SQL Managed Instance Name here'
    $Env:MyNamespace = 'enter data controller namespace here'
    $Env:MyReadableSecondaries = 2
    ```

1. Execute the following command to review the current Arc-enabled SQL Managed Instance configuration. Search for replicas to review the current configuration:

    ```powershell
    az sql mi-arc show -n $Env:SQLMIName `
        --k8s-namespace $Env:MyNamespace `
        --use-k8s
    ```

    ```output
     "replicas": [
        {
          "availabilityMode": "SYNCHRONOUS_COMMIT",
          "connectedState": "CONNECTED",
          "replicaName": "ae-msl-sqlmi2-0",
          "role": "PRIMARY",
          "secondaryRoleAllowConnections": "ALL",
          "synchronizationState": "HEALTHY"
        },
        {
          "availabilityMode": "SYNCHRONOUS_COMMIT",
          "connectedState": "CONNECTED",
          "replicaName": "ae-msl-sqlmi2-1",
          "role": "SECONDARY",
          "secondaryRoleAllowConnections": "ALL",
          "synchronizationState": "HEALTHY"
        },
        {
          "availabilityMode": "SYNCHRONOUS_COMMIT",
          "connectedState": "CONNECTED",
          "replicaName": "ae-msl-sqlmi2-2",
          "role": "SECONDARY",
          "secondaryRoleAllowConnections": "NO",
          "synchronizationState": "HEALTHY"
        }
      ]
    ```

1. Execute the following command to configure two readable secondaries:

    ```powershell
    az sql mi-arc update --name $Env:SQLMIName `
        --readable-secondaries $Env:MyReadableSecondaries `
        --k8s-namespace $Env:MyNamespace `
        --use-k8s
    ```

   ![Screenshot of configuring readable secondaries.](../media/exercise1-configure-readable-secondaries-1.png)

1. Re-execute step 6 to view the new configuration. Both `ae-msl-sqlmi2-1` and `ae-msl-sqlmi2-2` are now configured as readable secondaries.

    ```output
    "replicas": [
        {
          "availabilityMode": "SYNCHRONOUS_COMMIT",
          "connectedState": "CONNECTED",
          "replicaName": "ae-msl-sqlmi2-0",
          "role": "PRIMARY",
          "secondaryRoleAllowConnections": "ALL",
          "synchronizationState": "HEALTHY"
        },
        {
          "availabilityMode": "SYNCHRONOUS_COMMIT",
          "connectedState": "CONNECTED",
          "replicaName": "ae-msl-sqlmi2-1",
          "role": "SECONDARY",
          "secondaryRoleAllowConnections": "ALL",
          "synchronizationState": "HEALTHY"
        },
        {
          "availabilityMode": "SYNCHRONOUS_COMMIT",
          "connectedState": "CONNECTED",
          "replicaName": "ae-msl-sqlmi2-2",
          "role": "SECONDARY",
          "secondaryRoleAllowConnections": "ALL",
          "synchronizationState": "HEALTHY"
        }
      ]
    ```

1. Search the results from the CLI command you executed in step 8. Search for endpoints. Retrieve the secondary endpoint value.
1. In the **Connections** tab, select **New Connection**. Enter the connection details for your secondary endpoint.
1. Select **Connect**.
1. Open a new query window for the new secondary endpoint connection and execute the following commands. Your server name shouldn't be the current primary replica:

    ```sql
    Select @@ServerName;

    Use AdventureWorks2019
    GO

    Select *
    From HumanResources.Employee;
    ```

## Exercise 2 - Discover Azure Arc-enabled SQL Managed Instance General Purpose tier

For this exercise, you'll simulate the failure or loss of the Kubernetes pod hosting and running the General Purpose tier Arc-enabled SQL Managed Instance container.

1. Open Azure Data Studio.
1. Expand the **Connections** Tab.
1. Right-click your General Purpose tier SQL Managed Instance and select **New Query**.
1. Execute the following query to show access to the instance of SQL Server and the AdventureWorks2019 database:

   ```sql
   Select @@ServerName;

   Use AdventureWorks2019
   GO

   Select *
   From HumanResources.Employee;
   ```

1. Open the Terminal window.
1. Execute the following commands to view the Kubernetes pods:

   ```powershell
   $Env:MyNamespace = 'enter your data controller namespace here'
   kubectl get pods -n $Env:MyNamespace
   ```

   ![Screenshot of SQL Managed Instance General Purpose tier high-availability pods kubectl results for this namespace.](../media/exercise2-manage-general-purpose-pods-1.png)

1. Simulate a pod failure by executing the following command:

   ```powershell
   $Env:MyGPPod = 'enter SQL Managed Instance Name here-0'
   kubectl delete pod $Env:MyGPPod -n $Env:MyNamespace 
   ```

   ![Screenshot of SQL Managed Instance General Purpose tier HA Pods 2.](../media/exercise2-manage-general-purpose-pods-2.png)

1. Execute the following command to view the status of the pods:

   ```powershell
   kubectl get pods -n $Env:MyNamespace
   ```

   ![Screenshot of SQL Managed Instance General Purpose tier HA Pods 3.](../media/exercise2-manage-general-purpose-pods-3.png)

1. Re-execute step 8 to monitor the pod redeployment. Once the pod is back in a running state, you can perform standard checks to ensure the SQL Server instance is available and functioning as required.

    ![Screenshot of SQL Managed Instance General Purpose tier high availability pods 4.](../media/exercise2-manage-general-purpose-pods-4.png)

1. Re-execute step 4 to see if the instance is available again. This proves your instance is available and accessible again.

## Exercise 3 - Discovering Arc-enabled SQL Managed Instance Business Critical Tier High Availability

For this exercise, you'll simulate the failure or loss of the Kubernetes pod hosting and running the Business Critical Tier Arc-enabled SQL Managed Instance container.

1. Open Azure Data Studio.
1. Expand the **Connections** Tab.
1. Right-click your Business Critical tier SQL Managed Instance and select **New Query**.
1. Execute the following query to show access to the SQL Server instance and the AdventureWorks2019 database:

   ```sql
   Select @@ServerName;
 
   Use AdventureWorks2019
   GO

   Select *
   From HumanResources.Employee;
   ```

1. Open the Terminal window.
1. Execute the following commands to view the Kubernetes pods:

   ```powershell
   $Env:MyNamespace = 'enter your data controller namespace here'
   kubectl get pods -n $Env:MyNamespace
   ```

   ![Screenshot of SQL Managed Instance Business Critical Tier high availability pods 1.](../media/exercise2-manage-business-critical-pods-1.png)

1. Simulate a pod failure by executing the following command:

   ```powershell
   $Env:MyBCPod = 'enter SQL Managed Instance Name here-0'
   kubectl delete pod $Env:MyBCPod -n $Env:MyNamespace 
   ```

   ![Screenshot of the delete pod command.](../media/exercise2-manage-business-critical-pods-2.png)

1. Execute the following command to view the status of the pods:

   ```powershell
   kubectl get pods -n $Env:MyNamespace
   ```

   ![Screenshot of pods, showing newly started pod.](../media/exercise2-manage-business-critical-pods-3.png)

1. Re-execute step 4 to determine if the instance is available and running on `SQLMI-1`. Service disruption should be minimal, and your applications need reconnect functionality.

1. Execute the following command to view the contained availability group status:

    ```powershell
    $Env:MyResource-group = 'enter your resource group name here'
    az sql mi-arc list --k8s-namespace $Env:MyNamespace --use-k8s
    ```

1. Check the status of all replicas in the contained availability group with the following command. Search for `highAvailability` in the output:

    ```powershell
    $Env:SQLMIName = 'enter your SQLMI name here'
    az sql mi-arc show --name $Env:SQLMIName --resource-group $Env:MyresourceGroup
    ```

    ```output
    "highAvailability": {
            "healthState": "Healthy",
            "lastUpdateTime": "2022-06-07T00:39:38.927189Z",
            "mirroringCertificate": "-----BEGIN CERTIFICATE-----\n \n-----END CERTIFICATE-----\n",
            "replicas": [
              {
                "availabilityMode": "SYNCHRONOUS_COMMIT",
                "connectedState": "CONNECTED",
                "replicaName": "ae-msl-sqlmi2-0",
                "role": "SECONDARY",
                "secondaryRoleAllowConnections": "ALL",
                "synchronizationState": "HEALTHY"
              },
              {
                "availabilityMode": "SYNCHRONOUS_COMMIT",
                "connectedState": "CONNECTED",
                "replicaName": "ae-msl-sqlmi2-1",
                "role": "PRIMARY",
                 "secondaryRoleAllowConnections": "ALL",
                "synchronizationState": "HEALTHY"
              },
              {
                "availabilityMode": "SYNCHRONOUS_COMMIT",
                 "connectedState": "CONNECTED",
                "replicaName": "ae-msl-sqlmi2-2",
                "role": "SECONDARY",
                "secondaryRoleAllowConnections": "ALL",
                "synchronizationState": "HEALTHY"
              }
            ]
          }
    ```

1. Prepare for a manual failover from the existing primary replica (`'your sqlmi name-1'`) back to the original primary replica  (`'your sqlmi name-0'`). In the Terminal window, execute the following commands to set the preferred primary replica:

   ```PowerShell
   $Env:MyPreferredPrimaryReplica = 'your sqlmi name-1'
   az sql mi-arc update --name $Env:SQLMIName `
     --k8s-namespace $Env:MyNamespace `
     --use-k8s `
     --preferred-primary-replica $Env:MyPreferredPrimaryReplica
   ```

   ![Screenshot of SQL Managed Instance Business Critical tier high availability manual failover.](../media/exercise3-manage-business-critical-manual-failover-1.png)

1. Run the `az sql mi-arc update` CLI command from step 12 again to perform the actual failover.

1. Run step 11 again to confirm the changed primary replica roles.

   ```output
   "highAvailability": {
           "healthState": "Healthy",
           "lastUpdateTime": "2022-06-07T00:39:38.927189Z",
           "mirroringCertificate": "-----BEGIN CERTIFICATE-----\n \n-----END CERTIFICATE-----\n",
           "replicas": [
             {
               "availabilityMode": "SYNCHRONOUS_COMMIT",
               "connectedState": "CONNECTED",
               "replicaName": "ae-msl-sqlmi2-0",
               "role": "PRIMARY",
               "secondaryRoleAllowConnections": "ALL",
               "synchronizationState": "HEALTHY"
             },
             {
               "availabilityMode": "SYNCHRONOUS_COMMIT",
               "connectedState": "CONNECTED",
               "replicaName": "ae-msl-sqlmi2-1",
               "role": "SECONDARY",
               "secondaryRoleAllowConnections": "ALL",
               "synchronizationState": "HEALTHY"
             },
             {
               "availabilityMode": "SYNCHRONOUS_COMMIT",
               "connectedState": "CONNECTED",
               "replicaName": "ae-msl-sqlmi2-2",
               "role": "SECONDARY",
               "secondaryRoleAllowConnections": "ALL",
               "synchronizationState": "HEALTHY"
             }
           ]
         }
   ```

## Exercise 4 - Point-in-time restores

For this exercise, you'll use the automated backups already created for the AdventureWorks2019 database restored to the Arc-enabled SQL Managed Instance environment previously.

1. Open Azure Data Studio.
1. Expand the **Connections** Tab.
1. Expand **Azure Arc Controllers**.
1. Expand the Arc data controller.
1. Right-click your Arc-enabled SQL Managed Instance and select **Manage**.
1. Select **Backups**.
1. Review the earliest point in time and latest point in time for the AdventureWorks2019 sample database.
1. Select the **Restore** icon to initiate the point-in-time restore process.

   ![Screenshot of Arc-enabled SQL Managed Instance point in time restore points.](../media/exercise3-manage-point-in-time-restore-2.png)

1. Enter a name for the newly restored database.
1. Enter a point in time between the earliest point in time and the latest point in time to which you want to restore.
1. Select **Restore**.

    ![Screenshot of how to configure point-in-time restore for Azure Data Studio.](../media/exercise3-manage-point-in-time-restore-3.png)

1. To monitor the progress of the point-in-time restore, execute the following command in the Azure Data Studio Terminal Window:

    ```powershell
    kubectl get sqlmirestoretask -n 'enter your data controller namespace here'
    ```

    > [!NOTE]
    > This command might take a while, depending on the time you choose for the point-in-time restore.

1. Refresh the database list on the **Backups** tab.

    ![Screenshot of Arc-enabled SQL Managed Instance point in time restore GUI.](../media/exercise3-manage-point-in-time-restore-4.png)

1. Connect to your SQL Server instance and confirm that the database exists and you can query the data.

## Exercise 5 - Deploying Arc-enabled SQL Managed Instance Azure failover groups

In this exercise, we'll use an Arc-enabled SQL Managed Instance Business Critical environment. The environment consists of an Arc-enabled SQL Managed Instance located at our primary site and a duplicate Arc-enabled SQL Managed Instance located at our secondary site.

### Prerequisites

Make sure to complete the following before proceeding:

1. Have access to a supported Kubernetes cluster in your primary site.
1. Have access to a supported Kubernetes cluster in your secondary site.
1. Ensure to set your license type to Disaster Recovery.
1. Have access to a shared local storage location to which both Azure Arc-enabled SQL Managed Instances have access.
1. Complete the following modules in this learning path:
    1. Module 1, Exercise - Deploy an Azure Arc Data Controller (For your primary site).
    1. Module 2, Exercise - Deploy an Azure Arc-enabled SQL Managed Instance (For your primary site).
    1. Module 2, Exercise – Restore AdventureWorks2019 to your primary site Arc-enabled SQL Managed Instance.
    1. Module 1, Exercise - Deploy an Azure Arc Data Controller (For your secondary site)
    1. Module 2, Exercise - Deploy an Azure Arc-enabled SQL Managed Instance (For your secondary site).

### Deploy Arc-enabled SQL Managed Instance failover groups

1. In Azure Data Studio, open the Terminal window.
1. Ensure you're connected to your Azure Subscription.
1. Prepare your Arc-enabled SQL Managed Instance primary site parameter values:

   ```Powershell
   ## Primary Site Arc-enabled SQL Managed Instance parameter details
   $Env:MySubscription = 'enter your subscription id here'
   $Env:MyPrimaryResourceGroup = 'enter your primary site resource group name'
   $Env:MyPrimaryNamespace = 'enter your primary site data controller namespace'
   $Env:MyPrimaryInstance = 'enter your primary site SQL Managed Instance name'
   $Env:MyCertFullPath = 'enter you local path/sqlcerts'
   $Env:MyPrimaryCertFile = 'sqlprimary.pem'  ## Use anyname you wish
   $Env:MyAFG = 'aemsldag' ## Use any name you wish
   $Env:MyPrimaryDAG = 'sqlprimary-dag'  ## Use anyname you wish
   $Env:MyPrimaryCluster = 'enter your primary site kubernetes cluster name here'
   ```

   ![Screenshot of Arc-enabled SQL Managed Instance DR Primary Site Prep.](../media/exercise5-prepare-primary-site-parameters-1.png)

1. Ensure you're connected to your primary site Kubernetes cluster:

   ```PowerShell
   Kubectl config use-context $Env:MyPrimaryCluster
   ```

   ![Screenshot of Arc-enabled SQL Managed Instance Primary Site cluster context.](../media/exercise5-prepare-primary-site-cluster-context-1.png)

1. Retrieve the mirroring certificate for the primary site. This is required to be accessible to both sites. In this example, use the local user account home location. Ensure you set this appropriately for your environment. You can confirm the creation of the `sqlprimary.pem` certificate file in your configured local location.

   ```PowerShell
   az sql mi-arc get-mirroring-cert --subscription $Env:MySubcriptionID `
     --name $Env:MyPrimaryInstance  `
     --cert-file "$Env:MyCertFullPath\$Env:MyPrimaryCertFile" `
     --k8s-namespace $Env:MyPrimaryNamespace `
     --use-k8s
   ```

1. Retrieve the SQL Managed Instance Mirroring Endpoint IP address for the primary site:

   ```PowerShell
   $PrimaryMirroringEndpoint = $(
     az sql mi-arc show -n $Env:MyPrimaryInstance `
         --resource-group $Env:MyPrimaryResourceGroup `
         -o tsv `
         --query 'properties.k8SRaw.status.endpoints.mirroring'
   )

   $Env:MyPrimaryMirroringIP = "tcp://$PrimaryMirroringEndpoint"
   ```

1. Prepare your Arc-enabled SQL Managed Instance secondary site parameter values:

   ```Powershell
   $Env:MySecondaryResourceGroup = 'enter your secondary site resource group name'
   $Env:MySecondaryNamespace = 'enter your secondary site data controller namespace'
   $Env:MySecondaryInstance = 'enter your secondary site SQL Managed Instance name'
   $Env:MySecondaryCertFile = 'sqlsecondary.pem'  ## Use anyname you wish
   $Env:MySecondaryDAG = 'sqlsecondary-dag'  ## Use anyname you wish
   $Env:MySecondaryCluster = 'enter your secondary site kubernetes cluster name here'
   ```

   ![Screenshot of Arc-enabled SQL Managed Instance DR Secondary Site Prep.](../media/exercise5-prepare-secondary-site-parameters-2.png)

1. Ensure you're connected to your secondary site Kubernetes cluster:

   ```PowerShell
   Kubectl config use-context $Env:MySecondaryCluster
   ```

   ![Screenshot of Arc-enabled SQL Managed Instance Secondary Site cluster context.](../media/exercise5-prepare-secondary-site-cluster-context-1.png)

1. Retrieve the mirroring certificate for the secondary site. This is required to be accessible to both sites. In this example, we're using the local user account home location. Ensure you set this appropriately for your environment. You can confirm the creation of the `sqlsecondary.pem` certificate file in your configured local location.

   ```PowerShell
   az sql mi-arc get-mirroring-cert --subscription $Env:MySubcriptionID `
     --name $Env:MySecondaryInstance `
     --cert-file "$Env:MyCertFullPath\$Env:MySecondaryCertFile" `
     --k8s-namespace $Env:MySecondaryNamespace `
     --use-k8s
   ```

1. Retrieve the SQL Managed Instance Mirroring Endpoint IP address for the secondary site:

   ```PowerShell
   $SecondaryMirroringEndpoint = $(
     az sql mi-arc show -n $Env:MySecondaryInstance  `
         --resource-group $Env:MySecondaryResourceGroup `
         -o tsv `
         --query 'properties.k8SRaw.status.endpoints.mirroring'
   )

   $Env:MySecondaryMirroringIP = "tcp://$SecondaryMirroringEndpoint" 
   ```

1. Ensure you're connected to your primary site Kubernetes cluster:

   ```PowerShell
   Kubectl config use-context $Env:MyPrimaryCluster
   ```

1. Create the Azure failover group Primary resource on the primary site:

   ```PowerShell
   az sql instance-failover-group-arc create --shared-name $Env:MyAFG `
     --name $Env:MyPrimaryDAG  `
     --mi $Env:MyPrimaryInstance `
     --role primary `
     --partner-mi $Env:MySecondaryInstance  `
     --partner-mirroring-url $Env:MySecondaryMirroringIP `
     --partner-mirroring-cert-file "$Env:MyCertFullPath\$Env:MySecondaryCertFile" `
     --k8s-namespace $Env:MyPrimaryNamespace `
     --use-k8s

     ## The output should display: Deploying $Env:MyPrimaryDAG in namespace $Env:MyPrimaryNamespace
     ## $Env:MyPrimaryDAG is Ready

   ## Confirm primary resource has been created
   az sql instance-failover-group-arc show --subscription $Env:MySubcriptionID `
     --name $Env:MyPrimaryDAG `
     --k8s-namespace $Env:MyPrimaryNamespace `
     --use-k8s

   ## The output should be similar to this:
     "sharedName": "aemsldag",
     "sourceMI": "ae-msl-sqlmi2",
     "partnerMI": "ae-msl-sqlmi3",
     "partnerMirroringURL": "tcp://20.70.91.199:5022"
   ```

1. Ensure you're connected to your secondary site Kubernetes cluster.

   ```PowerShell
   Kubectl config use-context $Env:MySecondaryCluster
   ```

1. Create the Azure failover group Secondary resource on the secondary site.

   ```PowerShell
   az sql instance-failover-group-arc create --shared-name $Env:MyAFG `
     --name $Env:MySecondaryDAG `
     --mi $Env:MySecondaryInstance `
     --role secondary `
     --partner-mi $Env:MyPrimaryInstance `
     --partner-mirroring-url $Env:MyPrimaryMirroringIP `
     --partner-mirroring-cert-file "$Env:MyCertFullPath\$Env:MyPrimaryCertFile" `
     --k8s-namespace $Env:MySecondaryNamespace `
     --use-k8s

     ## The output should display: Deploying $Env:MySecondaryDAG in namespace $Env:MySecondaryNamespace
     ## $Env:MySecondaryDAG is Ready

   ## Confirm secondary resource has been created
   az sql instance-failover-group-arc show --subscription $Env:MySubcriptionID `
     --name $Env:MySecondaryDAG `
     --k8s-namespace $Env:MySecondaryNamespace `
     --use-k8s 

   ## The output should be similar to this:
     "sharedName": "aemsldag",
     "sourceMI": "ae-msl-sqlmi3",
     "partnerMI": "ae-msl-sqlmi2",
     "partnerMirroringURL": "tcp://20.92.195.233:5022"
   ```

1. Open SQL Server Management Studio (SSMS) and connect to the primary external endpoint for the primary site instance. Expand **Always On High Availability**. You should now see the newly created Azure failover group.
1. In SSMS, connect to the primary external endpoint for the secondary site instance. Expand **Always On High Availability**. You should now see the newly created Azure failover group.
1. Expand the database tree on the secondary site instance. You should see the AdventureWorks2019 database that was restored to your primary site instance previously.

Notice that you didn't have to perform any tasks to get your primary site database onto your secondary site instance. With the creation of the Azure failover group (Distributed availability group), all databases on the primary instance are automatically seeded to the secondary site. Depending on the database size, the network bandwidth between the primary and secondary sites will dictate the time for the databases to be synchronized.
