
Each load balancer has one or more back-end pools that are used for distributing traffic. The back-end pools contain the IP addresses of the virtual NICs that are connected to your load balancer. You configure these pool settings in the Azure portal.

:::image type="content" source="../media/backend-pools-1984adb4.png" alt-text="Screenshot that shows how to configure back-end pools in the Azure portal.":::

### Things to know about back-end pools

The SKU type that you select determines which endpoint configurations are supported for the pool along with the number of pool instances allowed.

- The Basic SKU allows up to 300 pools, and the Standard SKU allows up to 1,000 pools.

- When you configure the back-end pools, you can connect to availability sets, virtual machines, or Azure Virtual Machine Scale Sets.

- For the Basic SKU, you can select virtual machines in a single availability set or virtual machines in an instance of Azure Virtual Machine Scale Sets.

- For the Standard SKU, you can select virtual machines or Virtual Machine Scale Sets in a single virtual network. Your configuration can include a combination of virtual machines, availability sets, and Virtual Machine Scale Sets.