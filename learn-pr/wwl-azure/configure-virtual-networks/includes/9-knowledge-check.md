Choose the best response for each question. Then select Check your answers.

## Multiple Choice
When assigning private IPv4 addresses in a subnet with the address range 10.3.0.0/16, which of the following addresses are available for assignment dynamically?
( ) 10.3.0.2 {{That's incorrect. Azure reserves the first four addresses in each subnet address range. These four addresses cannot be assigned to your resources: 10.3.0.0-10.3.0.3.}}
( ) 10.3.255.255 {{That's incorrect. This is the subnet broadcast address, which is unavailable.}}
(x) 10.3.255.254 {{That's correct. Any address in the range 10.3.0.4 through 10.3.255.254 is available for assignment.}}

## Multiple Choice
The IT team has implemented Firewall rules to deny traffic based on IP address ranges. Which of the following should be used to meet the requirement?
( ) Dynamically assigned IP addresses. {{That's incorrect. Dynamically assigned IP addresses will require the Firewall rules to be changed. }}
(x) Statically assigned IP addresses. {{That's correct. In this situation, use statically assigned IP addresses to avoid having to change the Firewall rules.}}
( ) IP addresses in the reserved range. {{That's incorrect. IP addresses in the reserved range cannot be used. }}

## Multiple Choice
Which of the following resources could have a public IP address?
(x) Virtual Machine {{That's correct. Public IP addresses can be assigned to virtual machines.}}
( ) Azure Data Lake {{That's incorrect. Although Azure Data Lake is accessible over the internet, a public IP address is not assigned to the service.}}
( ) Azure Key Vault {{That's incorrect. Although Azure Key Vault is accessible over the internet, a public IP address is not assigned to the service.}}

