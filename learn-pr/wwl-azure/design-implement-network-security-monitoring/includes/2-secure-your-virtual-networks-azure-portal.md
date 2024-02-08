Network security covers a multitude of technologies, devices, and processes. It provides a set of rules and configurations designed to protect the integrity, confidentiality and accessibility of computer networks and data. Every organization, regardless of size, industry, or infrastructure, requires a degree of network security solutions in place to protect it from the ever-growing risks of attacks.

For Microsoft Azure, securing or providing the ability to secure resources like microservices, VMs, data, and others is paramount. Microsoft Azure ensures it through a distributed virtual firewall.

A virtual network in Microsoft Azure is isolated from other networks, while communicating through private IP addresses.

## Network Security

Network Security covers controls to secure and protect Azure networks, including securing virtual networks, establishing private connections, preventing and mitigating external attacks, and securing DNS. Full description of the controls can be found at [Security Control V3: Network Security on Microsoft Docs](/security/benchmark/azure/security-controls-v3-network-security).

### NS-1: Establish network segmentation boundaries

**Security Principle**: Ensure that your virtual network deployment aligns to your enterprise segmentation strategy defined in the GS-2 security control. Any workload that could incur higher risk for the organization should be in isolated virtual networks. Examples of high-risk workload include:

- An application storing or processing highly sensitive data.
- An external network-facing application accessible by the public or users outside of your organization.
- An application using insecure architecture or containing vulnerabilities that cannot be easily remediated.

To enhance your enterprise segmentation strategy, restrict or monitor traffic between internal resources using network controls. For specific, well-defined applications (such as a 3-tier app), this can be a highly secure "deny by default, permit by exception" approach by restricting the ports, protocols, source, and destination IPs of the network traffic. If you have many applications and endpoints interacting with each other, blocking traffic may not scale well, and you may only be able to monitor traffic.

**Azure Guidance**: Create a virtual network (VNet) as a fundamental segmentation approach in your Azure network, so resources such as VMs can be deployed into the VNet within a network boundary. To further segment the network, you can create subnets inside VNet for smaller sub-networks.

Use network security groups (NSG) as a network layer control to restrict or monitor traffic by port, protocol, source IP address, or destination IP address.

You can also use application security groups (ASGs) to simplify complex configuration. Instead of defining policy based on explicit IP addresses in network security groups, ASGs enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups.

### NS-2: Secure cloud services with network controls

**Security Principle**: Secure cloud services by establishing a private access point for the resources. You should also disable or restrict access from public network when possible.

**Azure Guidance**: Deploy private endpoints for all Azure resources that support the Private Link feature, to establish a private access point for the resources. You should also disable or restrict public network access to services where feasible.

For certain services, you also have the option to deploy VNet integration for the service where you can restrict the VNET to establish a private access point for the service.

### NS-3: Deploy firewall at the edge of enterprise network

**Security Principle**: Deploy a firewall to perform advanced filtering on network traffic to and from external networks. You can also use firewalls between internal segments to support a segmentation strategy. If required, use custom routes for your subnet to override the system route when you need to force the network traffic to go through a network appliance for security control purpose.

At a minimum, block known bad IP addresses and high-risk protocols, such as remote management (for example, RDP and SSH) and intranet protocols (for example, SMB and Kerberos).

**Azure Guidance**: Use Azure Firewall to provide fully stateful application layer traffic restriction (such as URL filtering) and/or central management over a large number of enterprise segments or spokes (in a hub/spoke topology).

If you have a complex network topology, such as a hub/spoke setup, you may need to create user-defined routes (UDR) to ensure the traffic goes through the desired route. For example, you have option to use an UDR to redirect egress internet traffic through a specific Azure Firewall or a network virtual appliance.

### NS-4: Deploy intrusion detection/intrusion prevention systems (IDS/IPS)

**Security Principle**: Use network intrusion detection and intrusion prevention systems (IDS/IPS) to inspect the network and payload traffic to or from your workload. Ensure that IDS/IPS is always tuned to provide high-quality alerts to your SIEM solution.

