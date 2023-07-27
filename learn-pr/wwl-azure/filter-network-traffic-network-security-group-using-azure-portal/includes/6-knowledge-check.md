
## Multiple Choice
What is the purpose of a Network Security Group (NSG) in Azure?
( ) To manage user access to Azure resources {{Incorrect. This is the role of Azure Active Directory and Azure role-based access control.}}
(x) To filter network traffic and enforce access controls {{Correct. A Network Security Group (NSG) in Azure is used to filter network traffic by defining inbound and outbound security rules. It helps enforce access controls and restricts network traffic to Azure resources based on source, destination, port, and protocol.}}
( ) To monitor performance and availability of Azure services {{Incorrect. This is the role of Azure Monitor and Azure Application Insights.}}
( ) To provision and manage virtual machines in Azure {{Incorrect. This is the role of Azure Virtual Machines and Azure Virtual Machine Scale Sets.}}

## Multiple Choice
Which of the following is a valid network security rule in an NSG?
( ) Allow inbound traffic from any source to port 80 {{Incorrect. This rule allows incoming traffic on port 80 from any source.}}
( ) Deny outbound traffic to a specific IP address {{Incorrect. This rule blocks outbound traffic to a specific IP address.}}
(x) Allow all traffic within the virtual network {{Correct. Allowing all traffic within the virtual network would eliminate the purpose of using a Network Security Group (NSG) to filter network traffic. NSGs are designed to restrict and control network traffic based on defined rules.}}
( ) Allow SSH traffic from a specific IP range {{Incorrect. This rule permits SSH traffic from a specific range of IP addresses.}}

## Multiple Choice
Which of the following methods would associate an NSG with an Azure resource?
( ) During the creation of the Azure resource {{Incorrect. NSG association is not typically done during resource creation.}}
(x) By modifying the virtual network settings {{Correct. To associate a Network Security Group (NSG) with an Azure resource, you need to modify the virtual network settings and associate the NSG with the desired subnet or network interface.}}
( ) By using Azure PowerShell commands {{Incorrect. While possible, it is not the primary method for associating NSGs with resources.}}
( ) By accessing the Azure portal and Defender for Cloud {{Incorrect. The Azure portal and Defender for Cloud focuses on security posture and recommendations, not NSG association.}}

## Multiple Choice
What happens to network traffic that doesn't match any NSG rules?
( ) It is allowed by default {{Incorrect. Allowing traffic by default would pose a security risk.}}
(x) It is denied by default {{Correct. By default, network traffic that does not match any Network Security Group (NSG) rules is denied. This ensures that any traffic not explicitly allowed is blocked and helps maintain a secure network environment.}}
( ) It is logged for analysis {{Incorrect. NSGs do not log traffic by default, but logging can be enabled for further analysis.}}
( ) It is redirected to Defender for Cloud {{Incorrect. Network traffic is not automatically redirected to Defender for Cloud.}}

