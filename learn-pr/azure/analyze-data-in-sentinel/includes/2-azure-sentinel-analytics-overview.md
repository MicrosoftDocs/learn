## What is Azure Sentinel Analytics?

After completing this unit, you&#39;ll be able to explain the importance of Azure Sentinel Analytics

- Understand the importance of Analytics for security
- Understand Analytic rules
- Explore Analytic home page

Azure Sentinel Analytics, helps you to detect, investigate, and remediate threats. With Azure Sentinel Analytics, you can set up analytic rules and queries to detect issues in your environment.

You can analyze both real-time and historical data collected from your workstations, servers, networking devices, firewalls, intrusion preventions, sensors, etc. Data from various sources is analyzed to look for correlations and anomalies.

With analytics you can trigger alert, based of the techniques that are used by known malicious actors.

## WHY USE ANALYTICS FOR SECURITY?

Azure Sentinel analytics play import part in the overall detection of the security threat. With the proper analytic rule, you can get insights into where an attack originated from, what resources were compromised, potential data lost, along with the timeline for the incident.

The following include common security analytics use cases:

- Identifying compromised accounts
- User behavior analyzes to detect potentially suspicious patterns
- Network traffic analyze to locate trends indicating potential attacks
- Detecting data exfiltration by attackers
- Detecting insider threats
- Investigating incidents
- Threat hunting

Some of the threats cannot be detected using conventional protection tools, such as firewalls or antimalware solutions. Certain threats can go undetected for months. Combining data, gathered by multiple components, with the power of threat intelligence can help you to detect, analyze, and mitigate insider threats.

You can also use analytics to create custom alerts that use indicators of attack that can identify potential attack in execution in real time.

## Exploring the Analytics home page

You can start creation of the analytics rules from the **Analytics** home page, that you can select from the left-hand navigation bar.

![](RackMultipart20201021-4-1topqyg_html_1d7f794390ac578a.png)

Image – Analytics home page

Analytics home page is arranged into three main parts:

- The header bar – contains information of the number of the rules that are currently in use
- The listing of rules and templates – contains all the rule templates that Microsoft has pre-loaded from Azure Sentinel&#39;s GitHub repository
- The detailed view pane – contains additional information that explain the template and the rule that is used in detection

## Filter the Rule templates

Currently Microsoft has pre-loaded more than 150 template rules from Azure Sentinel GitHub repository. To manage these templates and get to the right rule, you need to apply filters. For example, you might want to see only template rules that detect high severity level of threats, or rules from specific Data Sources.

To use filters, select the blue buttons, and then select the filters you want to use.

![](RackMultipart20201021-4-1topqyg_html_6e19f2d0403791d5.png)

Here are the filters and what you would use them for:

- **Severity –** Lets you filter rules by levels of severity
- **Rule Type –** There are currently four types of rules: Scheduled, Fusion, Microsoft Security, ML Behavior Analytics

- **Tactics –** Lets you filter the rules based on 14 specific techniques and methodologies in MITRE ATT&amp;CK model

- **Data Sources –** Filter by the data source connector that generate the alert
