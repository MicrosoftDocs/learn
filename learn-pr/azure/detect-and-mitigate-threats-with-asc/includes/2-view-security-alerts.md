Azure Security Center automatically collects, analyzes, and integrates log data from several sources to identify credible threats to your workloads. Data from your Azure resources, the network, and connected partner solutions (like firewalls) is correlated and processed with machine learning and advanced security analytics to reduce false positives.

This aggregation allows Security Center to detect threats such as:

- Compromised VMs communicating with known malicious IP addresses.
- Advanced malware detected by Windows error reporting.
- Brute-force attacks against VMs.
- Security alerts from integrated partner security solutions, such as anti-malware or web application firewalls.

When a threat like this is detected, Security Center will generate a _security alert_.

## What is a security alert?

Alerts are the notifications that Security Center generates when it detects threats on your resources. Security Center prioritizes and lists the alerts, along with the information needed for you to investigate the problem quickly. Security Center also provides recommendations for how you can remediate an attack.

### Alert types

Azure Security Center provides a variety of alerts that align with the stages of the kill chain. The kill chain consists of three phases: **Target and Attack**, **Install and Exploit**, and **Post Breach**. Different types of attacks are associated with each stage, and they target various subsystems. For example, the target and attack phase include inbound RDP/SSH attacks and intrusion detection.

![Screenshot that depicts the three phases of the kill chain and that lists the types of attacks associated with each phase.](../media/M3-ASC-Alerts1.png)

The alerts contain valuable information about what triggered the alert, the resources targeted, and the source of the attack. The information included in an alert varies based on the type of analytics used to detect the threat. Incidents might also contain additional contextual information that might be useful during the investigation of a threat. To address attacks during these stages, Security Center has categories of alerts:

- Virtual machine behavioral analysis
- Network analysis
- SQL database and SQL Data Warehouse analysis
- Contextual information

These alerts are triggered when either a threat or suspicious activity takes place.

## Viewing security alerts

You can view collected security alerts directly in Azure Security Center on the **Overview** page, through command-line tools, or using the REST API. The portal is the easiest way to view alerts - it displays a graph of your current alerts, colored by the severity level (high, medium, or low).

![Screenshot of the threat-protection area of Security Center](../media/6-security-center-dashboard-alert.png)

Selecting the **Threat protection** tile presents more detailed information, as shown in the following image:

![Screenshot of the Security alerts panel](../media/6-security-center-manage-alerts.png)

You can filter alerts based on the date, state, and severity. Filtering alerts might be useful for scenarios where you need to narrow the scope of the security alerts. For example, you might want to address security alerts that occurred in the last 24 hours if you’re investigating a potential breach in the system.

If you have a lot of alerts, you can select **Filter** on the **Security alerts** page. The **Filter** area opens on the side, and you can choose the date, state, and severity values you want to see.

![Screenshot that depicts The Filter area on the Security alerts page.](../media/M3-ASC-Alerts2.png)
