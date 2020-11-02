Azure Sentinel Analytics, helps you to detect, investigate, and remediate cyber security threats. With Azure Sentinel Analytics, you can set up analytics rules and queries to detect issues in your environment.

## What is Azure Sentinel Analytics

Azure Sentinel Analytics provides several functionalities that you can use to implement security for the data and resources at Contoso.

You can analyze both real-time and historical data collected from your workstations, servers, networking devices, firewalls, intrusion prevention, sensors, and so on. Azure Sentinel Analytics analyses data from various sources to identify correlations and anomalies.

With analytics rules you can trigger alert, based of the techniques that are used by known malicious actors.
With analytics rules in place, you want to make sure the right people are being alerted, at the right level.

## Why use analytics rules for Security

Although some of the other products that Contoso has implemented can help you identify threats, Azure Sentinel Analytics plays import part in the overall detection of the security threat by correlating and matching the signals that impact the presence of a cyber security threat. With the proper analytics rule, you can get insights into where an attack originated from, what resources were compromised, potential data lost, along with the timeline for the incident.

The following include common security analytics rules use cases:

- Identifying compromised accounts
- User behavior analyzes to detect potentially suspicious patterns
- Network traffic analyzes to locate trends indicating potential attacks
- Detecting data exfiltration by attackers
- Detecting insider threats
- Investigating incidents
- Threat hunting

You might not be able to some of the threats by using conventional protection tools, such as firewalls or antimalware solutions. Certain threats can go undetected for months. Combining data, gathered by multiple tools and components, with the power of threat intelligence can help you to detect, analyze, and mitigate insider threats.

You can also use analytics rules to create custom alerts that use indicators of attack. These indicators can identify potential attack that are in progress in real time.
Analytics will help the Contoso SecOps team to improve the efficiency of their complex investigation and detect threats faster.

## Exploring the Analytics home page

You can start creation of the analytics rules from the **Analytics** home page. You can access **Analytics** page in Azure Sentinel from the navigation pane on the left.

![Screenshot of the Analytics home page](../media/02-Analytics-page.png)

Analytics home page is arranged into three main parts:

- The header bar – contains information of the number of the rules that are currently in use
- The listing of rules and templates – contains all the rule templates that Microsoft has pre-loaded from Azure Sentinel&#39;s GitHub repository
- The detailed view pane – contains additional information that explains the template and the rule that is used in detection

## Filter the Rule templates

Currently Microsoft has pre-loaded more than 150 template rules from Azure Sentinel GitHub repository. To search these templates and get to the right rule, you need to apply filters. For example, you might want to see only template rules that detect high severity level of threats, or rules from specific Data Sources.

To use filters, in the header bar select the filters you want to use.

![Screenshot of the Analytics home page](../media/02-Filter-The-Rule-Templates.PNG)

The **Analytics** home page provides the following filters:

- **Severity –** Use to filter the rules by levels of severity
- **Rule Type –** There are currently four types of rules: Scheduled, Fusion, Microsoft Security, Machine Learning Behavior Analytics
- **Tactics –** Use to filter the rules based on 14 specific techniques and methodologies in MITRE ATT's CK model
- **Data Sources –** Filter by the data source connector that generates the alert

> [!NOTE]

> MITRE ATT&amp;CK is a globally accessible knowledge base of adversary tactics and techniques based on real-world observations. The ATT&amp;CK knowledge base is used as a foundation for the development of specific threat models and methodologies in the private sector, in government, and in the cyber security product and service community.
