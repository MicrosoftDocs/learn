## Azure VM images

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE1Zv1fs]

When you create an Azure virtual machine scale set, you specify an image to be used when the virtual machine (VM) instances are deployed. Each VM in Azure is created from an image that defines the Linux distribution and OS version. The Azure Marketplace provides many Microsoft and partner images for most common distributions and application environments.

To reduce the number of tasks after VM instances are deployed, you can use a custom VM image. This custom VM image includes any required application installs or configurations. Any VM instances created in the scale set use the custom VM image and are ready to serve your application traffic.

## What is Packer?

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE1Zh1n]

[Packer](https://www.packer.io/) is an open-source tool that you can use to define and build custom images in a scripted, consistent way. The configuration for an image is defined in a JSON (JavaScript Object Notation) template that includes any additional configurations and application installations that you need. This template approach reduces the risk of human error from manual builds, and it lets you create reproducible images for your applications.

## Packer components

Packer templates have two key components that you can use to create these consistent, reproducible images across on-premises or cloud providers like Azure:

- **Builders** define how the base VM should be configured and deployed. In Azure, the builder defines:
  - The credentials when the base VM is created.
  - The target location for the final image.
  - The size and location of the base VM.
  - Any tags to apply to the image.
- **Provisioners** carry out configuration tasks on the base VM as the image is prepared. These tasks can include software installation, OS or kernel updates, or applying configuration settings. Built-in provisioners exist for a native Linux Bash shell and can integrate with Ansible, Chef, Puppet, or Salt.

The *provisioner* is where the configuration happens. This section of a Packer template is consistent across all platforms. The *builder* can vary from an on-premises environment or Azure as you define how to create and deploy the base VM image. At the end of the Packer process, the base VM and resources are deleted. All that remains is the platform-specific image as defined by the builder. You can then use the image to deploy VMs in a scale set.