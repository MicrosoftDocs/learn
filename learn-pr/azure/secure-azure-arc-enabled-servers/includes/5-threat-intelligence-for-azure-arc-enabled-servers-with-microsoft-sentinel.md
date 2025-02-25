Tailwind Traders’ SOC (Security Operations Center) Analysts are struggling to assess their environment with its various SIEM and SOAR solutions. In this unit, you learn how Azure Arc-enabled servers work together with Microsoft Sentinel, a SIEM and SOAR solution that keeps up with hybrid and multicloud environment.

## Overview of Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native, **security information and event management (SIEM)** and **security orchestration, automation, and response (SOAR)** solution. Microsoft Sentinel delivers threat intelligence across the enterprise, providing a single solution for attack detection, proactive hunting, and threat response.

Microsoft Sentinel is your birds-eye view across the enterprise for alleviating the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

- **Collect data at cloud scale** across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- **Detect previously undetected threats** and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- **Investigate threats with artificial intelligence** and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
- **Respond to incidents rapidly** with built-in orchestration and automation of common tasks.

## Connect data

To onboard Microsoft Sentinel, you first need to connect to your security sources.

Microsoft Sentinel comes with several connectors for Microsoft solutions, available out of the box and which provide real-time integration. Microsoft Sentinel's out-of-the-box connectors include Microsoft 365 sources, Microsoft Entra ID, Microsoft Defender for Identity, and Microsoft Defender for Cloud Apps. In addition, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions.  

Relevant data connectors for Azure Arc-enabled servers might include Security Events via Legacy Agent, Windows Security Events via AMA, or Syslog.

## Workbooks and analytics

After you connect your data sources to Microsoft Sentinel, you can monitor the data using the Microsoft Sentinel integration with Azure Monitor workbooks, which provides versatility in creating custom workbooks. Microsoft Sentinel also comes with built-in workbook templates to allow you to quickly gain insights across your data as soon as you connect to a data source.

To help you minimize the number of alerts you must investigate, Microsoft Sentinel uses analytics to correlate alerts into incidents. Incidents are groups of related alerts that together create an actionable possible threat that you can investigate and resolve. Use the built-in correlation rules as-is, or use them as a starting point to build your own. Microsoft Sentinel also provides machine learning rules to map your network behavior and then look for anomalies across your resources.

## Security automation and orchestration

You can automate common tasks and simplify security orchestration with playbooks that integrate with Azure services and your existing tools.

Using Azure Logic Apps, Microsoft Sentinel's automation and orchestration solution is extensible, scalable, and modernized. To build playbooks with Azure Logic Apps, you can choose from a growing gallery of built-in playbooks. These include 200+ connectors for services such as Azure Functions. The connectors allow you to apply any custom logic in code, ServiceNow, Jira, Zendesk, HTTP requests, Microsoft Teams, Slack, Windows Defender ATP, and Defender for Cloud Apps.

## Hunting and notebooks

Use Microsoft Sentinel's powerful hunting search-and-query tools, based on the MITRE framework, to proactively hunt for security threats across your organization’s data sources before an alert is triggered. After you discover which hunting query provides high-value insights into attacks, you can also create custom detection rules based on your query and surface those insights as alerts to your security-incident responders. While hunting, you can create bookmarks for interesting events, which allows you to return to them later, share them with others, and group them with other correlating events to create a compelling incident for investigation.

Microsoft Sentinel supports Jupyter notebooks in Azure Machine Learning workspaces, including full libraries for machine learning, visualization, and data analysis. You can use notebooks in Microsoft Sentinel to extend the scope of what you can do with Microsoft Sentinel data. For example, you can perform analytics that aren't built into Microsoft Sentinel, such as some Python machine learning features; create data visualizations that aren't built into Microsoft Sentinel, such as custom timelines and process trees; or integrate data sources outside of Microsoft Sentinel, such as an on-premises dataset.
