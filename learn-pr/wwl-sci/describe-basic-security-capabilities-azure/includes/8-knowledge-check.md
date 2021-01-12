Choose the best response for each of the questions below. Then select Check your answers.

quiz title: Check your knowledge

Multiple Choice
You’re the Azure admin, and you want to increase the priority of a network security group, what five sources of information will you need to provide?  
() source, source port, destination, destination port, and network layer.{{That's incorrect. NSG security rules do not use the network layer as one of the five evaluation points.}}
(x) source, source port, destination, destination port, and protocol.{{That's correct. NSG security rules are evaluated by priority using five information points: source, source port, destination, destination port, and protocol to either allow or deny the traffic.}}
() source, source port, destination, destination port, and target resource.{{That's incorrect. NSG security rules do not use the target resource as one of the five evaluation points.}}

Multiple Choice
You have an ever-growing list of resources in Azure. You want to protect your Azure resources from DDoS attacks, which Azure DDoS Protection tier will you use to target Azure Virtual Network resources?
() Basic.{{That's incorrect. The Basic service tier provides always-on traffic monitoring and real-time mitigation of common network-level attacks provide the same defenses that Microsoft’s online services use.}}
(x) Standard.{{That's correct. The Standard service tier provides additional mitigation capabilities that are tuned specifically to Microsoft Azure Virtual Network resources.}}
() Advanced.{{That's incorrect. Azure DDoS Protection is available in only two tiers. Advanced is not a valid tier.}}

Multiple Choice
You have several virtual machines in Azure. You want to deploy Azure Bastion to get secure access to your virtual machines in Azure. What limitation should you keep in mind?  
(x) Azure Bastion is deployed per virtual network.{{That's correct. Azure Bastion deployment is per virtual network, not per subscription/account or virtual machine.}}
() Azure Bastion is deployed per subscription.{{That's incorrect. Azure Bastion deployment is not limited by subscription/account.}}
() Azure Bastion is deployed per virtual machine.{{That's incorrect. Azure Bastion deployment is not limited by virtual machine.}}

Multiple Choice
Much of your organization’s application data is in Azure. You want to take advantage of the encryption capabilities in Azure, which service would you use to store your application’s secrets?
 () Transparent data encryption.{{That's incorrect. Transparent data encryption helps protect Azure SQL Database and Azure Data Warehouse against the threat of malicious activity.}}
 () Secrets management.{{That's incorrect. Secrets management is an aspect of Azure Key Vault.}}
 (x) Azure Key Vault.{{That's correct. Azure Key Vault is a centralized cloud service for storing your application secrets.}}
