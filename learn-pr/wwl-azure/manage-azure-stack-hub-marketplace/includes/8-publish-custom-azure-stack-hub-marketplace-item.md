To publish a custom marketplace item, do the following:

1.  Use PowerShell or Azure Storage Explorer to upload your Marketplace item (.azpkg) to Azure Blob storage. You can upload to local Azure Stack Hub storage or upload to Azure Storage, which is a temporary location for the package. Make sure that the blob is publicly accessible.
2.  To import the gallery package into Azure Stack Hub, the first step is to remotely connect (RDP) to the client virtual machine, in order to copy the file you created to your Azure Stack Hub.
3.  Add a context:

```PowerShell
$ArmEndpoint = "https://adminmanagement.local.azurestack.external"
Add-AzEnvironment -Name "AzureStackAdmin" -ArmEndpoint $ArmEndpoint
Add-AzAccount -EnvironmentName "AzureStackAdmin"

```

4.  Run the following script to import the resource into your gallery:

```PowerShell
Add-AzsGalleryItem -GalleryItemUri `
https://sample.blob.core.windows.net/<temporary blob name>/<offerName.publisherName.version>.azpkg -Verbose

```

5.  Verify that you have a valid Storage account that is available to store your item. You can get the `GalleryItemURI` value from the Azure Stack Hub administrator portal. Select **Storage account -&gt; Blob Properties -&gt; URL**, with the extension `.azpkg`. The storage account is only for temporary use, in order to publish to the marketplace.

After completing your gallery package and uploading it using Add-AzsGalleryItem, your custom virtual machine should now appear on the Marketplace and in the Create a resource view. The custom gallery package is not visible in Marketplace Management.

:::image type="content" source="../media/marketplace-item-image-3-8644bd23.png" alt-text="Image showing custom VM appearing on the Marketplace.":::


6.  Once your item has been successfully published to the marketplace, you can delete the content from the storage account.

All default gallery artifacts and your custom gallery artifacts are now accessible without authentication under the following URLs:

 -  `https://galleryartifacts.adminhosting.[Region].[externalFQDN]/artifact/20161101/[TemplateName]/DeploymentTemplates/Template.json`
 -  `https://galleryartifacts.hosting.[Region].[externalFQDN]/artifact/20161101/[TemplateName]/DeploymentTemplates/Template.json`

7.  You can remove a Marketplace item by using the **Remove-AzGalleryItem** cmdlet. For example:

```PowerShell
Remove-AzsGalleryItem -Name <Gallery package name> -Verbose

```
