In your manufacturing company, you have asked operations and engineering teams about their requirements for the number of virtual machines in Azure. You've also asked them about their plans for expansion. Based on the results of this survey, you want to plan an IP addressing scheme that you won't have to change in the foreseeable future.

In this unit, you'll explore the requirements for a network IP address scheme. You'll learn about classless inter-domain routing (CIDR), and how you use it to slice an IP block to meet your addressing needs. At the end of the module, there's an exercise showing how to plan IP addressing for Azure virtual networks.

## Gather your requirements

Before planning your network IP address scheme, you must gather the requirements for your infrastructure. These requirements will also help you prepare for future growth by reserving extra IP addresses and subnets.

Here are two of the questions you might ask to discover the requirements:

- How many devices do you have on the network?
- How many devices are you planning to add to the network in future?

When your network expands, you don't want to redesign the IP address scheme. Here are some other questions you could ask:

- Based on the services running on the infrastructure, what devices do you need to separate?
- How many subnets do you need?
- How many devices per subnet will you have?
- How many devices are you planning to add to the subnets in future?
- Are all subnets going to be the same size?
- How many subnets do you want, or plan to add in future?

You'll need to isolate some services. Isolation of services provides an additional layer of security, but also requires good planning. For example, your frontend servers can be accessed by public devices, but the backend servers will need to be isolated. Subnets help to isolate the network in Azure. However, by default, all subnets within a virtual network can communicate with each other in Azure. To provide further isolation you can use a network security group. You could isolate services depending on the data and its security requirements. For example, you may choose to isolate HR data and the company's financial data from customer databases.

When you know the requirements, you'll have a greater understanding of the total number of devices on the network per subnet and how many subnets you'll need.  CIDR allows more flexible allocation of IP addresses than was possible with the original system of IP address classes. Depending on your requirements, you'll slice the IP block into the required subnets and hosts.

Remember that Azure uses the first three addresses on each subnet. The first and last IP addresses of the subnets are also reserved for protocol conformance. Therefore, the number of possible addresses on an Azure subnet is **2^(n-5)**, where **n** represents the number of host bits.

## Exercise – Design IP addressing for Azure virtual networks

In this paper-based exercise, you'll design an IP address scheme for three virtual networks.

You want to connect your on-premises network with Azure by using the Azure VPN gateway. The on-premises network will connect to the **vnet1** virtual network in Azure. The on-premises network is using the 10.10.0.0/16 address space. Ensure that your IP address scheme doesn't overlap with 10.10.0.0/16.

### Plan *vnet1*

In the first virtual network, *vnet1*:

- The largest subnet requires 200 hosts.
- The growth prediction is 10% in hosts and services per year. Plan for 200 + 40 = 240 hosts in the largest subnet.

Answer the following questions, based on the information you have learned in this module:

- Choose a CIDR for *vnet1* that allows 65,536 IP addresses. 
- Choose a CIDR for subnets in *vnet1* that allows enough IP addresses on each subnet.
- Remember to subtract **5** from the total IP addresses in the address space, to find the number of useable host IP addresses in the subnet for Azure.

### Plan *vnet2*

In the second virtual network, *vnet2*:

- The largest subnet requires 100 hosts.
- The growth prediction is 10% in hosts per year. Plan for 100 + 20 = 120 hosts in the largest subnet.

Answer the following questions:

- Choose the CIDR for *vnet2* that allows 256 IP addresses.
- Choose a CIDR for subnets in *vnet1* that allows 123 IP addresses on each subnet.
- Remember to subtract **-5** from the total IP addresses in the address space, to find the number of useable host IP addresses in the subnet for Azure.

### Plan *vnet3*

In the third virtual network, *vnet3*:

- The largest subnet requires four hosts.
- The growth prediction is 50% in hosts per year. Plan for 4 + 4 = 8 hosts in the largest subnet.

Answer the following questions:

- Choose the CIDR for *vnet3* that allows 16 IP addresses.
- Choose a CIDR for subnets in *vnet1* that allows 11 IP addresses on each subnet.
- Remember to subtract **-5** from the total IP addresses in the address space, to find the number of useable host IP addresses in the subnet for Azure.

Here's the topology of the network that you're designing for the IP address scheme:

![Network topology](../media/4-ip-address-scheme-topology.png)

## IP address design scheme

The table below shows the correct IP address design scheme:

| Virtual network | Virtual network CIDR | Total IP addresses per virtual network | Subnet CIDR | Useable hosts per subnet | 
| --- | --- | --- | --- | --- |
| *vnet1* | 10.20.0.0/16 | 65,536 | 10.20.1.0/24 | 251 |
| *vnet2* | 10.30.30.0/24 | 256 |  10.30.30.0/25 | 123 |
| *vnet3* |  10.40.40.0/28 | 16 |  10.40.40.0/28 | 11 |
| | |
