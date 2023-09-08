Virtual machines must be sized appropriately for the expected work. A VM without the correct amount of memory or CPU will fail under load or run too slowly to be effective.

## Pre-defined VM sizes

When you create a virtual machine, you can supply a _VM size_ value that determines the amount of compute resources devoted to the VM. This includes CPU, GPU, and memory made available to the virtual machine from Azure.

Azure defines a set of predefined VM sizes for Linux and Windows from which to choose based on the expected usage.

| Type | Sizes | Description |
|------|-------|-------------|
| General purpose   | Dsv3, Dv3, DSv2, Dv2, DS, D, Av2, A0-7 | Balanced CPU-to-memory. Ideal for dev/test and small to medium applications and data solutions. |
| Compute optimized | Fs, F | High CPU-to-memory. Good for medium-traffic applications, network appliances, and batch processes. |
| Memory optimized  | Esv3, Ev3, M, GS, G, DSv2, DS, Dv2, D   | High memory-to-core. Great for relational databases, medium to large caches, and in-memory analytics. |
| Storage optimized | Ls | High disk throughput and IO. Ideal for big data, SQL, and NoSQL databases. |
| GPU optimized | NV, NC | Specialized VMs targeted for heavy graphic rendering and video editing. |
| High performance | H, A8-11 | Our most powerful CPU VMs with optional high-throughput network interfaces (RDMA). |

The available sizes change based on the region in which you're creating the VM. You can get a list of the available sizes using the `vm list-sizes` command. Try typing the following into Azure Cloud Shell:

```azurecli
az vm list-sizes --location eastus --output table
```

Here's an abbreviated response for `eastus`:

```output
  MaxDataDiskCount    MemoryInMb  Name                      NumberOfCores    OsDiskSizeInMb    ResourceDiskSizeInMb
------------------  ------------  ----------------------  ---------------  ----------------  ----------------------
                 2          2048  Standard_B1ms                         1           1047552                    4096
                 2          1024  Standard_B1s                          1           1047552                    2048
                 4          8192  Standard_B2ms                         2           1047552                   16384
                 4          4096  Standard_B2s                          2           1047552                    8192
                 8         16384  Standard_B4ms                         4           1047552                   32768
                16         32768  Standard_B8ms                         8           1047552                   65536
                 4          3584  Standard_DS1_v2                       1           1047552                    7168
                 8          7168  Standard_DS2_v2                       2           1047552                   14336
                16         14336  Standard_DS3_v2                       4           1047552                   28672
                32         28672  Standard_DS4_v2                       8           1047552                   57344
                64         57344  Standard_DS5_v2                      16           1047552                  114688
        ....
                64       3891200  Standard_M128-32ms                  128           1047552                 4096000
                64       3891200  Standard_M128-64ms                  128           1047552                 4096000
                64       3891200  Standard_M128ms                     128           1047552                 4096000
                64       2048000  Standard_M128s                      128           1047552                 4096000
                64       1024000  Standard_M64                         64           1047552                 8192000
                64       1792000  Standard_M64m                        64           1047552                 8192000
                64       2048000  Standard_M128                       128           1047552                16384000
                64       3891200  Standard_M128m                      128           1047552                16384000
```

## Specify a size during VM creation

We didn't specify a size when we created our VM, so Azure selected a default general-purpose size for us. However, we can specify the size as part of the `vm create` command using the `--size` parameter. For example, you could use the following command to create a two-core virtual machine:

```azurecli
az vm create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name SampleVM2 \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys \
    --verbose \
    --size "Standard_DS2_v2"
```

> [!WARNING]
> Your subscription tier [enforces limits](/azure/azure-subscription-service-limits) on how many resources you can create, as well as the total size of those resources. Quota limits depend upon your subscription type and region. The Azure CLI will let you know when you exceed this limit with a **Quota Exceeded** error. If you hit this error in your own paid subscription, you can request to raise the limits associated with your paid subscription (up to 10,000 vCPUs) through a [free online request](/azure/azure-resource-manager/resource-manager-quota-errors).

## Resize an existing VM

We can also resize an existing VM if the workload changes or if it was incorrectly sized at creation. Let's use the first VM we created, SampleVM. Before requesting a resize, we must check to see if the desired size is available in the cluster our VM is part of. We can do this with the `vm list-vm-resize-options` command:

```azurecli
az vm list-vm-resize-options \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name SampleVM \
    --output table
```

This will return a list of all the possible size configurations available in the resource group. If the size we want isn't available in our cluster but _is_ available in the region, we can [deallocate the VM](/cli/azure/vm#az-vm-deallocate). This command will stop the running VM and remove it from the current cluster without losing any resources. We can then resize it, which will re-create the VM in a new cluster where the size configuration is available.

> [!NOTE]
> The Microsoft Learn sandbox is limited to a few VM sizes.

To resize a VM, we'll use the `vm resize` command. For example, perhaps we find our VM is underpowered for the task we want it to perform. We could bump it up to a D2s_v3, where it has 2 vCores and 8 GB of memory. Type this command in Cloud Shell:

```azurecli
az vm resize \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name SampleVM \
    --size Standard_D2s_v3
```

This command will take a few minutes to reduce the resources of the VM, and once it's done, it will return a new JSON configuration.
