Now that you understand the different ways to sell your virtual machine (VM) offer through Microsoft, we’ll review information that will help you create your VM image for Azure Marketplace. We’ll cover the process of building, configuring, and testing your VM image before publishing it to Azure Marketplace. The information provided in this unit is meant to give you a high-level view of the VM image creation process, providing links to more detailed documentation for help as you build your VM.

When you publish your VM to Azure Marketplace, you’ll connect the VM image that contains your software with the offer information you provide in Partner Center. To make the connection, your VM image needs to be stored in either a Shared Image Gallery (SIG) or on an unmanaged virtual hard disk (VHD) in an Azure storage account. We recommend using the SIG approach, because it simplifies the technical configuration of your offer in Partner Center.

>[!TIP]
>The Azure subscription that contains the SIG with your VM image must be under the same Azure tenant as your Partner Center publisher account. If the Partner Center account isn't associated with the same Azure tenant, you won't be able to access your SIG image.

## Building your VM image

When you create your VM, you can start with an approved base image, or build a custom VM image that contains your software. There are a variety of ways to create your offer's base VM image, including third-party software products that automate the process. In this section, we’ll provide an overview of using a tool called Packer to build a VM that you’ll use to create your offer.

>[!NOTE]
>Packer is a third-party, open-source tool for creating machine images.

Using a tool like Packer can help you simplify and automate the build process. To build with Packer, you'll create a JSON file template that defines the build process. Using the template, Packer builds a VM that you can use to create an image for your offer. You'll be able to define your template to have Packer automatically publish your image in a SIG, which you'll use to create your VM offer in Partner Center. For detailed guidance on using Packer to create VM images, reference our documentation for [Windows](/azure/virtual-machines/windows/build-image-with-packer) and [Linux](/azure/virtual-machines/linux/build-image-with-packer). Once you’ve completed that process, you'll be ready to install your software on the VM and configure it to run as intended.

>[!TIP]
>For help with building your JSON file template for Packer, reference their [Azure Resource Manager Builder documentation](https://www.packer.io/docs/builders/azure/arm). For specific guidance to help publish your VM image in a SIG, reference the [JSON example](https://www.packer.io/docs/builders/azure/arm#shared_image_gallery_destination) in the *Shared Image Gallery Destination* section of the Packer documentation.

As you prepare your image for Azure Marketplace, you’ll need to install the most current updates to the OS and all installed services. You’ll also need to make sure that you perform other required security checks. For more information, check out our [documentation on security recommendations for Azure Marketplace images](/azure/security/fundamentals/azure-marketplace-images).

Once you’ve installed your software and configured the image, you’ll need to generalize the image. Generalizing the image removes all instance-specific identifiers and software drivers, making it possible for customers to use various Azure VM types and sizes to deploy your software. You can use a tool called Sysprep to generalize Windows VMs and the Microsoft Azure Linux Agent (waagent) to generalize Linux VMs. For more detail on generalization, reference our [documentation on generalizing VM images](/azure/marketplace/azure-vm-create-using-approved-base#generalize-the-image).

## Testing your VM image

You should test your generalized image by deploying it on an Azure VM. To do so, you’ll run validations on the deployed image by running a certification test. For a step-by-step walk-through of different approaches to testing your generalized image, reference our [article on testing a VM image](/azure/marketplace/azure-vm-image-test).

## Maintaining your image

 The [commercial marketplace certification policies](/legal/marketplace/certification-policies?context=/azure/marketplace/context/context) dictate that your offer should maintain a high level of security. To ensure your VM offer is compliant, you should periodically update your image's OS and all installed services with the latest security and maintenance patches. Microsoft periodically scans VM images for any significant Common Vulnerabilities and Exposures (CVE). Images that fail these assessments can be removed from Azure Marketplace until the CVE is patched.

>[!TIP]
>As we mentioned at the beginning of this unit, there are a variety of ways to create your offer's base VM images. Be sure to reference our documentation on [creating a VM from an approved base](/azure/marketplace/azure-vm-create-using-approved-base) and [creating a VM using your own image](/azure/marketplace/azure-vm-create-using-own-image) for more details on the process.

## Other resources to help you get started

For more learning opportunities, including videos for every stage of the process, check out the [Mastering VM offers](https://aka.ms/MasteringTheMarketplace/vm) series. These demo-heavy modules take you all the way from creating a new VM in Azure through publishing a custom VM offer to the Microsoft commercial marketplace.
