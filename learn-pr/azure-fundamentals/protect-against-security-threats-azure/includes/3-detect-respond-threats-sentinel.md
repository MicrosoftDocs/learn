Security management on a large scale can benefit from a dedicated security information and event management (SIEM) system. A SIEM system aggregates security data from many different sources (as long as those sources support an open-standard logging format). It also provides capabilities for threat detection and response.

[Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/?azure-portal=true) is Microsoft's cloud-based SIEM system. It uses intelligent security analytics and threat analysis.

## Azure Sentinel capabilities

Azure Sentinel enables you to:

+ **Collect cloud data at scale**

    Collect data across all users, devices, applications, and infrastructure, both on-premises and from multiple clouds.
+ **Detect previously undetected threats**

    Minimize false positives by using Microsoft's comprehensive analytics and threat intelligence.
+ **Investigate threats with artificial intelligence** 

    Examine suspicious activities at scale, tapping into years of cybersecurity experience from Microsoft.
+ **Respond to incidents rapidly**

    Utilize built-in orchestration and automation of common tasks.

## Connect your data sources

Tailwind Traders decides to explore the capabilities of Azure Sentinel. First, the company identifies and connects its data sources.

Azure Sentinel supports a number of data sources, which it can analyze for security events. These connections are handled by built-in connectors or industry-standard log formats and APIs.

+ **Connect Microsoft solutions**

    Connectors provide real-time integration for services like Microsoft Threat Protection solutions, Microsoft 365 sources (including Office 365), Azure Active Directory, and Windows Defender Firewall.
+ **Connect other services and solutions**

    Connectors are available for common non-Microsoft services and solutions, including AWS CloudTrail, Citrix Analytics (Security), Sophos XG Firewall, VMware Carbon Black Cloud, and Okta SSO.
+ **Connect industry-standard data sources**

    Azure Sentinel supports data from other sources that use the Common Event Format (CEF) messaging standard, Syslog, or REST API.

## Detect threats

Tailwind Traders needs to be notified when something suspicious occurs. It decides to use both built-in analytics and custom rules to detect threats.

**Built in analytics** use templates designed by Microsoft's team of security experts and analysts based on known threats, common attack vectors, and escalation chains for suspicious activity. These templates can be customized and search across the environment for any activity that looks suspicious. Some templates use machine learning behavioral analytics that are based on Microsoft proprietary algorithms.

**Custom analytics** are rules that you create to search for specific criteria within your environment. You can preview the number of results that the query would generate (based on past log events) and set a schedule for the query to run. You can also set an alert threshold.

## Investigate and respond

When Azure Sentinel detects suspicious events, Tailwind Traders can investigate specific alerts or *incidents* (a group of related alerts). With the investigation graph, the company can review information from entities directly connected to the alert and see common exploration queries to help guide the investigation.

Here's an example that shows what an investigation graph looks like in Azure Sentinel:

:::image type="content" source="../media/3-investigate-incidents.png" alt-text="An example incident investigation graph in Azure Sentinel." lightbox="../media/3-investigate-incidents.png":::

The company will also use [Azure Monitor Workbooks](https://docs.microsoft.com/azure/azure-monitor/platform/workbooks-overview/?azure-portal=true) to automate responses to threats. For example, it can set an alert that looks for malicious IP addresses that access the network and create a workbook that does the following steps:

1. When the alert is triggered, open a ticket in the IT ticketing system.
1. Send a message to the security operations channel in Microsoft Teams or Slack to make sure the security analysts are aware of the incident.
1. Send all of the information in the alert to the senior network admin and to the security admin. The email message includes two user option buttons: **Block** or **Ignore**.

When an admin chooses **Block**, the IP address is blocked in the firewall and the user is disabled in Azure Active Directory. When an admin chooses **Ignore**, the alert is closed in Azure Sentinel and the incident is closed in the IT ticketing system.

The workbook continues to run after it receives a response from the admins.

Workbooks can be run manually or automatically when a rule triggers an alert.
