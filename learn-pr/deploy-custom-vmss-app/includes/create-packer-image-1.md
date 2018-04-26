## Creating Azure virtual machine images

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE1Zv1fs]

When you create a Microsoft Azure virtual machine (VM) scale set, you specify an image to be used when VM instances are deployed. Each VM in Azure is created from an image that defines the Linux distribution and OS version. The[Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/) provides many first and third-party images for most common distributions and application environments.

You can use a custom VM image to reduce the number of tasks after VM instances are deployed. This custom VM image should include any required applications or configurations. Any VM instances created in the scale set use the custom VM image and are ready to serve your application traffic.

## What is Packer?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE1Zh1n]

[Packer](https://www.packer.io/) is an open source tool that lets you define and build custom images in a scripted, consistent manner. The configuration for an image is defined in a JSON (JavaScript Object Notation) template that helps reduce the risk of human error from manual builds, and lets you create reproducible images for your applications.

## Packer components

There are two key components to Packer templates that allow you to create these consistent, reproducible images across on-premises or on Azure:

- **Builders** define how the base VM is configured and deployed. In Azure, the builder defines the credentials when the base VM is created, the target location for the final image, the size and location of the base VM, and any tags applied to the image.
- **Provisioners** carry out configuration tasks on the base VM as the image is prepared. These tasks could include software installation, OS or kernel updates, or applying configuration settings. Built-in provisioners exist for the native Linux bash shell, and can also integrate with Ansible, Chef, Puppet, or Salt.

The *provisioner* handles the actual configuration. This section of a Packer template is consistent across all platforms. The *builder* may vary, depending on whether the VM is on-premises or on Azure, and on how you create and deploy the base VM image. At the end of the Packer process, the base VM and resources are deleted. All that remains is the platform-specific image as defined by the builder. The image can then be used to deploy VMs in a scale set.

At the end of the tutorial, you can to check your knowledge about this information with a quiz challenge.