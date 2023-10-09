This unit will provide an overview of the general best practices for IaaS and PaaS security.

## IaaS security

### Protect VMs by using authentication and access control

The first step in protecting your VMs is to ensure that only authorized users can set up new VMs and access VMs.

Use [Azure policies](https://learn.microsoft.com/azure/governance/policy/overview) to establish conventions for resources in your organization and create customized policies. Apply these policies to resources, such as [resource groups](https://learn.microsoft.com/azure/azure-resource-manager/management/overview). VMs that belong to a resource group inherit its policies.

### Use multiple VMs for better availability

If your VM runs critical applications that need to have high availability, we strongly recommend that you use multiple VMs. For better availability, use an [availability set](https://learn.microsoft.com/azure/virtual-machines/availability-set-overview) or availability [zones](https://learn.microsoft.com/azure/availability-zones/az-overview).

An availability set is a logical grouping that you can use in Azure to ensure that the VM resources you place within it are isolated from each other when they’re deployed in an Azure datacenter. Azure ensures that the VMs you place in an availability set run across multiple physical servers, compute racks, storage units, and network switches. If a hardware or Azure software failure occurs, only a subset of your VMs are affected, and your overall application continues to be available to your customers. Availability sets are an essential capability when you want to build reliable cloud solutions.

### Protect against malware

You should install antimalware protection to help identify and remove viruses, spyware, and other malicious software. You can install [Microsoft Antimalware](https://learn.microsoft.com/azure/security/fundamentals/antimalware) or a Microsoft partner’s endpoint protection solution ([Trend Micro](https://help.deepsecurity.trendmicro.com/Welcome.html), [Broadcom](https://www.broadcom.com/products), [McAfee](https://www.mcafee.com/us/products.aspx), [Windows Defender](https://www.microsoft.com/windows/comprehensive-security), and [System Center Endpoint Protection](https://learn.microsoft.com/configmgr/protect/deploy-use/endpoint-protection)).

### Manage your VM updates

Azure VMs, like all on-premises VMs, are meant to be user managed. Azure doesn't push Windows updates to them. You need to manage your VM updates.

Use the [Update Management](https://learn.microsoft.com/azure/automation/update-management/overview) solution in Azure Automation to manage operating system updates for your Windows and Linux computers that are deployed in Azure, in on-premises environments, or in other cloud providers. You can quickly assess the status of available updates on all agent computers and manage the process of installing required updates for servers.

### Manage your VM security posture

Cyberthreats are evolving. Safeguarding your VMs requires a monitoring capability that can quickly detect threats, prevent unauthorized access to your resources, trigger alerts, and reduce false positives.

To monitor the security posture of your [Windows](https://learn.microsoft.com/azure/security-center/security-center-introduction) and [Linux VMs](https://learn.microsoft.com/azure/security-center/security-center-introduction), use [Microsoft Defender for Cloud](https://learn.microsoft.com/azure/security-center/security-center-introduction). 

### Monitor VM performance

Resource abuse can be a problem when VM processes consume more resources than they should. Performance issues with a VM can lead to service disruption, which violates the security principle of availability. This is particularly important for VMs that are hosting IIS or other web servers, because high CPU or memory usage might indicate a denial of service (DoS) attack. It’s imperative to monitor VM access not only reactively while an issue is occurring, but also proactively against baseline performance as measured during normal operation.

### Encrypt your virtual hard disk files

We recommend that you encrypt your virtual hard disks (VHDs) to help protect your boot volume and data volumes at rest in storage, along with your encryption keys and secrets.

[Azure Disk Encryption for Linux VMs](https://learn.microsoft.com/azure/virtual-machines/linux/disk-encryption-overview) and [Azure Disk Encryption for Windows VMs](https://learn.microsoft.com/azure/virtual-machines/linux/disk-encryption-overview) helps you encrypt your Linux and Windows IaaS virtual machine disks. Azure Disk Encryption uses the industry-standard [DM-Crypt](https://en.wikipedia.org/wiki/Dm-crypt) feature of Linux and the [BitLocker](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732774(v=ws.11)) feature of Windows to provide volume encryption for the OS and the data disks. The solution is integrated with [Azure Key Vault](https://learn.microsoft.com/azure/key-vault/) to help you control and manage the disk-encryption keys and secrets in your key vault subscription. The solution also ensures that all data on the virtual machine disks are encrypted at rest in Azure Storage.

### Restrict direct internet connectivity

Monitor and restrict VM direct internet connectivity. Attackers constantly scan public cloud IP ranges for open management ports and attempt “easy” attacks like common passwords and known unpatched vulnerabilities. 

## PaaS security

### Adopt a policy of identity as the primary security perimeter

One of the five essential characteristics of cloud computing is broad network access, which makes network-centric thinking less relevant. The goal of much of cloud computing is to allow users to access resources regardless of location. For most users, their location is going to be somewhere on the Internet.

The following figure shows how the security perimeter has evolved from a network perimeter to an identity perimeter. Security becomes less about defending your network and more about defending your data, as well as managing the security of your apps and users. The key difference is that you want to push security closer to what's important to your company.

![Diagram showing identity as the new security perimeter.](../media/identity-perimeter.png)

Initially, Azure PaaS services (for example, web roles and Azure SQL) provided little or no traditional network perimeter defenses. It was understood that the element's purpose was to be exposed to the Internet (web role) and that authentication provides the new perimeter (for example, BLOB or Azure SQL).

Modern security practices assume that the adversary has breached the network perimeter. Therefore, modern defense practices have moved to identity. Organizations must establish an identity-based security perimeter with strong authentication and authorization hygiene (best practices).

Principles and patterns for the network perimeter have been available for decades. In contrast, the industry has relatively less experience with using identity as the primary security perimeter. With that said, we have accumulated enough experience to provide some general recommendations that are proven in the field and apply to almost all PaaS services.

### Develop on Azure App Service

[Azure App Service](https://learn.microsoft.com/azure/app-service/overview) is a PaaS offering that lets you create web and mobile apps for any platform or device and connect to data anywhere, in the cloud or on-premises. App Service includes the web and mobile capabilities that were previously delivered separately as Azure Websites and Azure Mobile Services. It also includes new capabilities for automating business processes and hosting cloud APIs. As a single integrated service, App Service brings a rich set of capabilities to web, mobile, and integration scenarios.

### Install a web application firewall

Web applications are increasingly targets of malicious attacks that exploit common known vulnerabilities. Common among these exploits are SQL injection attacks, cross site scripting attacks to name a few. Preventing such attacks in application code can be challenging and may require rigorous maintenance, patching and monitoring at many layers of the application topology. A centralized web application firewall helps make security management much simpler and gives better assurance to application administrators against threats or intrusions. A WAF solution can also react to a security threat faster by patching a known vulnerability at a central location versus securing each of individual web applications.

[Web Application Firewall (WAF)](https://learn.microsoft.com/azure/web-application-firewall/overview) provides centralized protection of your web applications from common exploits and vulnerabilities.

### DDoS protection

[Azure DDoS Protection Standard](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview), combined with application-design best practices, provides enhanced DDoS mitigation features to provide more defense against DDoS attacks. You should enable [Azure DDOS Protection Standard](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview) on any perimeter virtual network.

### Monitor the performance of your applications

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your application. An effective monitoring strategy helps you understand the detailed operation of the components of your application. It helps you increase your uptime by notifying you of critical issues so that you can resolve them before they become problems. It also helps you detect anomalies that might be security related.

### Perform security penetration testing

Validating security defenses is as important as testing any other functionality. Make [penetration testing](https://learn.microsoft.com/azure/security/fundamentals/pen-testing) a standard part of your build and deployment process. Schedule regular security tests and vulnerability scanning on deployed applications, and monitor for open ports, endpoints, and attacks.