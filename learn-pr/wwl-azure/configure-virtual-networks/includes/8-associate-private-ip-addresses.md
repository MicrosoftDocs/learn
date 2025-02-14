A private IP address resource can be associated with virtual machine network interfaces, internal load balancers, and application gateways. Azure can provide an IP address (dynamic assignment) or you can assign the IP address (static assignment).

### Things to consider when associating private IP addresses

The following table summarizes how you can associate private IP addresses for different types of resources.

| Resource | Private IP address association | Dynamic IP address | Static IP address |
| --- | --- | --- | --- |
| Virtual machine | NIC | Yes | Yes |
| Internal load balancer | Front-end configuration | Yes | Yes |
| Application gateway | Front-end configuration | Yes | Yes |

#### Private IP address assignment

A private IP address is allocated from the address range of the virtual network subnet that a resource is deployed in. There are two options: dynamic and static.

- **Dynamic**: Azure assigns the next available unassigned or unreserved IP address in the subnet's address range. Dynamic assignment is the default allocation method.

   Suppose addresses 10.0.0.4 through 10.0.0.9 are already assigned to other resources. In this case, Azure assigns the address 10.0.0.10 to a new resource.

- **Static**: You select and assign any unassigned or unreserved IP address in the subnet's address range.

   Suppose a subnet's address range is 10.0.0.0/16, and addresses 10.0.0.4 through 10.0.0.9 are already assigned to other resources. In this scenario, you can assign any address between 10.0.0.10 and 10.0.255.254.