The most basic role of a cloud service provider (CSP) is to package and isolate virtual parts of a physical datacenter and provide access for cloud users to provision resources on the cloud. Provisioning is the process of mapping abstract resource requests by cloud users to physical resources on servers within a datacenter. 

In infrastructure as a service (IaaS), this mainly involves launching virtual machines on top of hypervisors, as well as mounting storage volumes from a storage pool and creating a private network overlay for the user's resources. (Hypervisors are special software applications that enable isolation of virtual machines on top of a physical machine. We will read more about them soon.)

The techniques behind virtualizing compute, storage, or networking resources are dealt with in future modules. Here, we focus on understanding some of the high-level steps that a CSP must take to create and allocate a publicly accessible virtual machine with a fixed set of resources to an end user. 

## Components of a resource provisioning system

A resource provisioning system on the cloud generally has the following parts: 

- Access to a physical pool of resources—generally thousands or millions of servers interconnected by a network (generally using a fat-tree topology as discussed in a previous module), and also a large pool of disks.
- An identity management subsystem that maintains and validates the end user's credentials for accessing many different types of resources; it can also support role-based access control. 
- A metering and monitoring system to detect utilization of physical resources. 
- A billing and charge management system to map the metered resources to physical costs and take appropriate actions based on the user's allowed privileges. 
- A resource manager that works with a hypervisor to map physical resources to virtual abstractions. 
- Often, a web front end or an API. 


## Cloud end-to-end service provisioning flow

Figure 2 shows the typical end-to-end steps for a customer provisioning a virtual machine from a CSP:

![Typical end-to-end IaaS provisioning steps](../media/provision-resources.png)

_Figure 2: Typical end-to-end IaaS provisioning steps_

The steps illustrated in Figure 2 are explained as follows: 
1. The customer logs on to the portal and is authenticated by the identity management system. 
1. Based on the customer's entitlement, the portal extracts a subset of services that the user can order from the service catalog and constructs a "request catalog." 
1. The customer selects a service, for example, a virtual server of a particular size. Each service has a set of technical requirements (for example, the amount of vRAM or vCPU) and business requirements (for example, high availability or SLA requirements) associated with it. 
1. The orchestration tool extracts the technical service information from the service catalog and decomposes the service into individual parts, such as compute resource configuration, network configuration, and so on. 
1. The provisioning process is initiated. 
1. The virtual machine running on the server is provisioned using the server/compute domain manager. 
1. The network, including firewalls and load balancers, as well the storage, is provisioned by the network, network services, and storage domain managers. 
1. Charging is initiated for billing/chargeback. The change management case is closed, and the customer is notified accordingly. 

