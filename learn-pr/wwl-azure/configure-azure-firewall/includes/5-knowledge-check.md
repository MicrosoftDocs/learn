Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Suppose a company wants to allow access to an Azure SQL Database instance. Which of the following network rule types should they use to configure Azure Firewall?
(x) Application {{That's correct. An application rule can be used to filter traffic based on an FQDN such as server1.database.windows.net.}}
( ) Network {{That's incorrect. A network rule can be used to filter traffic based on one or more of the following items: IP address, port, and protocol.}}
( ) NAT {{That's incorrect. A NAT rule can be used to translate and filter inbound internet traffic based on your firewall's public IP address and a specified port number.}}

## Multiple Choice
Suppose a company wants to allow external users to access an Azure virtual server with a remote desktop connection. Which one of the following items would be implemented on The Azure Firewall to allow these connections?
( ) Service tag {{That's incorrect. A service tag is a group of IP address prefixes related to a specific Azure service.}}
( ) Source network address translation {{That's incorrect. Use SNAT to translate internal private IP addresses to the public IP address of Azure Firewall.}}
(x) Destination network address translation {{That's correct. Use DNAT to translate Azure Firewall's public IP address to the private IP address of the virtual server.}}

## Multiple Choice
The Azure Firewall uses a?
( ) dynamically assigned public IP address. {{That's incorrect. The Azure Firewall doesn't use a dynamically assigned public IP address.}}
(x) statically assigned public IP address {{That's correct. The Azure Firewall uses a statically assigned public IP address.}}
( ) an IP address assigned from a pool of designated addresses. {{That's incorrect. The Azure Firewall doesn't use a pool of IP addresses.}}
