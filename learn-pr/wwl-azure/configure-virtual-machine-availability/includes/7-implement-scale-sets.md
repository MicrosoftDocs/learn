Virtual machine scale sets are an Azure Compute resource you can use to deploy and manage a set of **identical** VMs. With all VMs configured the same, virtual machine scale sets are designed to support true autoscale. No pre-provisioning of VMs is required. It is easier to build large-scale services targeting big compute, big data, and containerized workloads. As demand goes up more virtual machine instances can be added. As demand goes down virtual machines instances can be removed. The process can be manual or automated or a combination of both.

## Scale set benefits

 -  All VM instances are created from the same base OS image and configuration. This approach lets you easily manage hundreds of VMs without additional configuration tasks or network management.
 -  Scale sets support the use of the Azure load balancer for basic layer-4 traffic distribution, and Azure Application Gateway for more advanced layer-7 traffic distribution and SSL termination.
 -  Scale sets are used to run multiple instances of your application. If one of these VM instances has a problem, customers continue to access your application through one of the other VM instances with minimal interruption.
 -  Customer demand for your application may change throughout the day or week. To match customer demand, scale sets can automatically increase the number of VM instances as application demand increases, then reduce the number of VM instances as demand decreases. This is known as autoscale.
 -  Scale sets support up to 1,000 VM instances. If you create and upload your own custom VM images, the limit is 600 VM instances.
