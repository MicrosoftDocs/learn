When you create an Azure virtual machine scale set, you specify an image to be used when the virtual machine (VM) instances are deployed. Each VM in Azure is created from an image that defines the Linux distribution and OS version. The Azure Marketplace provides many first and third-party images for most common distributions and application environments.

To reduce the number of tasks after VM instances are deployed, you can use a custom VM image. This custom VM image includes any required application installs or configurations. Any VM instances created in the scale set use the custom VM image and are ready to serve your application traffic.

This quickstarts module show you how to use the open source tool [Packer](https://www.packer.io/) to define and build custom images in Azure.