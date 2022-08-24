To deploy your Azure Arc-enabled SQL Managed Instance (MI), we have several options available to us:

1. GUI deployment:
    1. Azure Portal
    2. Azure Data Studio
2. CLI deployment
    1. Azure Portal Cloud Shell
    2. Azure Data Studio terminal window

Choose which option you wish to walk through. All exercise options below provide you with the same outcome. All scenarios in the below exercises utilize the General Purpose Tier (Standard Edition). The Business Critical Tier (Enterprise Edition) allows you to choose the number of replicas you require to meet your High Availability needs. 

For all exercise options below, the Kubernetes cluster used is an AKS cluster. All options for storage classes used are associated with and supported on an AKS cluster.  The Kubernetes cluster implemented in your environment will dictate the types of provisioned and presented storage classes.  You will need to know your storage classes. The value `Default` used for the storage classes below means "use the storage class configured at the AKS cluster level". In this case premium storage.

## Option 1: Azure Portal GUI deployment 

This option is only available with environments configured in the directly connected mode.

1. In the Azure portal, select + Create resource.
2. Search for SQL Managed Instance - Azure Arc.
3. Select Create.

    ![Image of Azure Arc-enabled SQL MI - Azure Arc create resource](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-create-3.png)

4. Choose the Resource Group in which you created your Arc data controller.
5. Enter a name for your new Arc-enabled SQL MI.
6. Choose the custom location associated with your Arc-enabled Kubernetes cluster.
7. Choose the service type that is associated with your Arc-enabled Kubernetes cluster.

    ![Image of Azure Arc-enabled SQL MI - Azure Arc resource details](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-details-4.png)

8. Click on Configure compute + storage.
9. Choose your Service tier.
10. Set the memory request in Gigabytes.
11. Set the memory limit in Gigabytes.
12. Set the CPU vCore request.
13. Set the CPU vCore limit.

    ![Image of Azure Arc-enabled SQL MI - Azure Arc compute and storage resource details](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-compute-storage-details-5.png)

