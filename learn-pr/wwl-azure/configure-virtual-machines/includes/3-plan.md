Provisioning VMs to Azure requires planning.

 -  Start with the network
 -  Name the VM
 -  Decide the location for the VM
 -  Determine the size of the VM
 -  Understanding the pricing model
 -  Storage for the VM
 -  Select an operating system

## Start with the network

Virtual networks (VNets) are used in Azure to provide private connectivity between Azure Virtual Machines and other Azure services. VMs and services that are part of the same virtual network can access one another. By default, services outside the virtual network can't connect to services within the virtual network. You can, however, configure the network to allow access to the external service, including your on-premises servers.

Network addresses and subnets aren't trivial to change once you have them set up. If you plan to connect your private company network to the Azure services, you'll want to make sure you consider the topology before putting any VMs into place.

## Name the VM

The VM name is used as the computer name, which is configured as part of the operating system. You can specify a name of up to 15 characters on a Windows VM and 64 characters on a Linux VM.

The virtual machine name also defines a manageable Azure resource, and it's not trivial to change later. That means you should choose names that are meaningful and consistent, so you can easily identify what the VM does. A good convention is to include the following information in the name:

:::row:::
  :::column:::
    **Element**
  :::column-end:::
  :::column:::
    **Example**
  :::column-end:::
  :::column:::
    **Notes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Environment
  :::column-end:::
  :::column:::
    dev, prod, QA
  :::column-end:::
  :::column:::
    Identifies the environment for the resource
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Location
  :::column-end:::
  :::column:::
    uw (US West), ue (US East)
  :::column-end:::
  :::column:::
    Identifies the region into which the resource is deployed
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Instance
  :::column-end:::
  :::column:::
    01, 02
  :::column-end:::
  :::column:::
    For resources that have more than one named instance (web servers, etc.)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Product or Service
  :::column-end:::
  :::column:::
    service
  :::column-end:::
  :::column:::
    Identifies the product, application, or service that the resource supports
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Role
  :::column-end:::
  :::column:::
    sql, web, messaging
  :::column-end:::
  :::column:::
    Identifies the role of the associated resource
  :::column-end:::
:::row-end:::


For example, `devusc-webvm01` might represent the first development web server hosted in the US South Central location.

## Decide the location for the VM

Azure has datacenters all over the world filled with servers and disks. These datacenters are grouped into geographic regions ('West US', 'North Europe', 'Southeast Asia', etc.) to provide redundancy and availability.

You must select a region where you want the resources (CPU, storage, etc.) to be allocated. The region lets you locate your VMs as close as possible to your users to improve performance and to meet any legal, compliance, or tax requirements.

## Considerations for the location

 -  **The location can limit your available options**. Each region has different hardware available and some configurations aren't available in all regions.
 -  **There are price differences between locations**. If your workload isn't bound to a specific location, it can be very cost effective to check your required configuration in multiple regions to find the lowest price.

## Know the pricing options

There are two separate costs the subscription will be charged for every VM: compute and storage. By separating these costs, you scale them independently and only pay for what you need.

**Compute costs** \- Compute expenses are priced on a per-hour basis but billed on a per-minute basis. For example, you're only charged for 55 minutes of usage if the VM is deployed for 55 minutes. you aren't charged for compute capacity if you stop and deallocate the VM. The hourly price varies based on the VM size and OS you select. 

**Storage costs** \- you're charged separately for the storage the VM uses. The status of the VM has no relation to the storage charges. Even when a VM is stopped/deallocated, you're charged for the storage used by the disks.

You're able to choose from two payment options for compute costs:

 -  **Consumption-based** \- With the consumption-based option, you pay for compute capacity by the second. You're able to increase or decrease compute capacity on demand and start or stop at any time. Use consumption-based if you run applications with short-term or unpredictable workloads that can't be interrupted. For example, if you're doing a quick test, or developing an app in a VM.
 -  **Reserved Virtual Machine Instances** \- The Reserved Virtual Machine Instances (RI) option is an advance purchase of a virtual machine for one or three years in a specified region. The commitment is made up front, and in return, you get up to 72% price savings compared to pay-as-you-go pricing. RIs are flexible and can easily be exchanged or returned for an early termination fee. Use this option if the VM has to run continuously, or you need budget predictability, and you can commit to using the VM for at least a year.