For more in-depth host level detection and prevention capability, use host-based IDS/IPS or a host-based endpoint detection and response (EDR) solution in conjunction with the network IDS/IPS.

**Azure Guidance**: Use Azure Firewall’s IDPS capability on your network to alert on and/or block traffic to and from known malicious IP addresses and domains.

For more in-depth host level detection and prevention capability, deploy host-based IDS/IPS or a host-based endpoint detection and response (EDR) solution, such as Microsoft Defender for Endpoint, at the VM level in conjunction with the network IDS/IPS.

### NS-5: Deploy DDOS protection

**Security Principle**: Deploy distributed denial of service (DDoS) protection to protect your network and applications from attacks.

**Azure Guidance**: Enable DDoS Network Protection plan on your VNet to protect resources that are exposed to the public networks.

### NS-6: Deploy web application firewall

**Security Principle**: Deploy a web application firewall (WAF) and configure the appropriate rules to protect your web applications and APIs from application-specific attacks.

**Azure Guidance**: Use web application firewall (WAF) capabilities in Azure Application Gateway, Azure Front Door, and Azure Content Delivery Network (CDN) to protect your applications, services and APIs against application layer attacks at the edge of your network. Set your WAF in "detection" or "prevention mode", depending on your needs and threat landscape. Choose a built-in ruleset, such as OWASP Top 10 vulnerabilities, and tune it to your application.

### NS-7: Simplify network security configuration

**Security Principle**: When managing a complex network environment, use tools to simplify, centralize and enhance the network security management.

**Azure Guidance**: Use the following features to simplify the implementation and management of the NSG and Azure Firewall rules:

- Use Microsoft Defender for Cloud Adaptive Network Hardening to recommend NSG hardening rules that further limit ports, protocols and source IPs based on threat intelligence and traffic analysis result.
- Use Azure Firewall Manager to centralize the firewall policy and route management of the virtual network. To simplify the firewall rules and network security groups implementation, you can also use the Azure Firewall Manager ARM (Azure Resource Manager) template.

### NS-8: Detect and disable insecure services and protocols

**Security Principle**: Detect and disable insecure services and protocols at the OS, application, or software package layer. Deploy compensating controls if disabling insecure services and protocols are not possible.

**Azure Guidance**: Use Azure Sentinel’s built-in Insecure Protocol Workbook to discover the use of insecure services and protocols such as SSL/TLSv1, SSHv1, SMBv1, LM/NTLMv1, wDigest, Unsigned LDAP Binds, and weak ciphers in Kerberos. Disable insecure services and protocols that do not meet the appropriate security standard.

> [!NOTE]
> If disabling insecure services or protocols is not possible, use compensating controls such as blocking access to the resources through network security group, Azure Firewall, or Azure Web Application Firewall to reduce the attack surface.

### NS-9: Connect on-premises or cloud network privately

**Security Principle**: Use private connections for secure communication between different networks, such as cloud service provider datacenters and on-premises infrastructure in a colocation environment.

**Azure Guidance**: Use private connections for secure communication between different networks, such as cloud service provider datacenters and on-premises infrastructure in a colocation environment.

For lightweight connectivity between site-to-site or point-to-site, use Azure virtual private network (VPN) to create a secure connection between your on-premises site or end-user device to the Azure virtual network.

For enterprise-level high performance connection, use Azure ExpressRoute (or Virtual WAN) to connect Azure datacenters and on-premises infrastructure in a co-location environment.

When connecting two or more Azure virtual networks together, use virtual network peering. Network traffic between peered virtual networks is private and is kept on the Azure backbone network.

### NS-10: Ensure Domain Name System (DNS) security

**Security Principle**: Ensure that Domain Name System (DNS) security configuration protects against known risks:

