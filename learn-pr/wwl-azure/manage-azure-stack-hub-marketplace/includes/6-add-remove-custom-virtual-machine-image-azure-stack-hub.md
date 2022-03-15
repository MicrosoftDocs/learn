You can add virtual machine images to the Azure Stack Hub Marketplace through the administrator portal or Windows PowerShell. Use either an image from global Microsoft Azure Marketplace as a base for your custom image, or create your own using Hyper-V.

You will want to create a generalized image before offering the image to your users. When creating images available for your tenants, use the Azure Stack Hub administrative portal or administrator endpoints rather than the user portal or tenant directory endpoints.

You have two options for making an image available to your users:

 -  **Offer an image only accessible using Azure Resource Manager.** ‎If you add the image via the Azure Stack Hub administrative portal in **Compute &gt; Images**, all of your tenants can access the image. However your users will need to use an Azure Resource Manager template to access it. It won't be visible in your Azure Stack Hub Marketplace.
 -  **Offer an image through the Azure Stack Hub Marketplace.** ‎Once you have added your image through the Azure Stack Hub administrative portal, you can then create a marketplace offering.

## Add a platform image

To add a platform image to Azure Stack Hub, use the Azure Stack Hub administrator portal or endpoint using PowerShell, you first create a generalized VHD.

Add the virtual machine image as an Azure Stack Hub operator using the portal.

1.  Sign in to Azure Stack Hub as an operator. Select **Dashboard** from the left-hand navigation.
2.  In the **Resource providers** list, select **Compute**.
    
    :::image type="content" source="../media/add-and_remove-custom-image-image-1-3c08f7ae.png" alt-text="Image of adding the virtual machine image.":::
    

3.  Select **VM images**, then select **Add**.
    
    :::image type="content" source="../media/add-and_remove-custom-image-image-2-304f3b5a.png" alt-text="Image of adding a virtual machine image.":::
    

4.  Under **Create image**, enter the **Publisher, Offer, SKU, Version**, and OS disk blob URI. Then, select **Create** to begin creating the virtual machine image.
    
    :::image type="content" source="../media/add-and_remove-custom-image-image-3-0b2bb890.png" alt-text="Image of custom image sideloading user interface.":::
    

When the image is successfully created, the virtual machine image status changes to **Succeeded**.

5.  When you add an image, it is only available for Azure Resource Manager-based templates and PowerShell deployments. To make an image available to your users as a marketplace item, publish the marketplace item using the steps in the next lesson for creating and publishing a Marketplace item.

## Remove a platform image

You can remove a platform image using the portal or PowerShell.

To remove the virtual machine image as an Azure Stack Hub operator using the Azure Stack Hub portal, follow these steps:

1.  Open the Azure Stack Hub [administrator portal](https://portal.azure.com/signin/index).
2.  If the virtual machine image has an associated Marketplace item, select **Marketplace management**, and then select the virtual machine marketplace item you want to delete.
3.  If the virtual machine image does not have an associated Marketplace item, navigate to **All services &gt; Compute &gt; VM Images**, and then select the ellipsis (...) next to the virtual machine image.
4.  Select **Delete**.
