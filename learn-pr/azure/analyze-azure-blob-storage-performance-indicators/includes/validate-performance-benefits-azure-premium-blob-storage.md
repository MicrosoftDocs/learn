Now that you've reviewed the methods of optimizing and validating the performance of Azure Premium Blob Storage, you want to test it in practice. In this unit, you'll explore the process of implementing two Azure Storage accounts, each with different performance tiers, and evaluate their relative latency characteristics. For this purpose, you'll use a custom-developed .NET app that uploads and downloads a large number of blobs and measures the latency associated with each of these operations.

To simplify the implementation of this exercise, you'll run the app from Azure Cloud Shell, which eliminates the need to use an Azure virtual machine for this purpose. However, to minimize the impact of network-related latencies on the results of the test, you'll configure Azure Cloud Shell to use the virtual network isolation capability. This will allow you to ensure that the virtual machine (VM) hosting the container running your Azure Cloud Shell session resides in the same Azure region as the two storage accounts.

[!INCLUDE[](../../../includes/azure-optional-exercise-subscription-note.md)]

### Task 1: Prepare the lab environment

Use the following procedure to prepare the environment that you'll use to implement virtual network isolation of Azure Cloud Shell and to create the two Azure Storage accounts:

1. From your computer, open a web browser window and navigate to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).

1. When prompted, sign in with a user account that has the **Owner** role in the Azure subscription you'll be using in this exercise.

1. In the Azure portal, select the **Cloud Shell** icon.

    > [!NOTE]
    > If this is the first time you're using Cloud Shell and you're presented with the message **Welcome to Azure Cloud Shell**, select **PowerShell**. On the **You have no storage mounted** pane, in the **Subscription** drop-down list, select the subscription you're using in this exercise, and then select **Create storage**.

1. If needed, on the **Cloud Shell** pane, switch to the **PowerShell** option using the drop-down menu in the toolbar.

1. On the **Cloud Shell** pane, run the following command to set the value of a variable that designates the Azure region into which you'll provision resources in this exercise. To do this, replace the \<azure-region\> placeholder with the name of the Azure region in which you can deploy resources:

    ```powershell
    $location = '<azure-region>'
    ```

1. Next, set the value of a variable that designates the name of the resource group that will serve as a container for all Azure resources you'll provision in this exercise:

    ```powershell
    $rgName = 'apbslabrg'
    ```

1. Create a collection of parameter values that Azure will use to create the resource group:

    ```powershell
    $rg = @{
    
      Name = "$rgName"
    
      Location = "$location"
    
    }
    ```

1. Create the resource group:

    ```powershell
    New-AzResourceGroup @rg
    ```

1. Set the value of a variable that designates the name of the virtual network to which you'll connect the VM virtual machine running the Cloud Shell container:

    ```powershell
    $vnetName = "$rgName-vnet"
    ```

1. Create a collection of parameter values that Azure will use to create the virtual network:

    ```powershell
    $vnetParameters = @{
    
      Name = "$vnetName"
    
      ResourceGroupName = "$rgName"
    
      Location = "$location"
    
      AddressPrefix = '10.0.0.0/20'
    
    }
    ```

1. Create the virtual network:

    ```powershell
    $vnet = New-AzVirtualNetwork @vnetParameters
    ```

1. Create two Log Analytics workspaces:
 
    ```powershell
    $random = Get-Random -Maximum 1000000
    
    $workspaceStandardName = 'standard-la-' + $random
    
    New-AzOperationalInsightsWorkspace -Location $location -Name $workspaceStandardName -Sku PerGB2018 -ResourceGroupName $rgName 
    
    $workspacePremiumName = 'premium-la-' + $random
    
    New-AzOperationalInsightsWorkspace -Location $location -Name $workspacePremiumName -Sku PerGB2018 -ResourceGroupName $rgName
    
    ```

    > [!NOTE]
    > Provisioning the Log Analytics workspaces might take about five minutes. Don't wait for it to complete. You can continue to the next task.
    >

