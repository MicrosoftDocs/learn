## Creating Azure Virtual Machine Images by using Packer

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE1Zv1f]

When you create an Azure virtual machine scale set, you specify an image to be used when the virtual machine (VM) instances are deployed. Each VM in Azure is created from an image that defines the Linux distribution and OS version. The [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace) provides many Microsoft and partner images for most common distributions and application environments.

You can use a custom VM image to reduce the number of tasks after VM instances are deployed. This custom VM image should include any required applications or configurations. Any VM instances created in the scale set use the custom VM image and are ready to serve your application traffic.

## What is Packer?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE1Zh1n]

[Packer](https://www.packer.io/) is an open-source tool that you can use to define and build custom images in a scripted, consistent way. The configuration for an image is defined in a JSON (JavaScript Object Notation) template. The template helps reduce the risk of human error from manual builds, and it lets you create reproducible images for your applications.

## Packer components

Packer templates have two key components that you can use to create these consistent, reproducible images across on-premises providers or on Azure:

- **Builders** define how the base VM should be configured and deployed. In Azure, the builder defines:
  - The credentials when the base VM is created.
  - The target location for the final image.
  - The size and location of the base VM.
  - Any tags applied to the image.
- **Provisioners** carry out configuration tasks on the base VM as the image is prepared. These tasks can include software installation, OS or kernel updates, or applying configuration settings. Built-in provisioners exist for a native Linux Bash shell and can integrate with Ansible, Chef, Puppet, or Salt.

The *provisioner* is where the configuration happens. This section of a Packer template is consistent across all platforms. The *builder* can vary from an on-premises environment or Azure as you define how to create and deploy the base VM image. At the end of the Packer process, the base VM and resources are deleted. All that remains is the platform-specific image as defined by the builder. You can then use the image to deploy VMs in a scale set.

At the end of the tutorial, you can check your knowledge with a quiz challenge.