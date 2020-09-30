

Building VMs from managed images can save Contoso IT operations staff time and effort. However, as they're building a significant number of VMs, you want to extend this capability further and are investigating if *Azure VM Image Builder* (Azure Image Builder) can help them. You want to know if, by using Azure Image Builder, Contoso can provide a simple configuration that describes the image, submit it to the Azure Image Builder service, and the image is built and distributed.

> [!IMPORTANT]
> At the time of writing, July 2020, Azure Image Builder is in public preview and isn't yet advised for production workloads.

## What is Azure Image Builder?

Azure Image Builder enables you to add your own customizations to existing images from a number of locations. After you create your images, you can specify where you would like your images hosted.

> [!TIP]
> You can host your images in either the Azure Shared Image Gallery, or as a managed image or a VHD.

In the current preview version of Azure Image Builder, you can perform the tasks described in the following table.

|Task|Description|
|----------------------|-----------|
|Create golden baseline images|Includes your minimum security and organizational configurations, and enables departments to further customize them for their needs.|
|Patch existing images|Enables you to continually patch existing custom images.|
|Connect to existing virtual networks (VNets)|Connects with existing VNets, enabling you to connect to existing configuration servers, file shares, or any other routable servers/services.|
|Integrate with Azure Shared Image Gallery|Enables you to manage versions, and distribute and scale images globally. Also provides you with an image management system.|
|Integrate image build pipelines from your own organization|Enables integration with your existing image build procedures (pipelines). You can link to Azure Image Builder from your pipeline, or use the simple **Preview Image Builder Azure DevOps Task**.|
|Migrate an existing image customization pipeline to Azure|Enables you to use your existing scripts, commands, and processes to customize images.|
|Create images in VHD format|Enables you to support Azure Stack.|

## How it works

Azure Image Builder is a fully managed Azure service that you can access through an Azure resource provider. The Azure Image Builder process has three main parts:

- Source
- Customizer
- Distribute

These parts are represented in a template. The diagram displays the components with some of their properties.

![A diagram with the Azure Image Builder as three components, as described in the preceding text.](../media/m6-image-builder.png)

You can source images from these locations:

- Windows (or Linux-based) Azure Marketplace images
- Existing organizational managed images

After you acquire the images from the appropriate source, you can customize them to your needs, and then distribute them to the appropriate storage location. These are:

- As a VHD
- As a managed image
- In the Shared Image Gallery

To create images with Azure Image Builder, start by creating an image template, and then perform the following high-level steps:

1. Create the image template as a .json file. This .json file contains information about the image source, customizations, and distribution.
2. Submit the template to the service. This creates an Image Template artifact in the resource group that you specify. In the background, Azure Image Builder downloads the source image or .iso, and any required scripts. These elements are stored in a separate resource group that is automatically created in your subscription. This automatically created resource group is named using the following format: `IT_<DestinationResourceGroup>_<TemplateName>_<GUID>`.
3. After you create the image template, you can then build the image. In the background, Azure Image Builder uses the template and source files to create the following objects in the `IT_<DestinationResourceGroup>_<TemplateName>_<GUID>` resource group:
    - A VM
    - A network
    - A public IP
    - A Network Security Group (NSG)
    - Required storage

    > [!NOTE]
    > The VM is sized using the Standard_D1_v2 size.

4. As part of the image creation, Image builder distributes the image according to the settings in your .json template, then deletes the additional resources in the `IT_<DestinationResourceGroup>_<TemplateName>_<GUID>` resource group that was created for the process.

![A diagram with the Azure Image Builder components, and the process of creating images with Azure Image Builder as described in the preceding text.](../media/m6-image-builder-process.png)
