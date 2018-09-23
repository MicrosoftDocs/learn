Your server needs enough resources to handle daily demand. A typical strategy is to choose a VM size at creation that is sufficient for typical workloads and then resize it when demand changes.

In the toy company scenario, this strategy would be useful to manage resources for your medium-term growth. You can increase the size of your VM to handle the added demand as your business grows.

## What is virtual machine size?

The _size_ of a virtual machine is a measure of its CPU, memory, disk, and expected network bandwidth. Virtual machines are available in a predetermined number of sizes. For example, the **Standard_F32s_v2** size has 32 virtual CPUs, 64 GiB of memory, a 256 GiB local SSD, and 14,000 Mbps of expected network bandwidth.

When you create a new virtual machine in Azure, you must choose a size. Larger sizes cost more. The goal is to choose a size that can handle your workload without configuring more power than you need.

## What is virtual machine type?

The _type_ of a virtual machine is the workload for which the VM has been optimized. For example, some VMs are targeted at CPU-intensive tasks like hosting a web server. Others are intended for storage-focused jobs like running a database.

There are _types_ that correspond to each core hardware component in a modern computer: **compute**, **memory**, **storage**, and **GPU**. There's also a **general purpose** type if you need a balanced combination of resources. The following table lists the types and the VM sizes that are part of each type, along with a brief description of the target workload.

|Type|Sizes|Description|
|---|---|---|
|General purpose|B, Ds_v3, D_v3, some DS_v2, some D_v2, A_v2|General-purpose machines have a balanced CPU-to-memory ratio. General-purpose machines are good for testing or development servers, small to medium databases, or web servers with low to medium traffic.|
|Compute optimized|Fs_v2, Fs, F|Compute-optimized virtual machines have a higher CPU-to-memory ratio than general-purpose machines, for tasks that require extra processing power, such as application servers, network appliances, or medium-traffic web servers.|
|Memory optimized|Es_v3, E_v3, M, GS, G, some DS_v2, some D_v2|Memory-optimized virtual machines have a high memory-to-CPU ratio. These machines are good for relational database servers, servers that require or perform a lot of caching, or servers that perform in-memory analytics.|
|Storage optimized|Ls|These virtual machines are configured for high disk throughput and IO operations to suit big data, SQL, and NoSQL databases.|
|GPU|NV, NC, NC_v2, NC_v3, ND|GPU virtual machines are specialized for tasks such as heavy-duty graphic rendering or video editing, along with model training and inferencing (ND series) with deep learning. You can choose single or multiple GPUs for these machines.|
|High performance compute|H|The fastest, most powerful CPUs are available in these virtual machines. You can also add high-throughput network interfaces (RDMA).|

## Clusters

The physical server hardware in Azure regions is grouped together into clusters. Each cluster can support several different virtual machine sizes based on the physical hardware.

When you create a virtual machine and choose a specific size, the virtual machine is provisioned to an appropriate hardware cluster for that size. Although you can resize virtual machines after creation, the resizing options may be limited by the hardware cluster chosen for the initial size.

## What is vertical scaling?

_Vertical scaling_ is the process of changing the _size_ of a virtual machine. You can _scale up_ by choosing a more powerful size to handle increased demand or _scale down_ to allocate fewer resources and reduce costs. The following illustration shows an example of changing the size of a virtual machine.

![An illustration showing scaling up and scaling down of a virtual machine to change the performance capabilities.](../media/2-ScaleUpDown.png)

You can resize a VM using the Azure portal, Azure PowerShell, or the Azure CLI.

### Resize in the portal

In the Azure portal, you can resize a virtual machine by selecting the virtual machine, clicking the **Size** entry, and selecting an entry from the **Choose a size** blade. 

If the virtual machine is running at the time, the available sizes you can select from will depend on the available sizes in your region. You will only see resize options compatible with the same hardware cluster that the virtual machine is currently running on; this is sometimes called a *size family*. If you choose a new size while the virtual machine is running, the VM will be restarted automatically to apply the new size.

If the size you are looking for is not visible in the portal when the virtual machine is running, then you can shut down the virtual machine to see more options. When the machine is in the **stopped (deallocated)** state, you will be able to select sizes from other hardware in the same region.

### Resize with PowerShell

You can use PowerShell to perform vertical scaling interactively or with scripts. Scripts are good for complex scenarios; for example, if you need to resize several VMs at once. They are also convenient if you need to perform the resize during non-working hours to avoid user disruption.

The following cmdlet lists VM sizes of the same size-family as the current hardware:

```PowerShell
Get-AzureRmVMSize -ResourceGroupName "myResourceGroup" -VMName "MyVM"
```

If the desired size is displayed, use the following cmdlet to change the virtual machine size:

```PowerShell
$vm = Get-AzureRmVM -ResourceGroupName "myResourceGroup" -VMName "MyVM"
$vm.HardwareProfile.VmSize = "<newVMsize>"
Update-AzureRmVM -VM $vm -ResourceGroupName "myResourceGroup"
```

If the desired size is not displayed with the machine running, use the following commands to deallocate the virtual machine, resize the machine, and start the machine again:

```PowerShell
Stop-AzureRmVM -ResourceGroupName "myResourceGroup" -Name "MyVM" -Force
$vm = Get-AzureRmVM -ResourceGroupName "myResourceGroup" -VMName "MyVM"
$vm.HardwareProfile.VmSize = "<newVMSize>"
Update-AzureRmVM -VM $vm -ResourceGroupName "myResourceGroup"
Start-AzureRmVM -ResourceGroupName "myResourceGroup" -Name "MyVM"
```

Virtual machines in Azure can be resized as needed to increase performance or decrease costs. Performing the resize manually, with either the portal or a script, is useful to handle gradual business growth or when you know about a change in demand ahead of time. In the toy-company scenario, they could scale up before a holiday to handle the spike in demand and then scale down afterward.