- Use trusted authoritative and recursive DNS services across your cloud environment to ensure the client (such as operating systems and applications) receive the correct resolution result.
- Separate the public and private DNS resolution so the DNS resolution process for the private network can be isolated from the public network.
- Ensure your DNS security strategy also includes mitigations against common attacks, such as dangling DNS, DNS amplifications attacks, DNS poisoning and spoofing, and so on.

**Azure Guidance**: Use Azure recursive DNS or a trusted external DNS server in your workload recursive DNS setup, such as in VM's operating system or in the application.

Use Azure Private DNS for private DNS zone setup where the DNS resolution process does not leave the virtual network. Use a custom DNS to restrict the DNS resolution which only allows the trusted resolution to your client.

Use Azure Defender for DNS for the advanced protection against the following security threats to your workload or your DNS service:

- Data exfiltration from your Azure resources using DNS tunneling
- Malware communicating with command-and-control server
- Communication with malicious domains as phishing and crypto mining
- DNS attacks in communication with malicious DNS resolvers

You can also use Azure Defender for App Service to detect dangling DNS records if you decommission an App Service website without removing its custom domain from your DNS registrar.

## Microsoft cloud security benchmark

Microsoft has found that using security benchmarks can help you quickly secure cloud deployments. A comprehensive security best practice framework from cloud service providers can give you a starting point for selecting specific security configuration settings in your cloud environment, across multiple service providers and allow you to monitor these configurations using a single pane of glass.

The Microsoft cloud security benchmark (MCSB) includes a collection of high-impact security recommendations you can use to help secure your cloud services in a single or multicloud environment. MCSB recommendations include two key aspects:

- **Security controls:** These recommendations are generally applicable across your cloud workloads. Each recommendation identifies a list of stakeholders that are typically involved in planning, approval, or implementation of the benchmark.
- **Service baselines:** These apply the controls to individual cloud services to provide recommendations on that specific service’s security configuration. We currently have service baselines available only for Azure.

### Implement Microsoft cloud security benchmark

- **Plan** your MCSB implementation by reviewing the documentation for the enterprise controls and service-specific baselines to plan your control framework and how it maps to guidance like Center for Internet Security (CIS) Controls, National Institute of Standards and Technology (NIST), and the Payment Card Industry Data Security Standard (PCI-DSS) framework.
- **Monitor** your compliance with MCSB status (and other control sets) using the Microsoft Defender for Cloud – Regulatory Compliance Dashboard for your multicloud environment.
- **Establish** guardrails to automate secure configurations and enforce compliance with MCSB (and other requirements in your organization) using features such as Azure Blueprints, Azure Policy, or the equivalent technologies from other cloud platforms.

### Terminology

The terms **control**, and **baseline** are used often in the Microsoft cloud security benchmark documentation, and it is important to understand how Azure uses those terms.

|**Term**|**Description**|**Example**  |
|---------|---------|---------|
|  Control  |A control is a high-level description of a feature or activity that needs to be addressed and is not specific to a technology or implementation.| Data Protection is one of the security control families. Data Protection contains specific actions that must be addressed to help ensure data is protected. |
| Baseline  | A baseline is the implementation of the control on the individual Azure services. Each organization dictates a benchmark recommendation and corresponding configurations are needed in Azure. Note: Today we have service baselines available only for Azure. |        The Contoso company looks to enable Azure SQL security features by following the configuration recommended in the Azure SQL security baseline.       |

## Using Microsoft Defender for Cloud for regulatory compliance

Microsoft Defender for Cloud helps streamline the process for meeting regulatory compliance requirements, using the regulatory compliance dashboard.

The regulatory compliance dashboard shows the status of all the assessments within your environment for your chosen standards and regulations. As you act on the recommendations and reduce risk factors in your environment, your compliance posture improves.

### Regulatory compliance dashboard

:::image type="content" source="../media/compliance-dashboard-799a65d6.png" alt-text="Screenshot showing Microsoft Defender for Cloud regulatory compliance dashboard."lightbox="../media/compliance-dashboard-799a65d6.png":::

