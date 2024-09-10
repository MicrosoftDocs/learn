In your manufacturing company, you asked the operations and engineering teams about their requirements for the number of virtual machines in Azure. Also, you asked them about their plans for expansion. Based on the results of this survey, you want to plan an IP addressing scheme that you won't have to change in the foreseeable future.

In this unit, you explore the requirements for a network IP address scheme. You learn about classless inter-domain routing (CIDR) and how you can use it to slice an IP block to meet your addressing needs. In the next unit, there's an exercise that shows how to plan IP addressing for Azure virtual networks.

## Gather your requirements

Before planning your network IP address scheme, you must gather the requirements for your infrastructure. These requirements also will help you prepare for future growth by reserving extra IP addresses and subnets.

Here are two of the questions you might ask to discover the requirements:

- How many devices do you have on the network?
- How many devices are you planning to add to the network in the future?

When your network expands, you don't want to redesign the IP address scheme. Here are some other questions you could ask:

- Based on the services running on the infrastructure, what devices do you need to separate?
- How many subnets do you need?
- How many devices per subnet do you have?
- How many devices are you planning to add to the subnets in future?
- Are all subnets going to be the same size?
- How many subnets do you want or plan to add in future?

You need to isolate some services. Isolating services provides another layer of security, but also requires good planning. For example, public devices can access your front-end servers, but the back-end servers need to be isolated. Subnets help isolate the network in Azure. However, all subnets within a virtual network can communicate with each other in Azure by default. To provide further isolation, you can use a network security group. You might isolate services depending on the data and its security requirements. For example, you might choose to isolate HR data and the company's financial data from customer databases.

When you know the requirements, you have a greater understanding of the total number of devices on the network per subnet and how many subnets you need. CIDR allows more flexible allocation of IP addresses than was possible with the original system of IP address classes. Depending on your requirements, you determine the required subnets and hosts out of the block of IP Addresses.

Remember that Azure uses the first three addresses on each subnet. The subnets' first and last IP addresses also are reserved for protocol conformance. Therefore, the number of possible addresses on an Azure subnet is **(2^n)-5**, where **n** represents the number of host bits.
