The process of managing security on a large scale can be helped by using a dedicated security information and event management system (SIEM). A SIEM can aggregate security data from many different sources, as long as those sources support an open standard logging format, and provides additional capabilities for threat detection and response.

[Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/?azure-portal=true) is Microsoft's cloud-based SIEM, powered by Microsoft's intelligent security analytics and threat analysis.

## Azure Sentinel capabilities

Azure Sentinel enables you to:
+ **Collect cloud data at scale** - across all users, devices, application and infrastructure, both on-premises and in multiple clouds.
+ **Detect previously undetected threats** - and minimize false positives using Microsoft's comprehensive analytics and unparalled threat intelligence.
+ **Investigate threats with artificial intelligence** - and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
+ **Respond to incidents rapidly** - with built-in orchestration and automation of common tasks.

<div style="background:yellow;">
TODO: Maybe video similar to this script? https://www.youtube.com/watch?v=vPuzFwOqUyU&feature=emb_logo 
</div>

### Connect your data sources
Tailwind Traders decides to explore the capabilities of Azure Sentinel. First, they identify and connect their data sources.

Azure Sentinel supports a number of different data sources, which it can analyze for security event related information. These connections are handled by built-in connectors or industry-standard log formats and APIs.
+ **Connect Microsoft solutions** - These connectors provide real-time integration for services like Microsoft Threat Protection solutions, Microsoft 365 sources (including Office 365), Azure Active Directory, Windows Defender Firewall and more.
+ **Connect other services and solutions** - Connectors are available for a range of common non-Microsoft services and solutions, including AWS CloudTrail, Citrix Analytics (Security), Sophos XG Firewall, VMWare Carbon Black Cloud, Okta SSO and more. For more information on available connectors, visit [Connect data sources](https://docs.microsoft.com/azure/sentinel/connect-data-sources) 
+ **Connect industry-standard data sources** - Azure Sentinel also supports data from other sources that use the Common Event Format (CEF) messaging standard, Syslog or REST API.  

### Detect threats
Next, Tailwind Traders needs to be notified when something suspicious occurs. They decide to use both built-in analystics and custom rules, to detect threats.

**Built in analytics** use templates designed by Microsoft's team of security experts and analysts based on known threats, common attack vectors, and suspicious activity escalation chains. These templates can be customized and will search across the environment for any activity that looks suspicious. to help you create threat detection rules, customized for your environment. There are also templates that use machine learning behavioral analytics, based on Microsoft's proprietary algorithms.

**Custom analytics** are rules you can create to search for specific criteria in your environment. You can preview the number of results the query would generate (based on past log events) and set a schedule for the query to run, as well as an alert threshold.  

### Investigate and respond
Finally, when Azure Sentinel has detected suspicious events, Tailwind Traders can investigate specific alerts or *incidents* (a group of related alerts). With the investigation graph, they can review information from entities directly connected to the alert, and see common exploration queries to help guide their investigation.
<div style="background:yellow;">
TODO: Maybe graphics similar to https://docs.microsoft.com/azure/sentinel/tutorial-investigate-cases#use-the-investigation-graph-to-deep-dive
</div>

They will also use Workbooks to automate responses to threats. For example, they can set an alert that looks for malicious IP addresses accessing the network and create a workbook that does the following:

1. When the alert is triggered, open a ticket in the IT ticketing system.
1. Send a message to the security operations channel in Microsoft Teams or Slack to make sure the security analysts are aware of the incident.
1. Send all of the information in the alert to the senior network admin and the security admin. The email message also includes two user option buttons - Block or Ignore.
1. The workbook continues to run after a response is received from the admins.
1. If the admins choose Block, the IP address is blocked in the firewall and the user is disabled in Azure Active Directory.
1. If the admins choose Ignore, the alert is closed in Azure Sentinel and the incident is closed in the IT ticketing system.  
 
Workbooks can be run manually, or automatically when a related rule triggers an alert. 














