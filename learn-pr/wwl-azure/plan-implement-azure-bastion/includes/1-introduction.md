Contoso Manufacturing operates factory floor systems that require remote management access for operational engineers. Currently, these virtual machines expose RDP (port 3389) and SSH (port 22) to the internet through network security group rules with broad source IP ranges. A recent threat analysis revealed active brute-force and credential-stuffing attacks targeting these open ports. The security team needs to eliminate public RDP and SSH exposure while preserving legitimate operational access for engineers who manage these systems.

Azure Bastion provides secure remote connectivity to Azure virtual machines without exposing RDP and SSH ports to the internet. In this module, you learn how to plan, deploy, and configure Azure Bastion to protect factory systems while maintaining operational workflows.

## Learning objectives

- Select the appropriate Azure Bastion SKU based on scale, feature, and cost requirements
- Deploy and configure Azure Bastion in an Azure virtual network
- Connect to Azure virtual machines through Azure Bastion using portal and native client methods
- Configure advanced Bastion features including native client support, shareable links, and session recording

## Prerequisites

- Familiarity with Azure virtual networks, subnets, and network security groups
- Understanding of RDP and SSH remote access protocols
- Experience with Azure virtual machine management
- Access to an Azure subscription with permissions to create network resources

Now that you understand the security challenge and what Azure Bastion provides, you're ready to explore how to select the right Bastion SKU and plan the deployment architecture.
