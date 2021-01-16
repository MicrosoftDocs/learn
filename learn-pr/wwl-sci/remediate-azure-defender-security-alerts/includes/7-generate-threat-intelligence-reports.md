Security Center threat protection works by monitoring security information from your Azure resources, the network, and connected partner solutions. It analyzes this information, often correlating information from multiple sources, to identify threats.

When Security Center identifies a threat, it triggers a security alert containing detailed information regarding the event, including suggestions for remediation. Security Center provides threat intelligence reports containing information about detected threats to help incident response teams investigate and remediate threats. The report includes information such as:

- Attacker’s identity or associations (if this information is available)

- Attackers’ objectives

- Current and historical attack campaigns (if this information is available)

- Attackers’ tactics, tools, and procedures

- Associated indicators of compromise (IoC) such as URLs and file hashes

- Victimology, which is the industry and geographic prevalence to assist you in determining if your Azure resources are at risk

- Mitigation and remediation information

Security Center has three types of threat reports, which can vary according to the attack. The reports available are:

- Activity Group Report: provides deep dives into attackers, their objectives, and tactics.

- Campaign Report: focuses on details of specific attack campaigns.

- Threat Summary Report: covers all of the items in the previous two reports.

This type of information is useful during the incident response process, where there's an ongoing investigation to understand the source of the attack, the attacker’s motivations, and what to do to mitigate this issue in the future.

## To access the threat intelligence report

To generate the report:

From Security Center's sidebar, open the Security alerts page.

Select an alert. The alerts details page opens with more details about the alert. Below is the Ransomware indicators detected alert details page.

![ransomware indicators detected link to threat intel report](../media/ransomware-indicators-detected-link-to-threat-intel-report.png)

Select the link to the report, and a PDF will open in your default browser.

