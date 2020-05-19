You have learned the origins of a datacenter, from its roots in mainframe computers to the newest trends, and about what goes inside a datacenter (cooling, power, servers, network, and more), as well as some of the design criteria for various components in a datacenter. 

In designing large datacenters, it is not possible to follow the same practices as for a small datacenter. To truly leverage the economies of scale, it is important that the datacenter have a software layer that allows resources to be governed and managed easily. The cloud software stack is a platform to run a cloud given a pool of physical resources. Since most cloud service providers (CSPs) are extremely wary of revealing their techniques (since it is their intellectual property), we have to rely on reverse engineering, rumors, and the contribution of open-source cloud software stacks like OpenStack to understand the components involved. 

In this module, we will start by learning about how a software middleware layer enables all the benefits of the cloud. We will look at the simplest use case, that of resource provisioning, and understand that a long series of steps is involved in handling a simple resource request. Of course, cloud providers charge for every quantifiable resource that a user utilizes. We must understand the details of the billing and monitoring systems that enable CSPs to profit from their datacenters. Automation and orchestration are important techniques that we will look at to enable the low staff-to-resource ratio at CSPs, and drive down their effective costs.

Finally, we'll look at OpenStack, an increasingly popular software platform that allows anyone with physical resources to create a cloud environment.

## Learning objectives

In this module, you will:
- Recall the various features provided by cloud middleware.
- Describe the resource provisioning process from the context of a cloud service provider.
- Recall the issues related to resource metering for cloud service providers.
- Describe the metering architecture in OpenStack's Ceilometer.
- Recall the concept of cloud orchestration and enumerate its benefits.
- Recall the service components of OpenStack and identify their individual functions.

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers.
- Know the technologies that enable cloud computing.
- Understand how cloud service providers pay for and bill for the cloud.
- Know what datacenters are and why they exist.
- Know how datacenters are set up, powered, and provisioned.

