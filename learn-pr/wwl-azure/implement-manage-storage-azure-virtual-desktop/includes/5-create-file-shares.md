Once you've created a storage account, you can create a file share. Standard file shares may be deployed into one of the standard tiers: transaction optimized (default), hot, or cool. This is a per file share tier that is not affected by the blob access tier of the storage account.

You can change the tier of the share at any time after it has been deployed. Premium file shares cannot be directly converted to standard file shares in any standard tier.

You can move file shares between tiers within GPv2 storage account types (transaction optimized, hot, and cool).

The **quota** property means something slightly different between premium and standard file shares:

 -  For standard file shares, it's an upper boundary of the Azure file share. The primary purpose for quota for a standard file share is budgetary: "I don't want this file share to grow beyond this point."
    
     -  If a quota is not specified, standard file share can span up to 100 TiB.
 -  For premium file shares, quota is overloaded to mean provisioned size. The provisioned size is the amount that you will be billed. Consider the following when configuring a premium file share:
    
     -  The future growth of the share from a space utilization perspective
     -  The IOPS required for your workload. Every provisioned GiB allows reserved and burst IOPS.

If you just created your storage account, you can navigate to it from the deployment screen by selecting **Go to resource**. If you have previously created the storage account, you can navigate to it via the resource group containing it. Once in the storage account, select the tile labeled **File shares.**

:::image type="content" source="../media/create-file-shares-virtual-desktop-a60eba6d.png" alt-text="A screenshot of the File shares tile":::


In the file share listing, you should see any file shares you have previously created in this storage account; an empty table if no file shares have been created yet. Select **+ File share** to create a new file share.

The new file share should appear on the screen. Complete the fields in the new file share to create a file share:

 -  **Name**: the name of the file share to be created.
 -  **Quota**: the quota of the file share for standard file shares; the provisioned size of the file share for premium file shares.
 -  **Tiers**: the selected tier for a file share. This field is only available in a **general purpose (GPv2) storage account**. You can choose transaction optimized, hot, or cool. The share's tier can be changed at any time.

Select **Create** to finishing creating the new share.

> [!NOTE]
> If your storage account is in a virtual network, you will not be able to successfully create an Azure file share unless your client is also in the virtual network. You can also work around this point-in-time limitation by using the Azure PowerShell `New-AzRmStorageShare` cmdlet.
