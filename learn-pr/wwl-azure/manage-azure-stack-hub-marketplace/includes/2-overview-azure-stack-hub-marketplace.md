Azure Stack Hub Marketplace is a collection of services, apps, and resources customized for Azure Stack Hub. Resources include networks, virtual machines (VMs), storage, and more. Use Azure Stack Hub Marketplace to create new resources and deploy new apps or browse and choose the items you want to use. To use a marketplace item, users must subscribe to an offer that grants them access to that item.

As an Azure Stack Hub operator, you decide which items to add (publish) to Azure Stack Hub Marketplace. You can publish items such as databases, app services, and more. Publishing makes items visible to all your users. You can publish custom items that you create, or you can publish items from a growing [list of Azure Marketplace items](/azure-stack/operator/azure-stack-marketplace-azure-items?view=azs-1910). When you publish an item to Azure Stack Hub Marketplace, users can see it within five minutes.

All gallery item artifacts, including images and JSON files, are accessible without authentication after making them available in the Azure Stack Hub Marketplace.

To open the Marketplace, in the administrator portal select **+ Create a resource**.

## Marketplace items

An Azure Stack Hub Marketplace item is a service, app, or resource that your users can download and use. All Azure Stack Hub Marketplace items are visible to all your users, including administrative items such as plans and offers. These administrative items don't require a subscription to view, but are non-functional to users.

Every Marketplace item has:

 -  An Azure Resource Manager template for resource provisioning.
 -  Metadata, such as strings, icons, and other marketing collateral.
 -  Formatting information to display the item in the portal.

Every item published to the Azure Stack Hub Marketplace uses the Azure Gallery Package (.azpkg) format. Add deployment or runtime resources (code, .zip files with software, or virtual machine images) to Azure Stack Hub separately, not as part of the Marketplace item.
