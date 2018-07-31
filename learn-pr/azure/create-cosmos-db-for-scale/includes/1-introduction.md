When you create an Azure virtual machine scale set, you specify an image to be used when the virtual machine (VM) instances are deployed. Each VM in Azure is created from an image that defines the Linux distribution and OS version. The Azure Marketplace provides many first and third-party images for most common distributions and application environments.

To reduce the number of tasks after VM instances are deployed, you can use a custom VM image. This custom VM image includes any required application installs or configurations. Any VM instances created in the scale set use the custom VM image and are ready to serve your application traffic.

[Packer](https://www.packer.io/) is an open source tool that lets you define and build custom images in a scripted, consistent manner. The configuration for an image is defined in a JSON (JavaSCript Object Notation) template that includes any additional configurations and application installs that you require. This template approach reduces the risk of human error from manual builds, and lets you create reproducible images for your applications.

## Packer components

There are two key components to Packer templates that allow you to create these consistent, reproducible images across on-prem or cloud providers like Azure:

- **Builders** - define how the based VM itself should be configured and deployed. In Azure, the builder defines the credentials when the base VM is created, the target location for the final image, the size and location of the base VM, and any tags to apply to the image.
- **Provisioners** - carry out any actual configuration tasks on the base VM as the image is prepared. These tasks could include software installation, OS or kernel updates, or applying configuration settings. Built-in provisioners exist for a native Linux bash shell, and can also integrate with Ansible, Chef, Puppet, or Salt.

The *provisioner* is where the actual configuration happens. This section of a Packer template would be consistent across all platforms. The *builder* may vary from an on-prem environment or Azure as you define how to create and deploy the base VM image. At the end of the Packer process, the base VM and resources are deleted. All that remains is the platform-specific image as defined by the builder. The image can then be used to deploy VMs in a scale set.