## What is Azure Sentinel Analytics?

After completing this unit, you can explain the importance of Azure Sentinel Analytics

- Understand the importance of analytics rules for security
- Understand analytics rules
- Explore Analytics home page

Azure Sentinel Analytics, helps you to detect, investigate, and remediate threats. With Azure Sentinel Analytics, you can set up analytics rules and queries to detect issues in your environment.

You can analyze both real-time and historical data collected from your workstations, servers, networking devices, firewalls, intrusion prevention, sensors, and so on. Data from various sources is analyzed to look for correlations and anomalies.

With analytics rules you can trigger alert, based of the techniques that are used by known malicious actors.
With analytics rules in place, you want to make sure the right people are being alerted, at the right level. 

## Why use analytics rules for Security?

Azure Sentinel analytics play import part in the overall detection of the security threat. With the proper analytics rule, you can get insights into where an attack originated from, what resources were compromised, potential data lost, along with the timeline for the incident.

The following include common security analytics rules use cases:

- Identifying compromised accounts
- User behavior analyzes to detect potentially suspicious patterns
- Network traffic analyzes to locate trends indicating potential attacks
- Detecting data exfiltration by attackers
- Detecting insider threats
- Investigating incidents
- Threat hunting

Some of the threats cannot be detected using conventional protection tools, such as firewalls or antimalware solutions. Certain threats can go undetected for months. Combining data, gathered by multiple components, with the power of threat intelligence can help you to detect, analyze, and mitigate insider threats.

You can also use analytics rules to create custom alerts that use indicators of attack that can identify potential attack in execution in real time.
Analytics rules will help Contoso to improve the operation of their SecOps team in complex investigation and faster detection of the threats. 

## Exploring the Analytics home page

You can start creation of the analytics rules from the **Analytics** home page, that you can select from the left-hand navigation bar.

Image – Analytics home page

Analytics home page is arranged into three main parts:

- The header bar – contains information of the number of the rules that are currently in use
- The listing of rules and templates – contains all the rule templates that Microsoft has pre-loaded from Azure Sentinel&#39;s GitHub repository
- The detailed view pane – contains additional information that explains the template and the rule that is used in detection

## Filter the Rule templates

Currently Microsoft has pre-loaded more than 150 template rules from Azure Sentinel GitHub repository. To manage these templates and get to the right rule, you need to apply filters. For example, you might want to see only template rules that detect high severity level of threats, or rules from specific Data Sources.

To use filters, select the blue buttons, and then select the filters you want to use.

Here are the filters and what you would use them for:

- **Severity –** Lets you filter rules by levels of severity
- **Rule Type –** There are currently four types of rules: Scheduled, Fusion, Microsoft Security, Machine Learning Behavior Analytics

- **Tactics –** Lets you filter the rules based on 14 specific techniques and methodologies in MITRE ATT&amp;CK model

- **Data Sources –** Filter by the data source connector that generates the alert
