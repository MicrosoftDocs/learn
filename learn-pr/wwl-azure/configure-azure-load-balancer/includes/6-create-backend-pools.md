To distribute traffic, a back-end address pool contains the IP addresses of the virtual NICs that are connected to the load balancer. How you configure the backend pool depends on whether you are using the Standard or Basic SKU.

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **Standard SKU**
  :::column-end:::
  :::column:::
    **Basic SKU**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Backend pool endpoints
  :::column-end:::
  :::column:::
    Any virtual machine in a single virtual network. This includes a blend of virtual machines, availability sets, and virtual machine scale sets.
  :::column-end:::
  :::column:::
    Virtual machines in a single availability set or virtual machine scale set.
  :::column-end:::
:::row-end:::


Backend pools are configured from the Backend Pool blade. For the Standard SKU you can connect to an Availability set, single virtual machine, or a virtual machine scale set.

:::image type="content" source="../media/backend-pools-1984adb4.png" alt-text="Screenshot of the Settings for Backend pools shows the list of options available for configuring the backend pool.":::


> [!NOTE]
> In the Standard SKU, you can have up to 1000 instances in the backend pool. In the Basic SKU, you can have up to 300 instances.
