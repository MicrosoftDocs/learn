
Network security covers various technologies, devices, and processes. Security provides a set of rules and configurations designed to protect the integrity, confidentiality, and accessibility of computer networks and data. Every organization, regardless of size, industry, or infrastructure, requires a degree of network security solutions. These solutions protect from the ever-growing risks of attacks.

## Network Security

Network Security covers controls to secure and protect Azure networks. These controls include securing virtual networks, establishing private connections, preventing and mitigating external attacks, and securing DNS. A full description of the network security controls can be found at [Security Control V3: Network Security on Microsoft Learn](/security/benchmark/azure/security-controls-v3-network-security).

### NS-1: Establish network segmentation boundaries

**Security Principle**. Ensure that your virtual network deployment aligns to your enterprise segmentation strategy. Any workload that incurs higher risk for the organization should be in isolated virtual networks. 

### NS-2: Secure cloud services with network controls

**Security Principle**. Secure cloud services by establishing a private access point for the resources. You should also disable or restrict access from public network when possible.

### NS-3: Deploy firewall at the edge of enterprise network

**Security Principle**. Deploy a firewall to perform advanced filtering on network traffic to and from external networks. You can also use firewalls between internal segments to support a segmentation strategy. If necessary, use custom routes for your subnet to override the system route. This method forces the network traffic to go through a network appliance for security control purpose.

### NS-4: Deploy intrusion detection/intrusion prevention systems (IDS/IPS)

**Security Principle**. Use network intrusion detection and intrusion prevention systems (IDS/IPS) to inspect the network and payload traffic to or from your workload. Ensure that IDS/IPS is always tuned to provide high-quality alerts to your solution.

### NS-5: Deploy DDOS protection

**Security Principle**. Deploy distributed denial of service (DDoS) protection to protect your network and applications from attacks.

### NS-6: Deploy web application firewall

**Security Principle**. Deploy a web application firewall (WAF) and configure the appropriate rules to protect your web applications and APIs from application-specific attacks.

### NS-7: Simplify network security configuration

**Security Principle**. When managing a complex network environment, use tools to simplify, centralize, and enhance the network security management.

### NS-8: Detect and disable insecure services and protocols

**Security Principle**. Detect and disable insecure services and protocols at the OS, application, or software package layer. Deploy compensating controls if disabling insecure services and protocols aren't possible.

### NS-9: Connect on-premises or cloud network privately

**Security Principle**. Use private connections for secure communication between different networks, such as cloud service provider datacenters and on-premises infrastructure in a colocation environment.

### NS-10: Ensure Domain Name System (DNS) security

**Security Principle**. Ensure that Domain Name System (DNS) security configuration protects against known risks.

## Using Microsoft Defender for Cloud for regulatory compliance

Microsoft Defender for Cloud helps streamline the process for meeting regulatory compliance requirements, using the regulatory compliance dashboard.

The regulatory compliance dashboard shows the status of all the assessments within your environment for your chosen standards and regulations. As you act on the recommendations and reduce risk factors in your environment, your compliance posture improves.

### Regulatory compliance dashboard

:::image type="content" source="../media/compliance-dashboard-799a65d6.png" alt-text="Screenshot of the Microsoft Defender for Cloud regulatory compliance dashboard." lightbox="../media/compliance-dashboard-799a65d6.png":::

The dashboard shows an overview of your compliance status with the set of supported compliance regulations. You can view the overall compliance score, and the number of passing vs. failing assessments associated with each standard.

### Compliance controls

:::image type="content" source="../media/compliance-drilldown-a608a403.png" alt-text="Screenshot of the regulatory compliance dashboard with drilldown to compliance controls.":::

1. Subscriptions the standard is applied on.
1. List of all controls for that standard.
1. View the details of passing and failing assessments associated with that control.
1. Number of affected resources.
1. Severity of the alert. 

Some controls are grayed out. These controls don't have any Microsoft Defender for Cloud assessments associated with them. Check their requirements and assess them in your environment. Some of these controls might be process-related and not technical.

### Exploring the details of compliance with a specific standard

To generate a PDF report with a summary of your current compliance status for a particular standard, select Download report.

:::image type="content" source="../media/download-report-e839f272.png" alt-text="Screenshot of the download regulatory compliance report." lightbox="../media/download-report-e839f272.png":::

The report provides a high-level summary of your compliance status for the selected standard based on Microsoft Defender for Cloud assessments data. The report is organized according to the controls of that standard. The report can be shared with relevant stakeholders and might provide evidence to internal and external auditors.

## Alerts in Microsoft Defender for Cloud

Microsoft Defender for Cloud automatically collects, analyzes, and integrates log data from your Azure resources. A list of prioritized security alerts is shown in Microsoft Defender for Cloud along with the information you need to quickly investigate the problem and steps to take to remediate an attack.

### Manage your security alerts

The Microsoft Defender for Cloud overview page shows the Security alerts tile at the top of the page, and as a link from the sidebar.

:::image type="content" source="../media/overview-page-alerts-links-a54c327f.png" alt-text="Screenshot of the Microsoft Defender for Cloud overview page and the Security alerts tile." lightbox="../media/overview-page-alerts-links-a54c327f.png":::

The security alerts page shows the active alerts. You can sort the list by Severity, Alert title, Affected resource, Activity start time. MITRE ATTACK tactics, and status.

:::image type="content" source="../media/alerts-page-9ba7adc1.png" alt-text="Screenshot of the Active security alerts list.":::

To filter the alerts list, select any of the relevant filters. 

:::image type="content" source="../media/alerts-adding-filters-large-356ce4df.png" alt-text="Screenshot of adding filters to the alerts view.":::


The list updates according to the filtering options. Filtering can be helpful. For example, you might want to address security alerts that occurred in the last 24 hours because you're investigating a potential breach in the system.

### Respond to security alerts

From the Security alerts list, select an alert. A side pane opens and shows a description of the alert and all the affected resources.

:::image type="content" source="../media/alerts-details-pane-e9de3d97.png" alt-text="Screenshot of the detailed security alert page.":::

View full details displays further information.

:::image type="content" source="../media/alert-take-action-834bdd16.png" alt-text="Screenshot of the full details view of a security alert pane.":::

The left pane of the security alert page shows high-level information regarding the security alert: title, severity, status, activity time, description of the suspicious activity, and the affected resource. Use the resource tags to determine the organizational context of the resource.

The right pane includes the Alert details tab containing further details of the alert to help you investigate the issue: IP addresses, files, processes, and more.

Also in the right pane is the Take action tab. Use this tab to take further actions regarding the security alert. Actions such as:

- **Mitigate the threat**. Provides manual remediation steps for this security alert.
- **Prevent future attacks**. Provides security recommendations to help reduce the attack surface, increase security posture, and thus prevent future attacks.
- **Trigger automated response**. Provides the option to trigger a logic app as a response to this security alert.
- **Suppress similar alerts**. Provides the option to suppress future alerts with similar characteristics if the alert isn’t relevant for your organization.