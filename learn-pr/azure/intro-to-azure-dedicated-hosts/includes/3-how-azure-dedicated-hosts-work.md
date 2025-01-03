While Azure dedicated hosts have the same VM management system as a set of standard Azure VMs, they require extra prerequisites before a VM can be provisioned on a host. These prerequisites enable you to define a host's SKU and group multiple hosts together. Understanding the function of these prerequisites is crucial for optimizing and effectively managing your dedicated host deployments. Let's look into each of these prerequisites and see how they relate to a dedicated hosts deployment.

## Prerequisites

### Host groups

Host Groups are the first unique prerequisite in a dedicated host deployment. They're a convenient way to visualize, organize, and manage a dynamic environment that can mix different hosts.

Host groups are created within Resource groups. They have a specified location, availability zone, and fault domain count. Host groups don't limit what VM sizes are available to you beyond your Subscription and Location availability.

### Host (SKU)

A host represents the physical server you're reserving when using dedicated hosts. When you select 'Add host' and follow the prompts to "create (a) dedicated host", you're effectively reserving an entire physical server SKU sitting in the previously selected location's Azure datacenter.

### Size family

Size families are a list of a SKU's available VM sizes. You're only able to provision VMs on a single host that are in the same VM family. If you want different hardware or sizes that are beyond what your selected size family can support, you'd add another host to your host group.

### Instances

Because you're already reserving the entire host, VMs are represented by 'instances'. A VM created as an instance has the same creation options as a normal VM, however you have to make sure the size corresponds with the size family you selected for that host.

Under a host's overview page, there's a section labeled 'Available VM capacity'. The smaller the VM size, the greater number of that size a host can support simultaneously. While you can mix different VM sizes on a single host, you can't exceed the capacity of a single host when combining the required resources for all provisioned VMs. Some hosts also have a single size that represents the entire host's available resources.

This table shows the 'VM Capacity' page for an empty host (no currently running VM instances) with the 'Example-Type' size family.

VM Size | Number remaining
|---|---|
Example_D2ds | 32
Example_D4ds | 17
Example_D8ds | 8
Example_D16ds | 4
Example_D32ds | 2
Example_D48ds | 1
Example_D64ds | 1

You don't need to run uniform sizes, you can mix and match VM sizes on the same host. Once you create a VM with a selected size, the 'VM Capacity' page dynamically updates to show you the remaining capacity. Due to virtualization overhead, the quantity of VMs and their associated resources may not add together linearly.