The dashboard shows an overview of your compliance status with the set of supported compliance regulations. You will see your overall compliance score, and the number of passing vs. failing assessments associated with each standard.

### Compliance controls

:::image type="content" source="../media/compliance-drilldown-a608a403.png" alt-text="Screenshot showing the regulatory compliance dashboard with drilldown to compliance controls.":::

1. Subscriptions the standard is applied on.
1. List of all controls for that standard.
1. View the details of passing and failing assessments associated with that control.
1. Number of affected resources.

Some controls are grayed out. These controls do not have any Microsoft Defender for Cloud assessments associated with them. Check their requirements and assess them in your environment. Some of these might be process-related and not technical.

### Exploring the details of compliance with a specific standard

To generate a PDF report with a summary of your current compliance status for a particular standard, select Download report.

:::image type="content" source="../media/download-report-e839f272.png" alt-text="Screenshot showing the download regulatory compliance report."lightbox="../media/download-report-e839f272.png":::

The report provides a high-level summary of your compliance status for the selected standard based on Microsoft Defender for Cloud assessments data. The report is organized according to the controls of that standard. The report can be shared with relevant stakeholders and might provide evidence to internal and external auditors.

## Alerts in Microsoft Defender for Cloud

Microsoft Defender for Cloud automatically collects, analyzes, and integrates log data from your Azure resources, the network, and connected partner solutions - like firewall and endpoint protection solutions - to detect real threats and reduce false positives. A list of prioritized security alerts is shown in Microsoft Defender for Cloud along with the information you need to quickly investigate the problem and steps to take to remediate an attack.

### Manage your security alerts

The Microsoft Defender for Cloud overview page shows the Security alerts tile at the top of the page, and as a link from the sidebar.

:::image type="content" source="../media/overview-page-alerts-links-a54c327f.png" alt-text="Screenshot that shows Microsoft Defender for Cloud overview page and the Security alerts tile." lightbox="../media/overview-page-alerts-links-a54c327f.png":::

The security alerts page shows the active alerts. You can sort the list by Severity, Alert title, Affected resource, Activity start time. MITRE ATTACK tactics, and status.

:::image type="content" source="../media/alerts-page-9ba7adc1.png" alt-text="Screenshot of the Active security alerts list.":::

To filter the alerts list, select any of the relevant filters. You can add further filters with the Add filter option.

:::image type="content" source="../media/alerts-adding-filters-large-356ce4df.png" alt-text="Screenshot of adding filters to the alerts view.":::


The list updates according to the filtering options you have selected. Filtering can be very helpful. For example, you might want to address security alerts that occurred in the last 24 hours because you are investigating a potential breach in the system.

### Respond to security alerts

From the Security alerts list, select an alert. A side pane opens and shows a description of the alert and all the affected resources.

:::image type="content" source="../media/alerts-details-pane-e9de3d97.png" alt-text="Screenshot showing the mini details view of a security alert.":::

View full details displays further information, as shown in the following image:

:::image type="content" source="../media/alert-take-action-834bdd16.png" alt-text="Screenshot showing the full details view of a security alert and take action pane.":::

The left pane of the security alert page shows high-level information regarding the security alert: title, severity, status, activity time, description of the suspicious activity, and the affected resource. Alongside the affected resource are the Azure tags relevant to the resource. Use these to infer the organizational context of the resource when investigating the alert.

The right pane includes the Alert details tab containing further details of the alert to help you investigate the issue: IP addresses, files, processes, and more.

Also in the right pane is the Take action tab. Use this tab to take further actions regarding the security alert. Actions such as:

- **Mitigate the threat:** Provides manual remediation steps for this security alert.
- **Prevent future attacks:** Provides security recommendations to help reduce the attack surface, increase security posture, and thus prevent future attacks.
- **Trigger automated response:** Provides the option to trigger a logic app as a response to this security alert.
- **Suppress similar alerts:** Provides the option to suppress future alerts with similar characteristics if the alert isn’t relevant for your organization.