### Task 2: Deploy Cloud Shell into an Azure virtual network

Use the following procedure to implement Cloud Shell virtual network isolation. This will allow you to evaluate more accurately the storage latency of the Azure Storage accounts you provision later in this exercise.

1. On the **Cloud Shell** pane, run the following command to register the Microsoft.ContainerInstance resource provider, which is required to implement the Cloud Shell virtual network isolation functionality:

    ```powershell
    Register-AzResourceProvider -ProviderNamespace Microsoft.ContainerInstance
    ```

1. Review the output of the previous command and verify that the RegistrationState of the Microsoft.ContainerInstance resource provider is listed as **Registered**. If it's not listed as **Registered**, use the following command to check the registration status. It will check periodically whether the registration completed successfully and then proceed to the next step:

    ```powershell
    Get-AzResourceProvider -ProviderNamespace Microsoft.ContainerInstance
    ```

1. Next, retrieve the value of Azure Container Instance OID, which is required to implement the Cloud Shell virtual network isolation functionality:

    ```powershell
    $azureContainerInstanceOID = (Get-AzADServicePrincipal -DisplayNameBeginsWith 'Azure Container Instance').Id
    ```

1. Set the value of a variable that designates the name of the Azure Relay resource that will provide connectivity to the container running Azure Cloud Shell:

    ```powershell
    $random = Get-Random -Maximum 1000000
    
    $relayNameSpaceName = ($rgName.replace("-", "") + 'relay' + $random).ToLower()
    ```

1. Download the parameters file that Azure will use to create subnets in the virtual network you provisioned in the previous task and deploy the Azure Relay resource into one of them:

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/cloud-shell-vnet/azuredeploy.parameters.json -OutFile azuredeploy-relay.parameters.json
    
    ```

1. Deploy the Azure Relay resource:

    ```powershell
    New-AzResourceGroupDeployment `
    
      -ResourceGroupName $rgName `
    
      -existingVNETName $vnetName `
    
      -relayNamespaceName $relayNameSpaceName `
    
      -azureContainerInstanceOID $azureContainerInstanceOID `
    
      -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/cloud-shell-vnet/azuredeploy.json `
    
      -TemplateParameterFile azuredeploy-relay.parameters.json
    ```

    > [!NOTE]
    > Wait for the deployment to complete. This might take about three minutes.
    >

1. Download the parameters file that Azure will use to create the storage account that the Cloud Shell container will use:

    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/cloud-shell-vnet-storage/azuredeploy.parameters.json -OutFile azuredeploy-storage.parameters.json
    
    ```

1. Set the value of a variable that designates the name of the Azure Storage account that Azure will use to host the home directory of the Azure Cloud Shell container with virtual network isolation enabled:

    ```powershell
    
    $storageAccountName = ($rgName.replace("-", "") + 'storage' + $random).ToLower()
    ```

