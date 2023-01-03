Companies often have different computing environments to support each of the phases in the software-development process.

In the eCommerce company scenario, you'd use Azure DevTest Labs to create standardized labs for each of the development, testing, and customer support teams.

Here, you'll learn the key configuration settings of an Azure DevTest Labs resource. This information helps you to configure a virtualized lab environment that meets the team's needs and also complies with the organization's software standards.

## VM base images

Base images are VM images with all the tools and settings preinstalled and configured. Azure DevTest Labs supports two types of VM images for creating VMs:

- Azure Marketplace images
- Virtual machine custom images that you create from a virtual hard drive (VHD)

When you create a lab in Azure DevTest Labs, you can specify the list of base images that lab users are allowed to use for creating VMs. You'll create different labs depending on the usage scenario and requirements. For the eCommerce company, you might create different labs for development, testing, and customer support.

By default, a lab in DevTest Labs allows users access to all VM images in the Azure Marketplace. You can choose to give access to the entire Azure Marketplace or select specific VM images. For example, if your company standardizes on Windows Server 2022, you'd select only those images. Lab users would then only be able to create VMs using these images.

:::image type="content" source="../media/select-azure-marketplace-images.png" alt-text="Screenshot that shows how to select Azure Marketplace VM images in DevTest Labs." lightbox="../media/select-azure-marketplace-images.png":::

If you don't want to allow lab users access to Azure Marketplace images, select nothing from the list of Marketplace images.

Alternatively, you can create a custom VM image from a VHD. For example, you might want to create a custom image for the test team that has the testing software preinstalled in the VM. You can use the Azure portal or Azure PowerShell to create a custom image. If you have a large number of images that you need to maintain and would like to make them available throughout your company, you can also use a shared image gallery as a repository.

You can combine custom images, the shared image gallery, and Azure Marketplace images in a lab. Lab users will see all types of base images when they create a new lab VM.

## Auto-shutdown schedule

You can configure a schedule to automatically shut down all VMs in your lab at a specific time of the day or night. You can save the cost of running machines that aren't being used.

You can also set a central auto-shutdown policy to control whether lab users can schedule auto shutdown for their own individual VMs. There are three policy options:

- **User sets a schedule and can opt out**: Lab users can override or opt out of the lab schedule. This option grants VM owners full control to set their VMs' auto shutdown schedules.

- **User sets a schedule and cannot opt out**: Lab users can override the lab schedule, but they can't opt out of the auto-shutdown policy. This option ensures that every lab VM is under an auto-shutdown schedule. VM owners can update the schedule time and set up shutdown notifications.

- **User has no control over the schedule set by lab administrator**: Lab users can't alter or opt out of the lab auto-shutdown schedule. This option gives the lab administrator complete control of the schedule for all lab VMs. VM owners can still set up auto-shutdown notifications for their VMs.

## Creating a DevTest Labs resource

There are several ways to create a lab in Azure DevTest Labs. You can use the Azure portal, the Azure Command Line Interface (CLI), a PowerShell script, an ARM template, or the REST API. In this module, we'll discuss how to use the Azure portal for managing Azure DevTest Labs. In the exercises, you'll use this information to create a development lab.

To create a lab on Azure, you'll visit the Azure portal and create a **DevTest Labs** resource. A lab specifies which resources lab users can create and doesn't contain any computing resources itself.

The Azure portal provides a wizard to create a DevTest Labs resource. This wizard contains the following fields:

|Field  |Description  |
|---------|---------|
|**Subscription**     | A valid and active Azure subscription        |
|**Resource group**     | A valid resource group.        |
|**Lab name**     | The name of the lab, which needs to be unique within your subscription        |
|**Location**     |  The Azure region where your lab and the computing resources will be hosted        |
|**Public environments**     | A public environment repository contains a list of curated Azure Resource Manager templates that let lab users create PaaS resources within labs        |

Once you've created the Azure DevTest Labs resource, you can select the allowed VM base images and other lab settings in the Azure portal. From the resource **Overview** page, select **Configuration and policies** to modify the lab settings.

:::image type="content" source="../media/configuration-policies-menu.png" alt-text="Screenshot that shows the Configuration and policies menu item for Azure DevTest Labs.":::

### Environments

In Azure DevTest Labs, an environment refers to a set of Azure resources in a lab that you create by using an ARM template. The ARM template can consist of both IaaS and PaaS services.

Azure DevTest Labs provides access to a curated list of ARM templates to create PaaS or multi-VM resources. This curated list is also known as **public environments**. You can prevent users from creating environments or allow a subset of ARM templates from the list.

You can also create your own public or private repository of environments if the public environments don't match your company's requirements.
