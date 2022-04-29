FSLogix addresses many profile container challenges. Key among them are:

 -  **Performance**: The FSLogix profile containers are high performance and resolve performance issues that have historically blocked cached exchange mode.
 -  **OneDrive**: Without FSLogix profile containers, OneDrive for Business is not supported in non-persistent RDSH or VDI environments.
 -  **Additional folders**: FSLogix extends user profiles to include additional folders.

## Azure Files integration with Azure Active Directory Domain Service

FSLogix profile containers' performance and features take advantage of the cloud using Azure Files authentication with Azure Active Directory Domain Service (AD DS). By addressing both cost and administrative overhead, Azure Files with Azure AD DS Authentication is a premium solution for user profiles in the Azure Virtual Desktop service.

:::image type="content" source="../media/azure-file-sync-f695525c.png" alt-text="Diagram of Azure file sync with Azure storage.":::


## Best practices for Azure Virtual Desktop

Azure Virtual Desktop offers full control over size, type, and count of VMs that are being used by customers.

To ensure your Azure Virtual Desktop environment follows best practices:

 -  Azure Files storage account must be in the same region as the session host VMs.
 -  Azure Files permissions should match permissions described in [Requirements - Profile Containers](/fslogix/fslogix-storage-config-ht).
 -  Each host pool VM must be built of the same type and size VM based on the same master image.
 -  Each host pool VM must be in the same resource group to aid management, scaling and updating.
 -  For optimal performance, the storage solution and the FSLogix profile container should be in the same data center location.
 -  The storage account containing the master image must be in the same region and subscription where the VMs are being provisioned.
