You can download items to Azure Stack Hub from the Marketplace and make them available to all users using the Azure Stack Hub environment. The items you can choose are from a curated list of Azure Marketplace items that are pre-tested and supported to work with Azure Stack Hub. More items are frequently added to this list, so continue to check back for new content.

The [Azure Marketplace items for Azure Stack Hub](/azure-stack/operator/azure-stack-marketplace-azure-items?view=azs-1910) have a complete list of the marketplace items you can download.

There are two scenarios for downloading Marketplace products:

 -  **Connected scenario**: Requires your Azure Stack Hub environment to be connected to the internet. You use the Azure Stack Hub administrator portal to locate and download items.
 -  **Disconnected or partially connected scenario**: Requires you to access the internet using the Marketplace syndication tool to download Marketplace items. Then, you transfer your downloads to your disconnected Azure Stack Hub installation. This scenario uses PowerShell.

A connected deployment allows you to use the administrator portal to download marketplace items.

## Use the portal to download marketplace items (connected)

1.  Sign into the Azure Stack Hub administrator portal.
2.  Review the available storage space before downloading marketplace items. To review available space: in Region management, select the region you want to explore and then go to **Resource Providers &gt; Storage**:
    
    :::image type="content" source="../media/stack-marketplace-items-image-1-bfca7e24.png" alt-text="Review storage space in Azure Stack Hub administrator portal.":::
    

3.  Open Azure Stack Hub Marketplace and connect to Azure. To do so, select the **Marketplace management service**, select **Marketplace items**, and then select **Add** from Azure:
    
    :::image type="content" source="../media/stack-marketplace-items-image-2-9aae423d.png" alt-text="Add marketplace items from Azure.":::
    

4.  Each line item also shows the currently available version. If more than one version of a Marketplace item is available, the **Version** column shows Multiple.
    
    :::image type="content" source="../media/stack-marketplace-items-image-3-429a5629.png" alt-text="Screenshot that shows the available versions of a Marketplace item.":::
    

5.  If the version of an item is shown as **Multiple**, you can select that item and then choose a specific version.
    
    :::image type="content" source="../media/stack-marketplace-items-image-4-d8da0e31.png" alt-text="Add item from Azure.":::
    

6.  Select the item you want, and then select **Download**. After the download completes, you can deploy the new marketplace item as either an Azure Stack Hub operator or a user.
7.  To deploy the downloaded item, select **+ Create a resource**, and then search among the categories for the new marketplace item.
