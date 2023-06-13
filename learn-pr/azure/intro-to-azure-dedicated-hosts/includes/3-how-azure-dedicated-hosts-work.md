Dedicated hosts utilize familiar Azure VM sizes (SKUs), but they necessitate extra prerequisites before a VM can be provisioned. These layers enable you to define the size family a host can accommodate and group multiple hosts even if they belong to different size families. Understanding the function of these configuration layers is crucial for optimizing and effectively managing your dedicated host deployments. Let's look into the architecture and components of the feature set.

Vamsi notes:
Dedicated hosts come in different sizes. They're called SKUs. VM sizes are different. A dedicated host SKU is a combination of an Azure VM Family and Hardware Generation. Remove several extra configuration layers. This is what it looks like, and once you create a host you can deploy of the same... To create a host itself, you create a group. They're logical resources. Dedicated host specific prereqs. Mention host groups in intro paragraph

## Prerequisites:

### Host groups

Host Groups are the first unique layer in a dedicated host deployment. They're a convenient way to visualize, organize, and manage a dynamic environment that can mix different hosts.

Host groups are created within Resource groups. They have a specified location, availability zone (physical datacenter), and fault domain count. Host groups don't limit what VM sizes are available to you beyond your Subscription and Location availability.

### Hosts

Hosts represent the physical servers you're reserving when using dedicated hosts. When you select 'Add host' and follow the prompts to "create (a) dedicated host", you're effectively reserving an entire physical server sitting in the previously selected location's Azure datacenter.

### Size family

Size families are a list of related VM sizes that would normally run on a shared machine. You're only able to provision VMs on the host that are in the same VM family. If you want different hardware that's beyond what your selected size family can support, you'll have to add another host to your host group.

### Instances

Because you're already reserving the entire host, VMs are represented by 'instances'. A VM created as an instance has the same creation options as a normal VM, however you have to make sure the size corresponds with the size family you selected for that host.

Under a host's overview page, there's a section labeled 'Available VM capacity'. The smaller the VM size, the greater number of that size a host can support simultaneously. While you can mix different VM sizes on a single host, you can't exceed the capacity of a single host when combining the required resources for all provisioned VMs. Some hosts also have a single size that represents the entire host's available resources.

This table shows the capacity an empty host (no currently running VM instances) with the 'DDSv4-Type1' size family can support.

VM Size | Number remaining
|---|---|
Example_D2ds | 32
Example_D4ds | 17
Example_D8ds | 8
Example_D16ds | 4
Example_D32ds | 2
Example_D48ds | 1
Example_D64ds | 1

An example of a mixed size deployment using the size family from the previous table might look like this:

You don't need to run uniform sizes, you can mix and match VM sizes on the same host. Once you create said VMs, the dedicated hosts 'VM Capacity' page dynamically updates to show you the remaining capacity. Due to virtualization overhead, the quantity of VMs and their associated resources may not add together in a linear fashion.

