A private IP address resource can be associated with virtual machine network interfaces, internal load balancers, and application gateways. Azure can provide an IP address (dynamic assignment) or you can assign the IP address (static assignment).

:::row:::
  :::column:::
    **Private IP Addresses**
  :::column-end:::
  :::column:::
    **IP address association**
  :::column-end:::
  :::column:::
    **Dynamic**
  :::column-end:::
  :::column:::
    **Static**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtual Machine
  :::column-end:::
  :::column:::
    NIC
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Internal Load Balancer
  :::column-end:::
  :::column:::
    Front-end configuration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Application Gateway
  :::column-end:::
  :::column:::
    Front-end configuration
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::


A private IP address is allocated from the address range of the virtual network subnet a resource is deployed in.

 -  **Dynamic**. Azure assigns the next available unassigned or unreserved IP address in the subnet's address range. For example, Azure assigns 10.0.0.10 to a new resource, if addresses 10.0.0.4-10.0.0.9 are already assigned to other resources. Dynamic is the default allocation method.
 -  **Static**. You select and assign any unassigned or unreserved IP address in the subnet's address range. For example, if a subnet's address range is 10.0.0.0/16 and addresses 10.0.0.4-10.0.0.9 are already assigned to other resources, you can assign any address between 10.0.0.10 - 10.0.255.254.
