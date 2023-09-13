## The risk of open management ports on a virtual machine

Threat actors actively hunt accessible machines with open management ports, like **remote desktop protocol (RDP)** or **secure shell protocol (SSH)**. All of your virtual machines are potential targets for an attack. When a VM is successfully compromised, it's used as the entry point to attack further resources within your environment.

## Why JIT VM access is the solution

As with all cybersecurity prevention techniques, your goal should be to reduce the attack surface. In this case that means having fewer open ports especially management ports. Your legitimate users also use these ports, so it's not practical to keep them closed. To solve this dilemma, Microsoft Defender for Cloud offers JIT. With JIT, you can lock down the inbound traffic to your VMs, reducing exposure to attacks while providing easy access to connect to VMs when needed.

## How JIT operates with network resources in Azure and AWS

In Azure, you can block inbound traffic on specific ports, by enabling just-in-time VM access. Defender for Cloud ensures "**deny all inbound traffic**" rules exist for your selected ports in the **network security group (NSG)** and Azure Firewall rules. These rules restrict access to your Azure VMs’ management ports and defend them from attack.

If other rules already exist for the selected ports, then those existing rules take priority over the new "**deny all inbound traffic**" rules. If there are no existing rules on the selected ports, then the new rules take top priority in the NSG and Azure Firewall.

In AWS, by enabling JIT-access the relevant rules in the attached **Amazon Elastic Compute Cloud (Amazon EC2)** security groups, for the selected ports, are revoked which blocks inbound traffic on those specific ports.

When a user requests access to a VM, Defender for Cloud checks that the user has **Azure role-based access control (Azure RBAC)** permissions for that VM. If the request is approved, Defender for Cloud configures the NSGs and Azure Firewall to allow inbound traffic to the selected ports from the r**elevant IP address** (**or range**), for the amount of time that was specified. In AWS, Defender for Cloud creates a new EC2 security group that allows inbound traffic to the specified ports. After the time has expired, Defender for Cloud restores the NSGs to their previous states. Connections that are already established are not interrupted.

## **Just-in-time VM enabled on an Azure Virtual Machine.**

**Example:** Azure virtual machine

The diagram shows the logic that Defender for Cloud applies when deciding how to categorize your supported VMs (i.e., Azure Virtual Machine)

:::image type="content" source="../media/just-in-time-vm-enabled-on-an-azure-virtual-machine-f4788d97.png" alt-text="Diagram showing just in time VM enabled on an Azure virtual machine.":::


## **Just-in-time VM enabled on an AWS EC2 Instance.**

The diagram shows the logic that Defender for Cloud applies when deciding how to categorize your supported VMs (i.e., AWS EC2 instance)

**Example:** AWS EC2 Instance

:::image type="content" source="../media/just-in-time-vm-enabled-on-an-aws-ec2-virtual-machine-d1250e67.png" alt-text="Diagram showing just in time VM enabled on an AWS EC2 instance.":::


## Added to the recommendation’s Unhealthy resources tab

The diagram shows the logic Defender for Cloud applies when deciding how to categorize your supported VM. When Defender for Cloud finds a machine that can benefit from JIT, it adds that machine to the recommendation's Unhealthy resources tab.

**Example:** Affected resources

:::image type="content" source="../media/added-to-the-recommendations-unhealthy-resources-tab-0b994a13.png" alt-text="Screenshot showing the recommendations unhealthy resources tab.":::
