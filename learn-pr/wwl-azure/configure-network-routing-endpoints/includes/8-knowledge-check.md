Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which of the following statements about routing in Azure is true?
( ) The administrator can override existing system routes. {{That's incorrect. The administrator cannot create system routes, nor override existing system routes.}}
( ) Azure gateways are needed to route traffic between subnets. {{That's incorrect. Gateways are not needed to route traffic between subnets.}}
(x) When the next hop type is none, traffic is dropped. {{That's correct. Traffic routed to the None next hop type is not routed outside the subnet, but is dropped.}}

## Multiple Choice
When creating user-defined routes, which of the following is a valid next hop types?
(x) Internet {{That's correct. The valid next hop choices are virtual appliance. virtual network gateway, virtual network, internet, and none.}}
( ) Load balancer {{That's incorrect. Load balancer is not a valid next hop type.}}
( ) ExpressRoute {{That's incorrect. ExpressRoute is not a valid next hop type.}}

## Multiple Choice
Your company needs to extend their private address space in Azure by by providing a direct connection to your Azure resources. Which of the following should be implemented?
( ) User-defined route {{That's incorrect. User-defined routes are created so Azure Virtual Appliances can handle the traffic both between subnets and to the Internet.}}
( ) Virtual appliance {{That's incorrect. Virtual appliances are for traffic control and high availability. }}
(x) Virtual network endpoint {{That's correct. Virtual network endpoints extend your private address space in Azure. Endpoints restrict the flow of traffic. As service endpoints are created, Azure creates routes in the route table to direct the traffic.}}

## Multiple Choice
Your company provides customers a virtual network in the cloud. There are dozens of Linux virtual machines in another virtual network. A load balancer must be installed between the virtual networks. Which of the following meets the requirement?
( ) Install an external load balancer. {{That's incorrect. Azure has two types of load balancers: public and internal.}}
(x) Install an internal load balancer. {{That's correct. Azure has two types of load balancers: public and internal. An internal load balancer directs traffic only to resources that are inside a virtual network or that use a VPN to access Azure infrastructure.}}
( ) Install a public load balancer. {{That's incorrect. A public load balancer maps the public IP address and port number of incoming traffic to the private IP address and port number of the VM.}}

