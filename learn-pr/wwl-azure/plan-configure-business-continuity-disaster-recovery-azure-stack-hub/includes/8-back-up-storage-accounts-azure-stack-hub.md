This unit covers protection and recovery of storage accounts forAzure Storage accounts on Azure Stack Hub.

This section covers the overall structure of the solution and major parts.

### Application layer<br>

Data can be replicated between storage accounts on separate Azure Stack Hub scale units. Replication is done issuing multiple `PUT Blob` or `Put Block` operations to write objects to multiple locations. Alternatively, the application can issue the `Copy Blob` operation to copy the Blob to a storage account hosted on a separate scale unit after the Put operation to the primary account completes.

### Scheduled copy task

`AzCopy` is an excellent tool that can be utilized to copy data from local filesystems, Azure Cloud Storage, Azure Stack Hub Storage, and s3. Currently, `AzCopy` cannot copy data between two Azure Stack Hub Storage Accounts. Copying objects from a source Azure Stack Hub Storage account to a target Azure Stack Hub Storage account requires an intermediary local filesystem.

### Azure Stack Hub (source)

Azure Stack Hub (source) is the source of the storage account data you would like to back up.

You need the Source Storage Account URL and SAS Token. For instruction on working with a storage account, see [Get started with Azure Stack Hub storage development tools](/azure-stack/user/azure-stack-storage-dev?view=azs-2008).

### Azure Stack Hub (target)

Azure Stack Hub (target) is the target that will store the account data you would like to back up. The target Azure Stack Hub instance must be in a different location from your target Azure Stack Hub. And the source will need to be able to connect to the target.

### Intermediary local filesystem

Run `AzCopy` to store data when copying from your source and then writing to your target Azure Stack Hub. This is an intermediate server in your source Azure.

## Set up backup for storage accounts

1.  Retrieve the Blob Endpoint for the source and target storage accounts.

2.  Create and record SAS Tokens for the source and target storage accounts.

3.  Install **`AzCopy`** on the intermediary server and set the API Version to account for Azure Stack Hub Storage Accounts.

**For Windows Server:**

 -  In a command prompt use: `set AZCOPY_DEFAULT_SERVICE_API_VERSION=2017-11-09`
 -  ‎In PowerShell use: `$env:AZCOPY_DEFAULT_SERVICE_API_VERSION="2017-11-09"`

**For a Linux (Ubuntu) server:**

```

export AZCOPY_DEFAULT_SERVICE_API_VERSION=2017-11-09


```

On your intermediate server, create script. Update this command with your **storage account, SAS key**, and **local directory path**. You'll run the script to copy data incrementally from the **source** storage account.

```

azcopy sync "https:/<storagaccount>/<container>?<SAS Key>" "C:\\myFolder" --recursive=true --delete-destination=true


```

Enter the **storage account, SAS key**, and **local directory path**. You'll use this to copy data incrementally to the **target** storage account.

```

azcopy sync "C:\\myFolder" "https:// <storagaccount>/<container>?<SAS Key>" --recursive=true --delete-destination=true


```

Use Cron or Windows Task Scheduler to schedule the copy from the source Azure Stack Hub storage account to Local Storage on the intermediate server. Then copy from local storage in the intermediate server to the target Azure Stack Hub storage account.

The RPO you can achieve with this solution will be determined by the /MO parameter value and the network bandwidth between the source account and the intermediary server and the intermediary server and the target account.

## Use your storage account in a disaster

Each Azure Stack Hub Storage account possesses a unique DNS name derived from the name of the Azure Stack Hub region itself, for example, https://krsource.blob.east.asicdc.com/. Applications writing to and reading from this DNS Name will need to accommodate the storage account DNS name change when the target account, for example, `https://krtarget.blob.west.asicdc.com/` needs to be used during a disaster.

Application connection strings can be modified after a disaster is declared to account for the relocation of the objects or, if a CNAME record is used in front of a load balancer front-ending the source and target storage accounts, the load balancer can be configured with a manual failover algorithm that will allow the administrator to declare the target.

If SAS is used by the application rather than AAD or AD FS, the above method will not work. Application connection strings will need to be updated with the target storage account URL and the SAS key(s) generated for the target storage account.