14. Enter 'Default' for the data storage class. 
15. Set the data volume size in Gigabytes.
16. Enter 'Default' for the datalogs storage class.
17. Set the datalogs (transaction log files) volume size in Gigabytes.
18. Enter 'Default' for the logs storage class.
19. Set the logs volume size in Gigabytes.
20. Your backup storage class needs to be ReadWriteMany (RWX) capable.
21. Set the backup volume size in Gigabytes.
22. Select 'I already have a SQL Server License' if you have [Azure Hybrid Benefits](https://docs.microsoft.com/en-us/azure/azure-sql/azure-hybrid-benefit?view=azuresql&tabs=azure-portal).
23. Click apply.

    ![Image of Azure Arc-enabled SQL MI - Azure Arc compute and storage resource details](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-compute-storage-details-6.png)

24. Set the Admin username for the Arc-enabled SQL MI.
25. Set the Admin user password for the Arc-enabled SQL MI. 
26. Select Next: Tags

    ![Image of Azure Arc-enabled SQL MI - Azure Arc Admin Account details](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-admin-account-7.png) 

27. Add your appropriate tags.
28. Select Next: Review + Create

    ![Image of Azure Arc-enabled SQL MI - Azure Arc Tags](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-Tags-8.png) 

29. Review your configurations and select Create.

    ![Image of Azure Arc-enabled SQL MI - Review and Create](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-review-and-create-9.png)  

30. Confirm your Arc-enabled Azure SQL MI deployment.

    ![Image of Azure Arc-enabled SQL MI - Deployed](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-10.png)

    ![Image of Azure Arc-enabled SQL MI - Deployed](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-11.png)

    ![Image of Azure Arc-enabled SQL MI - Deployed2](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-12.png)

31. In Azure Data Studio, expand the Connection tab. Right-click on your Arc data controller and click refresh. Right-click on your Arc data controller and click manage. You can now manage your Arc-enabled SQL MI from Azure Data Studio.

    ![Image of Azure Arc-enabled SQL MI - Manage in ADS](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-Manage-12.png)   

## Option 2: Azure Data Studio GUI deployment

This option is available with environments configured in either the directly or indirectly connected mode.

1. In Azure Data Studio, Right-click on your Arc data controller and select Manage.
2. Select New Instance.
3. Select Azure SQL Managed Instance.

    ![Image of Azure Arc-enabled SQL MI - ADS Azure Arc create resource](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-create-1.png)

4. Review and accept the EULA.

    ![Image of Azure Arc-enabled SQL MI - ADS Azure Arc create pre-requisites](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-prerequisites-2.png)

5. Enter a name for your new Arc-enabled SQL MI.
6. Set the Admin username for the Arc-enabled SQL MI.
7. Set the Admin user password for the Arc-enabled SQL MI.
8. Choose your Service tier.
9. Select 'I already have a SQL Server License' if you have [Azure Hybrid Benefits](https://docs.microsoft.com/en-us/azure/azure-sql/azure-hybrid-benefit?view=azuresql&tabs=azure-portal).

    ![Image of Azure Arc-enabled SQL MI - ADS Azure Arc create details](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-details-3.png)

10. Select 'Default' for the data storage class. 
11. Set the data volume size in Gigabytes.
12. Select 'Default' for the datalogs storage class.
13. Set the datalogs (transaction log files) volume size in Gigabytes.
14. Select 'Default' for the logs storage class.
15. Set the logs volume size in Gigabytes.
16. Your backup storage class needs to be ReadWriteMany (RWX) capable.
17. Set the backup volume size in Gigabytes.
18. Set the CPU vCore request.
19. Set the CPU vCore limit.
20. Set the memory request in Gigabytes.
21. Set the memory limit in Gigabytes.
22. Click Deploy.

![Image of Azure Arc-enabled SQL MI - ADS Azure Arc create resource details](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-details-4.png)

    The deployment opens up a notebook called deploy.sql.existing.arc, which will automatically start executing each of the cells. Once the deployment has completed, refresh the Arc data controller dashboard window.
    
23.  Confirm your Arc-enabled Azure SQL MI deployment.

![Image of Azure Arc-enabled SQL MI - Deployed](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-11.png)

![Image of Azure Arc-enabled SQL MI - Deployed2](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-12.png)


24. In Azure Data Studio, expand the Connection tab. Right-click on your Arc data controller and click refresh. Right-click on your Arc data controller and click manage. You can now manage your Arc-enabled SQL MI from Azure Data Studio.

![Image of Azure Arc-enabled SQL MI - Manage in ADS](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-Manage-12.png) 

## Option 3: Azure Portal Cloud Shell deployment

This option is only available with environments configured in the directly connected mode.

1. In the Azure Portal open cloud shell.
2. Prepare your Arc-enabled SQL MI creation parameters:

    ```PowerShell
    $Env:MyResourceGroup = 'enter your resource group name here'
    $Env:MyCluster = 'enter your kubernetes cluster name here'
    $Env:Mylocation = 'enter your location here'
    $Env:MyCustomlocation = 'enter your custom location name here'
    $Env:ServiceTier = 'enter General Purpose or Business Critical here>'
    $Env:DevUse = 'true'  ## only if the evironment is not production
    $Env:Replicas = '1'   ## Values (1,2,3) based on the tier level chosen
    $Env:SQLLicenseType = 'enter BasePrice or LicenseIncluded'  ##based on you having Azure Hybrid Benefits
    $Env:SQLMIName = 'enter your arc-enabled sql managed instance name here>'
    $Env:SQLMIAdminUser = 'enter your sql mi admin account name here>'
    $Env:DataStorageClass = 'default'
    $Env:DataLogsStorageClass = 'default'
    $Env:LogsStorageClass = 'default'
    $ENV:BackupsStorageClass = 'azurefile' ## requires to be RWX capable`
    $Env:BackupRetentionDays = ''
    $Env:DataVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:DatalogsVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:LogsVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:BackupsVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:CoresRequest = '2' ## Set the number of cores to start with
    $Env:CoresLimit = '4' ## Set the maximum number of cores
    $Env:MemoryRequest = '4Gi' ## Set your memory limit appropriately in Gigabytes
    $Env:MemoryLimit = '8Gi' ## Set your maximum memory limit appropriately in Gigabytes
    ```

    ![Image of Azure Arc-enabled SQL MI - CLI Parameters](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-CLI-parameterts-13.png) 

3. Execute the following `az sql mi-arc create` command:

    ```PowerShell
    az sql mi-arc create --name $Env:SQLMIName `
        --resource-group $Env:MyResourceGroup `
        --location $Env:Mylocation `
        --custom-location $Env:MyCustomlocation `
        --replicas $Env:Replicas `
        --cores-request $Env:CoresRequest `
        --cores-limit $Env:CoresLimit `
        --memory-request $Env:MemoryRequest `
        --memory-limit $Env:MemoryLimit `
        --storage-class-data $Env:DataStorageClass `
        --storage-class-datalogs $Env:DataLogsStorageClass `
        --storage-class-logs $Env:LogsStorageClass `
        --storage-class-backups $ENV:BackupsStorageClass `
        --volume-size-data $Env:DataVolumeSize `
        --volume-size-datalogs $Env:DatalogsVolumeSize `
        --volume-size-logs $Env:LogsVolumeSize `
        --volume-size-backups $Env:BackupsVolumeSize `
        --tier $Env:ServiceTier `
        --dev `
        --license-type $Env:SQLLicenseType `
        --cores-limit $Env:CoresLimit
    ```

4. Enter your Arc-enabled SQL MI admin account and password when prompted.
5. Confirm your Arc-enabled SQL MI deployment.

    ![Image of Azure Arc-enabled SQL MI - Deployed](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-11.png)

    ![Image of Azure Arc-enabled SQL MI - Deployed2](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-12.png)

6. In Azure Data Studio, expand the Connection tab. Right-click on your Arc data controller and click refresh. Right-click on your Arc data controller and click manage. You can now manage your Arc-enabled SQL MI from Azure Data Studio.

    ![Image of Azure Arc-enabled SQL MI - Manage in ADS](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-Manage-12.png)

## Option 4: Azure Data Studio terminal deployment

This option is available with environments configured in either the directly or indirectly connected mode.

1. In the Azure Portal open cloud shell.
2. Prepare your Arc-enabled SQL MI creation parameters:

    ```PowerShell
    $Env:MyResourceGroup = 'enter your resource group name here'
    $Env:MyCluster = 'enter your kubernetes cluster name here'
    $Env:Mylocation = 'enter your location here'
    $Env:MyCustomlocation = 'enter your custom location name here'
    $Env:ServiceTier = 'enter General Purpose or Business Critical here>'
    $Env:DevUse = 'true'  ## only if the evironment is not production
    $Env:Replicas = '1'   ## Values (1,2,3) based on the tier level chosen
    $Env:SQLLicenseType = 'enter BasePrice or LicenseIncluded'  ##based on you having Azure Hybrid Benefits
    $Env:SQLMIName = 'enter your arc-enabled sql managed instance name here>'
    $Env:SQLMIAdminUser = 'enter your sql mi admin account name here>'
    $Env:DataStorageClass = 'default'
    $Env:DataLogsStorageClass = 'default'
    $Env:LogsStorageClass = 'default'
    $ENV:BackupsStorageClass = 'azurefile' ## requires to be RWX capable`
    $Env:BackupRetentionDays = ''
    $Env:DataVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:DatalogsVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:LogsVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:BackupsVolumeSize = '5Gi' ## Adjust your volume size appropriately in Gigabytes
    $Env:CoresRequest = '2' ## Set the number of cores to start with
    $Env:CoresLimit = '4' ## Set the maximum number of cores
    $Env:MemoryRequest = '4Gi' ## Set your memory limit appropriately in Gigabytes
    $Env:MemoryLimit = '8Gi' ## Set your maximum memory limit appropriately in Gigabytes
    ```

    ![Image of Azure Arc-enabled SQL MI - CLI Parameters](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-CLI-ADS-parameterts-14.png) 

3. Execute the following `az sql mi-arc create` command:

    ```PowerShell
    az sql mi-arc create --name $Env:SQLMIName `
        --resource-group $Env:MyResourceGroup `
        --location $Env:Mylocation `
        --custom-location $Env:MyCustomlocation `
        --replicas $Env:Replicas `
        --cores-request $Env:CoresRequest `
        --cores-limit $Env:CoresLimit `
        --memory-request $Env:MemoryRequest `
        --memory-limit $Env:MemoryLimit `
        --storage-class-data $Env:DataStorageClass `
        --storage-class-datalogs $Env:DataLogsStorageClass `
        --storage-class-logs $Env:LogsStorageClass `
        --storage-class-backups $ENV:BackupsStorageClass `
        --volume-size-data $Env:DataVolumeSize `
        --volume-size-datalogs $Env:DatalogsVolumeSize `
        --volume-size-logs $Env:LogsVolumeSize `
        --volume-size-backups $Env:BackupsVolumeSize `
        --tier $Env:ServiceTier `
        --dev `
        --license-type $Env:SQLLicenseType `
        --cores-limit $Env:CoresLimit
    ```

4. Enter your Arc-enabled SQL MI admin account and password when prompted.
5. Confirm your Arc-enabled SQL MI deployment.

    ![Image of Azure Arc-enabled SQL MI - Deployed](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-11.png)

    ![Image of Azure Arc-enabled SQL MI - Deployed2](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-deployed-12.png)

6. In Azure Data Studio, expand the Connection tab. Right-click on your Arc data controller and click refresh. Right-click on your Arc data controller and click manage. You can now manage your Arc-enabled SQL MI from Azure Data Studio.

    ![Image of Azure Arc-enabled SQL MI - Manage in ADS](../media/Arc-enabled-dataservices-module-2-Arc-enabled-SQLMI-ADS-Manage-12.png)
