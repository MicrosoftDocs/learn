Azure Blob Storage on IoT Edge provides a block blob storage solution at the edge. A blob storage module on your IoT Edge device behaves like an Azure block blob service, except the block blobs are stored locally on your IoT Edge device. You can access your blobs using the same Azure storage SDK methods or block blob API calls that you're already used to.

A blob storage module is useful in the following scenarios:

 -  Where data needs to be stored locally until it can be processed or transferred to the cloud. This data can be videos, images, finance data, hospital data, or any other unstructured data.
 -  When devices are located in a place with limited connectivity.
 -  When you want to efficiently process the data locally to get low latency access to the data, such that you can respond to emergencies as quickly as possible.
 -  When you want to reduce bandwidth costs and avoid transferring terabytes of data to the cloud. You can process the data locally and send only the processed data to the cloud.

> [!NOTE]
> Azure SQL Edge is another local storage option for IoT Edge devices. Azure SQL Edge is an optimized relational database engine geared for IoT and IoT Edge deployments. You can read more about Azure SQL Edge here: [https://docs.microsoft.com/azure/azure-sql-edge/overview](/azure/azure-sql-edge/overview)

## Supported storage operations

Blob storage modules on IoT Edge use the Azure Storage SDKs, and are consistent with the 2017-04-17 version of the Azure Storage API for block blob endpoints.

Because not all Azure Blob Storage operations are supported by Azure Blob Storage on IoT Edge, this section lists the status of each.

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **Supported**
  :::column-end:::
  :::column:::
    **Unsupported**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Account**
  :::column-end:::
  :::column:::
    List containers.
  :::column-end:::
  :::column:::
    Get and set blob service properties.
Preflight blob request.
Get blob service stats.
Get account information.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Containers**
  :::column-end:::
  :::column:::
    Create and delete container.
Get container properties and metadata.
List blobs.
Get and set container ACL.
Set container metadata.
  :::column-end:::
  :::column:::
    Lease container.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Blobs**
  :::column-end:::
  :::column:::
    Put, get, and delete blob.
Get and set blob properties.
Get and set blob metadata.
  :::column-end:::
  :::column:::
    Lease blob.
Snapshot blob.
Copy and abort copy blob.
Undelete blob.
Set blob tier.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Block Blobs**
  :::column-end:::
  :::column:::
    Put block.
Put and get blocklist.
  :::column-end:::
  :::column:::
    Put block from URL.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Append Blobs**
  :::column-end:::
  :::column:::
    Append block.
  :::column-end:::
  :::column:::
    Append block from URL.
  :::column-end:::
:::row-end:::


## Deploying Azure Blob Storage on to IoT Edge

There are several ways to deploy modules to an IoT Edge device and all of them work for Azure Blob Storage on IoT Edge modules. The two simplest methods are to use the Azure portal or Visual Studio Code templates. In either case, you would follow flow similar to the following:

1.  Deploy the Blob storage module like any other module. The image URI is: **mcr.microsoft.com/azure-blob-storage:latest**
2.  Set Create Container Options to be an appropriate JSON document:
    
    ```json
    "Env":[
        "LOCAL_STORAGE_ACCOUNT_NAME=<your storage account name>",
        "LOCAL_STORAGE_ACCOUNT_KEY=<your storage account key>"
    ],
    "HostConfig":{
        "Binds": ["<storage mount>"],
        "PortBindings":{
            "11002/tcp": [{"HostPort":"11002"}]
        }
    }
    
    ```
3.  Set Module Twin Settings to be an appropriate JSON document:
    
    ```json
    "<your azureblobstorageoniotedge module name>":{
        "properties.desired": {
            "deviceAutoDeleteProperties": {
                "deleteOn": <true, false>,
                "deleteAfterMinutes": <timeToLiveInMinutes>,
                "retainWhileUploading": <true, false>
            },
            "deviceToCloudUploadProperties": {
                "uploadOn": <true, false>,
                "uploadOrder": "<NewestFirst, OldestFirst>",
                "cloudStorageConnectionString": "DefaultEndpointsProtocol=https;AccountName=<your Azure Storage Account Name>;AccountKey=<your Azure Storage Account Key>;EndpointSuffix=<your end point suffix>",
                "storageContainersForUpload": {
                    "<source container name1>": {
                    "target": "<target container name1>"
                }
            },
            "deleteAfterUpload": <true, false>
            }
        }
    }
    
    ```

Blob storage modules include **deviceToCloudUpload** and **deviceAutoDelete** features.

**deviceToCloudUpload** is a configurable functionality. This function automatically uploads the data from your local blob storage to Azure with intermittent internet connectivity support. It allows you to:

 -  Turn ON/OFF the deviceToCloudUpload feature.
 -  Choose the order in which the data is copied to Azure like NewestFirst or OldestFirst.
 -  Specify the Azure Storage account to which you want your data uploaded.
 -  Specify the containers you want to upload to Azure. This module allows you to specify both source and target container names.

    > [!NOTE]
    > Remember that in this context, "container" refers to the top-level blob storage organization system, and not compute containers.

 -  Choose the ability to delete the blobs immediately, after upload to cloud storage is finished.
 -  Do full blob upload (using `Put Blob` operation) and block level upload (using `Put Block` and `Put Block List` operations).

This module uses block level upload, when your blob consists of blocks. Here are some of the common scenarios:

 -  Your application updates some blocks of a previously uploaded blob, this module uploads only the updated blocks and not the whole blob.
 -  The module is uploading blob and internet connection goes away, when the connectivity is back again it uploads only the remaining blocks and not the whole blob.

If an unexpected process termination (like power failure) happens during a blob upload, all blocks that were due for the upload will be uploaded again once the module comes back online.

**deviceAutoDelete** is a configurable functionality. This function automatically deletes your blobs from the local storage when the specified duration (measured in minutes) expires. It allows you to:

 -  Turn ON/OFF the deviceAutoDelete feature.
 -  Specify the time in minutes (deleteAfterMinutes) after which the blobs will be automatically deleted.
 -  Choose the ability to retain the blob while it's uploading if the deleteAfterMinutes value expires.

## deviceToCloudUpload and deviceAutoDelete properties

Use the module's desired properties to set deviceToCloudUploadProperties and deviceAutoDeleteProperties. Desired properties can be set during deployment or changed later by editing the module twin without the need to redeploy. We recommend checking the "Module Twin" for reported configuration and configurationValidation to make sure values are correctly propagated.

### deviceToCloudUploadProperties

The name of this setting is deviceToCloudUploadProperties. If you are using the IoT Edge simulator, set the values to the related environment variables for these properties, which you can find in the explanation section.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Possible Values**
  :::column-end:::
  :::column:::
    **Explanation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    uploadOn
  :::column-end:::
  :::column:::
    true, false
  :::column-end:::
  :::column:::
    Set to false by default. If you want to turn on the feature, set this field to true.

Environment variable: deviceToCloudUploadProperties\_\_uploadOn=\{false,true\}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    uploadOrder
  :::column-end:::
  :::column:::
    NewestFirst, OldestFirst
  :::column-end:::
  :::column:::
    Allows you to choose the order in which the data is copied to Azure. Set to OldestFirst by default. The order is determined by last modified time of Blob.

Environment variable: deviceToCloudUploadProperties\_\_uploadOrder=\{NewestFirst,OldestFirst\}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    cloudStorageConnectionString
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    "DefaultEndpointsProtocol=https;AccountName=&lt;your Azure Storage Account Name&gt;;AccountKey=&lt;your Azure Storage Account Key&gt;;EndpointSuffix=&lt;your end point suffix&gt;" is a connection string that allows you to specify the storage account to which you want your data uploaded. Specify Azure Storage Account Name, Azure Storage Account Key, End-point suffix. Add appropriate EndpointSuffix of Azure where data will be uploaded, it varies for Global Azure, Government Azure, and Microsoft Azure Stack.

You can choose to specify Azure Storage SAS connection string here. But you have to update this property when it expires.

Environment variable: deviceToCloudUploadProperties\_\_cloudStorageConnectionString=&lt;connection string&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    storageContainersForUpload
  :::column-end:::
  :::column:::
    "&lt;source container name1&gt;": \{"target": "&lt;target container name&gt;"\},

"&lt;source container name1&gt;": \{"target": "%h-%d-%m-%c"\},

"&lt;source container name1&gt;": \{"target": "%d-%c"\}
  :::column-end:::
  :::column:::
    Allows you to specify the container names you want to upload to Azure. This module allows you to specify both source and target container names. If you don't specify the target container name, it will automatically assign the container name as &lt;IoTHubName&gt;-&lt;IotEdgeDeviceID&gt;-&lt;ModuleName&gt;-&lt;SourceContainerName&gt;. You can create template strings for target container name, check out the possible values column.
\* %h -&gt; IoT Hub Name (3-50 characters).
\* %d -&gt; IoT Edge Device ID (1 to 129 characters).
\* %m -&gt; Module Name (1 to 64 characters).
\* %c -&gt; Source Container Name (3 to 63 characters).

Maximum size of the container name is 63 characters, while automatically assigning the target container name if the size of container exceeds 63 characters it will trim each section (IoTHubName, IotEdgeDeviceID, ModuleName, SourceContainerName) to 15 characters.

Environment variable:
deviceToCloudUploadProperties\_\_storageContainersForUpload\_\_&lt;sourceName&gt;\_\_target=&lt;targetName&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deleteAfterUpload
  :::column-end:::
  :::column:::
    true, false
  :::column-end:::
  :::column:::
    Set to false by default. When it is set to true, it will automatically delete the data when upload to cloud storage is finished.

Environment variable: deviceToCloudUploadProperties\_\_deleteAfterUpload=\{false,true\}
  :::column-end:::
:::row-end:::


### deviceAutoDeleteProperties

The name of this setting is deviceAutoDeleteProperties. If you are using the IoT Edge simulator, set the values to the related environment variables for these properties, which you can find in the explanation section.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Possible Values**
  :::column-end:::
  :::column:::
    **Explanation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deleteOn
  :::column-end:::
  :::column:::
    true, false
  :::column-end:::
  :::column:::
    Set to false by default. If you want to turn on the feature, set this field to true.

Environment variable: deviceAutoDeleteProperties\_\_deleteOn=\{false,true\}
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deleteAfterMinutes
  :::column-end:::
  :::column:::
    &lt;minutes&gt;
  :::column-end:::
  :::column:::
    Specify the time in minutes. The module will automatically delete your blobs from local storage when this value expires.

Environment variable: deviceAutoDeleteProperties\_\_ deleteAfterMinutes=&lt;minutes&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    retainWhileUploading
  :::column-end:::
  :::column:::
    true, false
  :::column-end:::
  :::column:::
    By default it is set to true, and it will retain the blob while it is uploading to cloud storage if deleteAfterMinutes expires. You can set it to false and it will delete the data as soon as deleteAfterMinutes expires. For this property to work uploadOn should be set to true.

Environment variable: deviceAutoDeleteProperties\_\_retainWhileUploading=\{false,true\}
  :::column-end:::
:::row-end:::


## Connect to your blob storage module

You can use the account name and account key that you configured for your module to access the blob storage on your IoT Edge device.

Specify your IoT Edge device as the blob endpoint for any storage requests that you make to it. You can create a connection string for an explicit storage endpoint using the IoT Edge device information and the account name that you configured.

 -  For modules that are deployed on the same device as where the Azure Blob Storage on IoT Edge module is running, the blob endpoint is: `http://<module name>:11002/<account name>`.
 -  For modules or applications running on a different device, you have to choose the right endpoint for your network. Depending on your network setup, choose an endpoint format such that the data traffic from your external module or application can reach the device running the Azure Blob Storage on IoT Edge module. The blob endpoint for this scenario is one of:
    
     -  `http://<device IP >:11002/<account name>`
     -  `http://<IoT Edge device hostname>:11002/<account name>`
     -  `http://<fully qualified domain name>:11002/<account name>`

## Connect to your local storage with Azure Storage Explorer

You can use Azure Storage Explorer to connect to your local storage account.

1.  Download and install Azure Storage Explorer.
2.  Connect to Azure Storage using a connection string.
3.  Provide connection string: `DefaultEndpointsProtocol=http;BlobEndpoint=http://<host device name>:11002/<your local account name>;AccountName=<your local account name>;AccountKey=<your local account key>;`
4.  Go through the steps to connect.
5.  Create container inside your local storage account.
6.  Start uploading files as Block blobs.
7.  You can choose to connect your Azure storage accounts in Storage Explorer, too. This configuration gives you a single view for both your local storage account and Azure storage account.

> [!NOTE]
> This module does not support Page blobs.
