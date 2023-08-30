An Azure Compute Gallery simplifies custom image sharing across your organization. Custom images are like marketplace images, but you create them yourself. Custom images can be used to bootstrap deployment tasks like preloading applications, application configurations, and other OS configurations.

The Azure Compute Gallery lets you share your custom VM images with others in your organization, within or across regions, within an Azure Active Directory tenant. Choose the images you want to share, the regions you want to make them available in, and who you want to share them with. You can create multiple galleries so that you can logically group shared images.

The gallery is a top-level resource that provides full Azure role-based access control (RBAC). Images can be versioned, and you can choose to replicate each image version to a different set of Azure regions. The gallery only works with Managed Images.

Azure Compute Gallery is a service that helps you build structure and organization around images. Azure Compute Gallery provides:

 -  Global replication of images.
 -  Versioning and grouping of images for easier management.
 -  Highly available images with Zone Redundant Storage (ZRS) accounts in regions that support Availability Zones. ZRS offers better resilience against zonal failures.
 -  Premium storage support (Premium\_LRS).
 -  Sharing across subscriptions, and even between Active Directory (AD) tenants, using role-based access control (RBAC).
 -  Scaling your deployments with image replicas in each region.

Using an Azure Compute Gallery you can share your images to different users, service principals, or AD groups within your organization. Shared images can be replicated to multiple regions, for quicker scaling of your deployments.

Use an Azure Compute Gallery as a repository for images you want to make available within your company.

The Azure Compute Gallery feature has multiple resource types:<br>

| **Resource**     | **Description**                                                                                                                                                                                                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Image source     | A resource that can be used to create an image version in an image gallery. An image source can be an existing Azure VM that is generalized or specialized, a Managed image or a snapshot.                                                                                                                                |
| Image gallery    | Like the Azure Marketplace, an image gallery is a repository for managing and sharing images, but you control who has access.                                                                                                                                                                                             |
| Image definition | Image definitions are created within a gallery and carry information about the image and requirements for using it internally. Includes whether the image is Windows or Linux, release notes, and minimum and maximum memory requirements.                                                                                |
| Image version    | An image version is what you use to create a VM when using a gallery. You can have multiple versions of an image as needed for your environment. Like a managed image, when you use an image version to create a VM, the image version is used to create new disks for the VM. Image versions can be used multiple times. |

## Image definitions

Image definitions are a logical grouping for versions of an image. The image definition holds information about why the image was created. An image definition is like a plan for all of the details around creating a specific image. You don't deploy a VM from an image definition, but from the image versions created from the definition.

There are three parameters for each image definition that are used in combination - Publisher, Offer, and SKU to find a specific image definition. You can have image versions that share one or two, but not all three values. For example, here are three image definitions and their values:

| **Image Definition** | **Publisher** | **Offer** | **Sku**  |
| -------------------- | ------------- | --------- | -------- |
| myImage1             | Contoso       | Finance   | Backend  |
| myImage2             | Contoso       | Finance   | Frontend |
| myImage3             | Testing       | Finance   | Frontend |

All three of these have unique sets of values. The format is similar to how to specify publisher, offer, and SKU for Azure Marketplace images in Azure PowerShell to find the latest version of a Marketplace image. Each image definition needs to have a unique set of these values.

## Regional Support

All public regions can be target regions, but certain regions require that customers go through a request process in order to gain access. To request that a subscription is added to the list for a region such as Australia Central or Australia Central 2, submit an access request.

## Limits

There are limits, per subscription, for deploying resources using Azure Compute Galleries:

 -  100 shared image galleries, per subscription, per region.
 -  1,000 image definitions, per subscription, per region.
 -  10,000 image versions, per subscription, per region.
 -  10 image version replicas, per subscription, per region.
 -  Any disk attached to the image must be less than or equal to 1TB in size.

## Scaling

Azure Compute Gallery allows you to specify the number of replicas you want Azure to keep. Replication helps in multi-VM deployment scenarios as the VM deployments can be spread to different replicas reducing the chance of instance creation processing being throttled due to overloading of a single replica.

With Azure Compute Gallery, you can now deploy up to a 1,000 VM instances in a virtual machine scale set (up from 600 with managed images). Image replicas provide for better deployment performance, reliability, and consistency. You can set a different replica count in each target region, based on the scale needs for the region. Since each replica is a deep copy of your image, replicas help scale your deployments linearly with each extra replica. While we understand no two images or regions are the same, here’s our general guideline on how to use replicas in a region:

 -  For non-Virtual Machine Scale Set deployments - For every 20 VMs that you create concurrently, we recommend you keep one replica. For example, if you're creating 120 VMs concurrently using the same image in a region, we suggest you keep at least 6 replicas of your image.
 -  For Virtual Machine Scale Set deployments - For every scale set deployment with up to 600 instances, we recommend you keep at least one replica. For example, if you're creating 5 scale sets concurrently, each with 600 VM instances using the same image in a single region, we suggest you keep at least 5 replicas of your image.

We always recommend you to overprovision the number of replicas due to factors like image size, content, and OS type.

:::image type="content" source="../media/scaling-c888ba94.png" alt-text="Graphic showing how you can scale images":::


## Make your images highly available

Azure Zone Redundant Storage (ZRS) provides resilience against an Availability Zone failure in the region. With the general availability of Azure Compute Gallery, you can choose to store your images in ZRS accounts in regions with Availability Zones.

You can also choose the account type for each of the target regions. The default storage account type is Standard\_LRS, but you can choose Standard\_ZRS for regions with Availability Zones. Check the regional availability of ZRS here.

:::image type="content" source="../media/azure-zone-redundant-storage-choose-ca00f1b4.png" alt-text="Graphic showing ZRS.":::


## Replication

Azure Compute Gallery also allows you to replicate your images to other Azure regions automatically. Each shared Image version can be replicated to different regions depending on what makes sense for your organization. One example is to always replicate the latest image in multi-regions while all older versions are only available in one region to save on storage costs for Azure Compute Gallery versions.

The regions an Azure Compute Gallery version is replicated to can be updated after creation time. The time it takes to replicate to different regions depends on the amount of data being copied and the number of regions the version is replicated to. While the replication is happening, you can view the status of replication per region. Once the image replication is complete in a region, you can then deploy a VM or scale-set using that image version in the region.

:::image type="content" source="../media/shared-image-replication-efbf1980.png" alt-text="Graphic showing how you can replicate images.":::


## Access

The Azure Compute Gallery, Image Definition, and Image version are resources that are shared using the built-in native Azure role-based access control (RBAC) controls. Using Azure role-based access control (RBAC) you can share these resources to other users, service principals, and groups. You can even share access to individuals outside of the tenant they were created within. Once a user has access to the Azure Compute Gallery version, they can deploy a VM or a Virtual Machine Scale Set. Below is the sharing matrix that helps understand what the user gets access to:

| **Shared with User**  | **Azure Compute Gallery** | **Image Definition** | **Image version** |
| --------------------- | ------------------------- | -------------------- | ----------------- |
| Azure Compute Gallery | Yes                       | Yes                  | Yes               |
| Image Definition      | No                        | Yes                  | Yes               |
