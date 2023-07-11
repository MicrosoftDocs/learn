Service endpoints would provide benefits in the following Scenarios.

### Scenarios

 -  **Peered, connected, or multiple virtual networks**: To secure Azure services to multiple subnets within a virtual network or across multiple virtual networks, you can enable service endpoints on each of the subnets independently, and secure Azure service resources to all of the subnets.
 -  **Filtering outbound traffic from a virtual network to Azure services**: If you want to inspect or filter the traffic sent to an Azure service from a virtual network, you can deploy a network virtual appliance within the virtual network. You can then apply service endpoints to the subnet where the network virtual appliance is deployed, and secure Azure service resources only to this subnet. This scenario might be helpful if you want use network virtual appliance filtering to restrict Azure service access from your virtual network only to specific Azure resources.
 -  **Securing Azure resources to services deployed directly into virtual networks**: You can directly deploy various Azure services into specific subnets in a virtual network. You can secure Azure service resources to managed service subnets by setting up a service endpoint on the managed service subnet.
 -  **Disk traffic from an Azure virtual machine**: Virtual Machine Disk traffic for managed and unmanaged disks isn't affected by service endpoints routing changes for Azure Storage. This traffic includes diskIO as well as mount and unmount. You can limit REST access to page blobs to select networks through service endpoints and Azure Storage network rules.

:::image type="content" source="../media/az500-endpoint-services-71cec37f.png" alt-text="Add service endpoints form":::