1. Create the storage account that the Cloud Shell container will use:

    ```powershell
    
    New-AzResourceGroupDeployment `
    
      -ResourceGroupName $rgName `
    
      -existingVNETName $vnetName `
    
      -existingStorageSubnetName 'storagesubnet' `
    
      -existingContainerSubnetName 'cloudshellsubnet' `
    
      -storageAccountName $storageAccountName `
    
      -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/cloud-shell-vnet-storage/azuredeploy.json `
    
      -TemplateParameterFile azuredeploy-storage.parameters.json
    ```
    > [!NOTE]
    > Wait for the deployment to complete. This can take several minutes.
    >

1. Unmount the original storage account from your current Cloud Shell session:

    ```powershell
    clouddrive unmount
    ```

1. When prompted (twice), confirm that you want to continue.

    > [!NOTE]
    > This will terminate your current Cloud Shell session.
    >

1. When prompted, on the **Cloud Shell** pane, select **Reconnect**.

1. When presented with the message **Welcome to Azure Cloud Shell**, select **PowerShell**.

1. On the **You have no storage mounted** pane, select the **Show advanced settings** checkbox, and then select the **Show VNET isolation settings** checkbox.

1. On the **You have no storage mounted** pane, specify the following settings, and then select **Create storage**:

    | **Setting** | **Action** |
    | -- | -- |
    | Subscription | Select the name of your subscription |
    | Cloud Shell region | Select the name of an Azure region you chose earlier in this exercise |
    | Resource group | Select the **apbslabrg** entry from the drop-down list |
    | Storage account | Select the name of the storage account with the prefix **apbslabrg** |
    | File share | Enter **cloudshellshare** |
    | Virtual network | **apbslabrg-vnet** |
    | Network profile | The name of the network profile automatically generated earlier in this task |
    | Relay namespace | The name of the Azure Relay namespace automatically generated earlier in this task |

    > [!NOTE]
    > The last three settings in the previous table are automatically populated and might not be displayed on the **You have no storage mounted** pane.
    >
    > Mounting storage might take about five minutes. Don't wait for it to complete. You can continue to the next task.
    >

## Task 3: Create an Azure Standard performance storage account

Use the following procedure to create an Azure Standard performance storage account from the Azure portal. You'll use this account to measure blob download latency later in this exercise.

1. In the web browser window displaying the Azure portal, open another tab, and then navigate to the Azure portal.

1. Use the **Search resources, services, and docs** text box to search for and select **Storage accounts**.

1. On the **Storage accounts** page, select **+ Create**.

1. On the **Basics** tab of the **Create a storage account** page, enter the following information:

    | **Setting** | **Value** |
    | -- | -- |
    | Subscription | The name of  your subscription |
    | Resource group | **apbslabrg** |
    | Storage account name | Any globally  unique name between 3 and 24 characters consisting of lowercase letters and digits, starting with a letter |
    | Region | The name of  an Azure region you chose earlier in this exercise |
    | Performance | **Standard** |
    | Redundancy | Locally redundant storage (LRS) |

1. Select **Review + create** and then select **Create**.

    > [!NOTE]
    > Record the name of the storage account. You'll need it later in this exercise.
    >
    > Provisioning the storage account might take about one minute. Don't wait for it to complete. You can continue to the next task.
    >

### Task 4: Create an Azure Premium Blob Storage account

Use the following procedure to create an Azure Premium Blob Storage account from the Azure portal. You'll use this account to measure blob download latency later in this exercise.

1. In the web browser window displaying the Azure portal, open another tab, and then navigate to the Azure portal.

1. Use the **Search resources, services, and docs** text box to search for and select **Storage accounts**.

1. On the **Storage accounts** page, select **+ Create**.

1. On the **Basics** tab of the **Create a storage account** page, enter the following information:

    | **Setting** | **Value** |
    | -- | -- |
    | Subscription | The name of  your subscription |
    | Resource group | **apbslabrg** |
    | Storage account name | Any globally  unique name between 3 and 24 characters consisting of lowercase letters and digits, starting with a letter |
    | Region | The name of  an Azure region you chose earlier in this exercise |
    | Performance | **Premium** |
    | Premium account type | **Block blobs** |
    | Redundancy | Locally redundant  storage (LRS) |

1. Select **Review + create**, and then select **Create**.

    > [!NOTE]
    > Record the name of the storage account. You'll need it later in this exercise.
    >
    > Provisioning the storage account might take about one minute. Don't wait for it to complete. You can continue to the next task.
    >

### Task 5: Upload blobs to the Azure Standard performance storage account

Use the following procedure to use a custom .NET app to upload blobs to the Azure Standard performance storage account you created earlier in this exercise. You‘ll use these blobs to evaluate the latency of blob download operations later in this exercise. You'll also configure storage diagnostics that will allow you to assess service-side latency.

> [!NOTE]
> Before you proceed with this task, verify that the storage mounting operation of the Azure Cloud Shell you initiated at the end of Task 2 completed successfully and that the provisioning of Azure Standard performance storage account you initiated in Task 3 has completed.
>

1. In the web browser window displaying the Azure portal, switch back to the tab you used to provision the Azure Standard performance storage account.

1. Select **Go to resource** to navigate to the page displaying the properties of the Azure Standard performance storage account.

1. On the Azure Standard performance storage account page, in the **navigation** menu, in the **Monitoring** section, select **Diagnostic settings**.

1. In the **Select any of the resources to view diagnostic settings** pane, select **blob** and then select **+ Add diagnostic setting**.

1. On the **Diagnostic setting** page, in the **Diagnostic setting name** textbox, enter **Standard-diagnostic**, in the **Logs Categories** section, select the **StorageRead** checkbox, in the **Destination details** section, select **Send to Log analytics workspace**, accept the default **Subscription** but set **Log Analytics workspace** to the workspace with the **standard** prefix you created earlier in this exercise, select **Save**, and close the **Diagnostic setting** page.

1. Back on the Azure Standard performance storage account page, in the **navigation** menu, in the **Security + networking** section, select **Access keys**.

1. On the **Access keys** page, select **Show keys** or in the **key1** section, next to the **Connection string** text box, select **Show**, and then copy the contents of the **Connection string** text box to the clipboard.

1. Switch to the tab you used to mount the storage in the Cloud Shell session at the end of Task 2.

1. On the **Cloud Shell** pane, within a PowerShell session, run the following command to set the environment variable that the .NET app will use to connect to the target Azure Storage account. Replace the \<connection-string\> placeholder with the value of the connection string you copied to Clipboard earlier in this task:

    ```powershell
    $env:standardconnectionstring = '<connection-string>'
    ```

    > [!IMPORTANT]
    > This code example uses a connection string to authorize access to your storage account. This configuration is for example purposes. Connection strings and account access keys should be used with caution in application code. If your account access key is lost or accidentally placed in an insecure location, your service may become vulnerable. Anyone who has the access key is able to authorize requests against the storage account, and effectively has access to all the data.
    >
    > For optimal security, Microsoft recommends using managed identities for Azure resources to authorize requests against blob, queue, and table data, whenever possible. To learn more, see [Authorize access to blobs using Microsoft Entra ID](/azure/storage/blobs/authorize-access-azure-active-directory).

1. Clone the GitHub repo containing the code of the .NET app you'll use for latency testing into the home directory of the Cloud Shell:

    ```powershell
    git clone https://github.com/mpolicht/storage-blob-dotnet-latency-profiler.git
    ```

1. Build the .NET app:

    ```powershell
    cd ./storage-blob-dotnet-latency-profiler
    dotnet build
    ```

1. Initiate the upload of 10,000 blobs of 4 MiB in size to the target storage account:

    ```powershell
    dotnet run --project ./storage-blob-dotnet-latency-profiler/storage-blob-dotnet-latency-profiler.csproj testcontainer standardconnectionstring ./standarduploadresults.csv prod true UploadTestBlobs testblob- 10000 4194304
    ```

    > [!NOTE]
    > The upload might take about three minutes. Don't wait for it to complete. You can continue to the next task.
    >

### Task 6: Upload blobs to the Azure Premium Blob Storage account

Use the following procedure to leverage the custom .NET app to upload blobs to the Azure Premium Blob Storage account you created earlier in this exercise. You'll use these blobs to evaluate latency of blob download operations later in this exercise, and you'll also configure storage diagnostics that will allow you to assess service-side latency.

> [!NOTE]
> Before starting this task, verify that the provisioning of Azure Premium Blob Storage account you initiated in Task 4 has completed.
>

1. In the web browser window displaying the Azure portal, switch back to the tab you used to provision the Azure Premium Blob Storage account.

1. Select **Go to resource** to navigate to the page displaying the properties of the Azure Premium Blob Storage account.

1. On the Azure Premium Blob Storage performance storage account page, in the **navigation** menu, in the **Monitoring** section, select **Diagnostic settings**.

1. In the **Select any of the resources to view diagnostic settings** pane, select **blob** and then select **+ Add diagnostic setting**.

1. On the **Diagnostic setting** page, in the **Diagnostic setting name** textbox, enter **Premium-diagnostic**, in the **Logs Categories** section, select the **StorageRead** checkbox, in the **Destination details** section, select **Send to Log analytics workspace**, accept the default **Subscription** but set **Log Analytics workspace** to the workspace with the **premium** prefix you created earlier in this exercise, select **Save**, and close the **Diagnostic setting** page.

1. Back on the Azure Premium Blob Storage account page, in the **navigation** menu, in the **Security + networking** section, select **Access keys**.

1. On the **Access keys** page, select **Show keys** or in the **key1** section, next to the **Connection string** text box, select **Show**, and then copy the contents of the **Connection string** text box to the clipboard.

1. On the same browser tab, select the **Azure Cloud Shell** icon.

1. On the **Cloud Shell** pane, within a PowerShell session, run the following command to set the environment variable that the .NET app will use to connect to the target Azure Storage account after replacing the connection-string placeholder with the value of the connection string you copied to the clipboard earlier in this task:

    ```powershell
    $env:premiumconnectionstring = '<connection-string>'
    ```

    > [!IMPORTANT]
    > This code example uses a connection string to authorize access to your storage account. This configuration is for example purposes. Connection strings and account access keys should be used with caution in application code. If your account access key is lost or accidentally placed in an insecure location, your service may become vulnerable. Anyone who has the access key is able to authorize requests against the storage account, and effectively has access to all the data.
    >
    > For optimal security, Microsoft recommends using managed identities for Azure resources to authorize requests against blob, queue, and table data, whenever possible. To learn more, see [Authorize access to blobs using Microsoft Entra ID](/azure/storage/blobs/authorize-access-azure-active-directory).

1. Initiate the upload of 10,000 blobs of 4 MiB in size to the target storage account:

    ```powershell
    cd ./storage-blob-dotnet-latency-profiler
    
    dotnet run --project ./storage-blob-dotnet-latency-profiler/storage-blob-dotnet-latency-profiler.csproj testcontainer premiumconnectionstring ./premiumuploadresults.csv prod true UploadTestBlobs testblob- 10000 4194304
    ```

    > [!NOTE]
    > The upload might take about three minutes. Don't wait for it to complete. You can continue to the next task.
    >

### Task 7: Test the performance of the Azure Standard performance storage account

Use the following procedure to leverage the custom .NET app to evaluate the latency of blob downloads from the Azure Standard performance storage account into which you uploaded blobs earlier in this exercise.

> [!NOTE]
> Before starting this task, verify that the upload of blobs into the Azure Standard performance storage account you initiated at the end of Task 5 completed successfully.
>

1. Switch to the web browser window displaying the Cloud Shell session from which you uploaded blobs to the Azure Standard performance storage account.

1. On the **Cloud Shell** pane, within a PowerShell session, run the following command to initiate the download of the first 64KiB of 1,000 blobs randomly chosen out of an available set of 10,000 blobs (named testblob-0 through testblob-9999) from the storage account identified in the environment variable **standardconnectionstring**. Azure displays the output in the **./standarddownloadresults.csv** file with the latency of each block download. Azure also reports the total average and 99th percentile latencies after every group of 100 blobs is downloaded:

    ```powershell
    dotnet run --project ./storage-blob-dotnet-latency-profiler/storage-blob-dotnet-latency-profiler.csproj testcontainer standardconnectionstring ./standarddownloadresults.csv prod true RandomDownloadTest testblob- 1000 65536 10000 100 99
    ```

1. Review the results and verify that they have the following format:

    ```powershell
    Test running. Streaming details to output file './standarddownloadresults.csv'.
    
    Test 10.0% Complete. 99th Percentile: 48.8ms Average: 34.1ms
    
    Test 20.0% Complete. 99th Percentile: 80.4ms Average: 35.7ms
    
    Test 30.0% Complete. 99th Percentile: 103.7ms Average: 37.2ms
    
    Test 40.0% Complete. 99th Percentile: 113.6ms Average: 37.6ms
    
    Test 50.0% Complete. 99th Percentile: 144.0ms Average: 38.8ms
    
    Test 60.0% Complete. 99th Percentile: 144.0ms Average: 38.3ms
    
    Test 70.0% Complete. 99th Percentile: 144.0ms Average: 37.5ms
    
    Test 80.0% Complete. 99th Percentile: 144.0ms Average: 37.5ms
    
    Test 90.0% Complete. 99th Percentile: 144.0ms Average: 37.0ms
    
    Test 100.0% Complete. 99th Percentile: 144.0ms Average: 36.8ms
    
    The test completed successfully.
    ```

    > [!NOTE]
    > Review the 99th percentile and average download latency.
    >

1. Close the **Cloud Shell** pane.

### Task 8: Test the performance of the Azure Premium Blob Storage account

Use the following procedure to leverage the custom .NET app to evaluate latency of blob downloads from the Azure Premium Blob Storage account into which you uploaded blobs earlier in this exercise.

> [!NOTE]
> Before starting this task, verify that the upload of blobs into the Premium Blob Storage account you initiated at the end of Task 6 completed successfully.
>

1. Switch to the web browser window displaying the Cloud Shell session from which you uploaded blobs to the Azure Premium Blob Storage account.

1. On the **Cloud Shell** pane, within a PowerShell session, run the following command to initiate the download of the first 64KiB of 1,000 blobs randomly chosen out of an available set of 10,000 blobs (named testblob-0 through testblob-9999) from the storage account identified in the environment variable **premiumconnectionstring**. Azure displays the output in the **./premumdownloadresults.csv** file with the latency of each block download. Azure also reports the total average and 99th percentile latencies after every group of 100 blobs is downloaded:

    ```powershell
    dotnet run --project ./storage-blob-dotnet-latency-profiler/storage-blob-dotnet-latency-profiler.csproj testcontainer premiumconnectionstring ./premiumdownloadresults.csv prod true RandomDownloadTest testblob- 1000 65536 10000 100 99
    ```

1. Review the results and verify that they have the following format:

    ```powershell
    Test running. Streaming details to output file './premiumdownloadresults.csv'.
    
    Test 10.0% Complete. 99th Percentile: 12.6ms Average: 7.3ms
    
    Test 20.0% Complete. 99th Percentile: 13.0ms Average: 6.8ms
    
    Test 30.0% Complete. 99th Percentile: 13.1ms Average: 6.5ms
    
    Test 40.0% Complete. 99th Percentile: 13.1ms Average: 6.3ms
    
    Test 50.0% Complete. 99th Percentile: 13.1ms Average: 6.2ms
    
    Test 60.0% Complete. 99th Percentile: 13.1ms Average: 6.0ms
    
    Test 70.0% Complete. 99th Percentile: 13.1ms Average: 5.9ms
    
    Test 80.0% Complete. 99th Percentile: 13.2ms Average: 5.9ms
    
    Test 90.0% Complete. 99th Percentile: 13.2ms Average: 5.8ms
    
    Test 100.0% Complete. 99th Percentile: 13.2ms Average: 5.8ms
    
    The test completed successfully.
    ```

    > [!NOTE]
    > Review the 99th percentile and average download latency and compare them with the results from the previous test.
    >

1. Close the **Cloud Shell** pane.

### Task 9: Examine service-side performance of the Azure Premium Blob Storage and Azure Standard performance storage account

Use the following procedure to leverage Azure Log Analytics to analyze the Azure Storage diagnostic logs that were collected from both storage accounts based on the diagnostic settings you configured earlier in this exercise.

1. In the web browser window displaying the properties of the Azure Premium Blob Storage account, in the **navigation** menu, in the **Monitoring** section, select **Logs**.

1. Close the **Welcome to Log Analytics** pane and the **Queries** pane.

1. In the **New Query 1** pane, enter the following Kusto Query Language query and select **Run**:

    ```sql
    StorageBlobLogs
    
    | where TimeGenerated > ago (30m)
    
    | where Uri contains "testblob" and OperationName == "GetBlob"
    
    | project TimeGenerated, OperationName, DurationMs, ServerLatencyMs, ClientLatencyMs = DurationMs - ServerLatencyMs, Uri, ResponseBodySize
    ```

1. Review the output, focusing on the values in the **ServerLatencyMs** column, and then copy them into a Notepad file.

1. In the **New Query 1** pane, update the Kusto Query Language query so it has the following content and select **Run**:

    ```sql
    StorageBlobLogs
    
    | where TimeGenerated > ago (30m)
    
    | where Uri contains "testblob" and OperationName == "GetBlob"
    
    | project TimeGenerated, OperationName, DurationMs, ServerLatencyMs, ClientLatencyMs = DurationMs - ServerLatencyMs, Uri, ResponseBodySize
    
    | summarize percentiles_array(ServerLatencyMs, 50, 99), avg(ServerLatencyMs), count()
    ```

    > [!NOTE]
    > The output should contain values similar to the following ones:
    >
    > ```sql
    > percentiles_ServerLatencyMs  avg_ServerLatencyMs  count_
    >
    > [3,5]                        3.071                1000
    > ```

1. Review the output, focusing on the values in the **percentiles_ServerLatencyMs** and **avg_ServerLatencyMs** columns.

1. Switch to the web browser window displaying the properties Azure Standard performance storage account.

1. In the web browser window displaying the properties of the Azure Standard performance storage account, in the **navigation** menu, in the **Monitoring** section, select **Logs**.

1. Close the **Queries** pane.

1. In the **New Query 1** pane, enter the following Kusto Query Language query and select **Run**:

    ```sql
    StorageBlobLogs
    
    | where TimeGenerated > ago (30m)
    
    | where Uri contains "testblob" and OperationName == "GetBlob"
    
    | project TimeGenerated, OperationName, DurationMs, ServerLatencyMs, ClientLatencyMs = DurationMs - ServerLatencyMs, Uri, ResponseBodySize
    ```

1. Review the output, focusing on the values in the **ServerLatencyMs** column and compare them with the values for the Azure Premium Blob Storage account.

1. In the **New Query 1** pane, update the Kusto Query Language query so it has the following content and select **Run**:

    ```sql
    StorageBlobLogs
    
    | where TimeGenerated > ago (30m)
    
    | where Uri contains "testblob" and OperationName == "GetBlob"
    
    | project TimeGenerated, OperationName, DurationMs, ServerLatencyMs, ClientLatencyMs = DurationMs - ServerLatencyMs, Uri, ResponseBodySize
    
    | summarize percentiles_array(ServerLatencyMs, 50, 99), avg(ServerLatencyMs), count()
    ```

1. Review the output, focusing on the values in the **percentiles_ServerLatencyMs** and **avg_ServerLatencyMs** columns and compare them with the values for the Azure Premium Blob Storage account.

    > [!NOTE]
    > The output should contain values similar to the following ones:
    >
    > ```sql
    > percentiles_ServerLatencyMs  avg_ServerLatencyMs  count_
    >   
    > [24,102]                     29.111               1000
    > ```

### Task 10: Deprovision the lab environment 

Use the following procedure to deprovision the lab environment.

1. In the web browser window displaying the Azure portal, navigate to the page of the **apbslabrg** Resource Group.

1. On the **apbslabrg** page, select **Delete resource group**.

1. When prompted, in the TYPE THE RESOURCE GROUP NAME text box, enter **apbslabrg** and select **Delete**.

1. When prompted for confirmation, select **Yes**.
