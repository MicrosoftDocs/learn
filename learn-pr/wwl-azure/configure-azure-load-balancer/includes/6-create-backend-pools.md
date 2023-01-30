Each load balancer has one or more back-end pools that are used for distributing traffic. The back-end pools contain the IP addresses of the virtual NICs that are connected to your load balancer. 

:::image type="content" source="../media/backend-pools-1984adb4.png" alt-text="Screenshot that shows how to configure back-end pools in the Azure portal.":::

### Things to know about back-end pools

When you configure back-end pools for your load balancer in the Azure portal, you can connect to an availability set, single virtual machine, or virtual machine scale set.

The SKU type that you select determines which endpoint configurations are supported for the back-end pool along with the number of pool instances allowed. The following table summaries the supported options for the Standard and Basic SKUs.

| SKU | Allowed endpoints | Allowed pools |
| --- | --- | --- |
| **Basic** | Virtual machines in a single availability set or a virtual machine scale set | Up to 300 instances |
| **Standard** | Virtual machine in a single virtual network, which can include a blend of virtual machines, availability sets, and virtual machine scale sets | Up to 1,000 instances |