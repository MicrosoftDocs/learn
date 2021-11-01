The most basic role of a cloud service provider (CSP) is to package and isolate virtual parts of a physical data center and provide the ability for cloud users to provision resources in the cloud. Provisioning is the process of mapping abstract resource requests by cloud users to physical resources on servers within a data center.

In IaaS, this might involve launching virtual machines (VMs) on top of hypervisors (special software applications that enable isolation of virtual machines on top of a physical machine) for hosting web apps, mounting storage volumes from a storage pool, and creating a network overlay. In PaaS, this involves allocating a desired amount of computing or processing capacity, leaving it up to the cloud platform to determine how to realize this in terms of underlying hardware allocations. Finally, in SaaS, this can involve ensuring that the underlying service has enough capacity to meet the throughput guaranteed in the service's SLA.

Here, we will focus on understanding some of the high-level steps that a CSP must take to create and allocate a set of resources for an end user.

# Components of a Resource-Provisioning System

A resource-provisioning system for the cloud generally has the following sub-parts:

1. Access to a physical pool of resources -- generally thousands or millions of servers, interconnected by a network as well as a pool of storage devices.
1. An identity-management subsystem that maintains and validates end users' credentials for accessing many different types of resources; it can also support role-based access control.
1. A metering and monitoring system to detect utilization of physical resources and consumption of services.
1. A billing and charge-management system to map the metered resources to physical costs and take appropriate actions based on the user's allowed privileges.
1. A resource manager that works with a hypervisor to map physical resources to virtual abstractions.
1. The provisioning system will provide management and monitoring APIs as well as a web front-end.

# Cloud End-to-End Service Provisioning Flow

As an example, Figure 2.4 shows the typical steps for a customer provisioning a virtual machine from a Cloud Service Provider:

![Figure 2.4: Typical end-to-end IaaS provisioning steps.](../media/iaas-provisioning.png)

_Figure 2.4: Typical end-to-end IaaS provisioning steps._

The steps illustrated in Figure 2.4 are explained as follows:

1. The customer logs on to the portal and is authenticated by the identity management system.
1. Based on the customer's entitlement, the portal extracts a subset of services that the user can order from the service catalogue and constructs a 'request catalog'.
1. The customer selects a service, e.g. a virtual server of a particular size. Each service has a set of technical requirements (for example, the amount of vRAM and vCPU) and business requirements (for example, high-availability or SLA requirements) associated with it.
1. The orchestration tool extracts the technical service information from the service catalog and decomposes the service into individual parts, such as compute resource configuration, network configuration, and so on.
1. The provisioning process is initiated.
1. The virtual machine running on the server is provisioned using the server/compute domain manager.
1. The network, including firewalls and load balancers, as well the storage is provisioned by the network, network services and storage domain managers.
1. Charging is initiated for billing/chargeback and the change management case is closed and the customer is notified accordingly.
