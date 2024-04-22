Contoso uses AD DS to authenticate users, computers, applications, and other resources. Contoso plans to implement several line of business (LOB) applications, partly on-premises and partly in Azure. IT staff have concerns that there might be latency sending authentication requests from Azure back to on-premises. As a consequence, you are considering implementing directory and identity services in Azure to help reduce this latency.
Some of the reasons you might consider placing domain controllers in Azure include:

- Providing resiliency to the on-premises directory.
- Keeping authentication requests for Azure-based services within the Azure environment.
- Extending access from on-premises AD DS to worldwide sites.

## Overview

The process of deploying an Active Directory domain controller on an Azure VM is similar to the process of deploying a domain controller in an on-premises environment. One primary difference is that when you deploy a domain controller in Azure, you must place the Active Directory database on the data disk of an Azure VM to avoid potential database corruption. Database corruption might occur because of the read and write cache settings of the operating system disk on the Azure VM.
Azure provides multiple options for implementing directory and identity services using AD DS in Azure. The different considerations and requirements are based on the deployment scenario that you select.

### Deploy AD DS only on an Azure VM

This scenario involves creating a VNet, but doesn't require cross-premises connectivity. Typically, this deployment starts with a new forest and all the domain controllers run only on Azure VMs. In this scenario, you should consider setting static IP addresses for domain controllers. This scenario is common for:

- Apps that depend on Kerberos authentication, but don't have any requirements that are related to on-premises directory services.
- Greenfield deployments where there's no existing on-premises AD DS environment.

### Deploy AD DS in both an on-premises infrastructure and on an Azure VM

This scenario is common for apps that are LDAP–aware and that support Windows-integrated authentication. This scenario requires creating a VNet with cross-premises connectivity and proper IP address allocation for VMs that are running in the cloud.

The primary goal of this scenario is to optimize the cost of a solution, considering that inbound traffic (*ingress*) is free but not outbound traffic (*egress*). This is because systems and applications in Azure would refer to the AD DS domain controllers in Azure for authentication, LDAP lookups, and name server resolution. This scenario provides faster performance and a better sign-in experience for users who access the apps by authenticating to the cloud-based domain controllers.

When deploying AD DS in an on-premises environment and on an Azure VM, there are multiple options that Azure supports, as described in the following table.

|Deployment option|Description|
|----|----|
|Deploy an additional AD DS domain controller to an Azure VM|If your application is hosted partly on-premises and partly in Azure, it may be more efficient to replicate AD DS in Azure. This can reduce the latency caused by sending authentication requests from the cloud back to AD DS running on-premises. This architecture is commonly used when the on-premises network and the Azure virtual network are connected by a virtual private network (VPN) or ExpressRoute connection. This architecture also supports bidirectional replication, meaning  you can make changes either on-premises or in the cloud, and both sources will be kept consistent. Typical uses for this architecture include hybrid applications in which functionality is distributed between on-premises and Azure, and applications and services that perform authentication using Active Directory.|
|Deploy a separate Active Directory forest or domain to Azure that is trusted by domains in your on-premises AD forest|AD DS stores identity information in a hierarchical structure. The top node in the hierarchical structure is known as a *forest*. A forest contains domains, and domains contain other types of objects. This reference architecture includes creating an AD DS domain in Azure that is a member of the same AD forest as the on-premises domain. In this scenario, creating a trust relationship between the different domains is not required because domains in the same forest inherently (automatically) trust each other. Alternatively, you can create an AD DS forest in Azure with a one-way outgoing or a two-way bidirectional trust relationship with an on-premises domain. In this scenario, the forest in Azure contains a domain that doesn't exist on-premises. Because of the trust relationship, sign-ins made against on-premises domains can be trusted for access to resources in the separate Azure domain. Typical uses for this architecture include maintaining security separation for objects and identities kept in the cloud, and migrating individual domains from on-premises to the cloud.|
