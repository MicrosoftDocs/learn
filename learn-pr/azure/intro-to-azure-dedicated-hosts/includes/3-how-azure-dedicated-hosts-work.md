Dedicated hosts utilize familiar Azure VM sizes (SKUs), but they necessitate the addition of several extra configuration layers before a VM can be provisioned. These layers enable you to define the size family a host can accommodate and group multiple hosts even if they belong to different size families. Understanding the function of these configuration layers is crucial for optimizing and effectively managing your dedicated host deployments. Let's look into the architecture and components of the feature set.

## Configuration layers:

### Host groups

Host Groups are the first unique layer in a dedicated host deployment. They're a convinient way to visualize, organize, and manage a dynamic environment which can mix different hosts.

Host groups are created within Resource groups. They have a specified location (physical datacenter), availability zone, and other features similar to the creation of a standard VM. Host groups don't limit what VM sizes are available to you beyond your Subscription and Location availability.

### Hosts

Hosts represent the physical servers you're reserving when using dedicated hosts. When you select 'Add host' and follow the prompts to "create (a) dedicated host" you're effectively reserving an entire physical server sitting in the previously selected location's Azure datacenter.

### Size family

Size families are another dedicated hosts related layer which are configured within a host group. Families are a list of related VM sizes which would normally run on a shared machine. Any VM which falls under a given family can be considered one of the host's available sizes as long as there are sufficient resources available to run said size.

> [!NOTE]
> You'll only be able to provision VMs on the host which are in the same VM family. If you want different hardware that's beyond what your selected size family can support, you'll have to add another host to your host group.

### Instances

Because you're already reserving the entire host, VMs are represented by 'instances'. A VM created as an instance has the same creation options as a normal VM, however you'll have to make sure the size corresponds with the size family you selected for that host.

Under a host's overview page, there's a section labeled 'Available VM capacity'. The smaller the VM size, the greater number of that size a host can support simultaneously. While you can mix different sizes on a single host, you can't exceed the capacity of a single host when combining the required resources for all provisioned VMs. Some hosts also have a single size which represents the entire host's available resources.

This table shows the capacity an empty host (no currently running VM instances) with the 'DDSv4-Type1' size family can support.

VM Size | Number remaining
|---|---|
Standard_D2ds_v4 | 32
Standard_D4ds_v4 |17
Standard_D8ds_v4 | 8
Standard_D16ds_v4 | 4
Standard_D32ds_v4 | 2
Standard_D48ds_v4 | 1
Standard_D64ds_v4 | 1

An example of a mixed size deployment using the size family from the previous table might look like this:

Total host core count: 64 cores

VM Qty. | VM Size | Cores per VM | Sum of cores
|---|---|---|---|
8 VMs | Standard_D2ds_v4 | 2 cores | 16 cores
3 VMs |  Standard_D4ds_v4 | 4 cores | 12 cores
2 VMs |  Standard_D16ds_v4 | 16 cores | 32 cores

Remaining cores for future VMs on the same host: 4 cores

## How dedicated hosts differs from reserved instances

While dedicated hosts can be defined as "reserving physical host servers", the feature differs significantly from 'reserved instances'.

Reserved instances are a way to save money with standard multi-tenant Azure VMs. The reservation discount is useful in situations where you need a certain amount of compute resources in a given region but aren't actively utilizing said resources at all times. Reserved instances have no guarantee as to where those VMs might be placed and what other VMs might be running alongside them on a given host. You are only guaranteed that those resources are available to you in the same region when needed. 

Dedicated hosts has a similar version of this reservation integrated as a consequence of its design. Since no other users can access your host, you have effectively reserved any VM resources that a host can provide beyond what is currently active on it.