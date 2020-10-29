## What is Azure Sentinel Analytics?

<!--Marjan, as per the standards, all units should start with a topic sentence that somehow ties in to the scenario and then we have the first heading. We cannot start with a heading. Can you please provide the intro topic sentence for all units? Thanks-->

After completing this unit, you can explain the importance of Azure Sentinel Analytics 

<!--Marjan, we typically use this type of language only in the introduction pages where we list objectives. Can we delete this lead in and list and start with "You can use Azure Sentinel Analytics to detect, investigate, and remediate threats? We can instead maybe use this info to create the topic sentence as follows:

Azure Sentinel Analytics provides several functionalities that you can use to implement security for the data and resources at Contoso. By implementing analytics rules and using the features available in the Analytic home page, you can.....   " something on those lines-->

- Understand the importance of Analytics for security
- Understand Analytics rules
- Explore Analytic home page <!--Marjan, is nalytic singular or plural in the UI? We seem to be using plural in many places and we need to be consistent with the UI.-->

You can use Azure Sentinel Analytics to detect, investigate, and remediate cyber security threats. With Azure Sentinel Analytics, you can set up analytics rules and queries to detect issues in your environment. <!--Marjan, please check edits. I made aanalytic plural before rules and also added "cyber security"-->

You can analyze both real-time and historical data collected from your workstations, servers, networking devices, firewalls, intrusion prevention, sensors, and so on. Azure Sentinel Analytics analyses data from various sources to identify correlations and anomalies. <!--Marjan, please check edits. I changed the last sentence to active voice. -->

With analytics you can trigger alert, based of the techniques that are used by known malicious actors.
With analytics in place, you want to make sure the right people are being alerted, at the right level. 

## Why use Analytics for Security?

Azure Sentinel Analytics <!-- Marjan, I made Analytics upper case as it is other instances. Please confirm the casing.--> play an important part in the overall detection of a security threat. <!--Marjan, this sentence implies that several other products help in detecting security threats of which Analytics is just one. If that is the case, can we add some text to clarify that. Such as "Although some of the other products that Contoso has implemented such as .... can help you identify threats, Azure Sentinel plays an ....? Please check if that makes sense.--> With the proper analytics rule, you can get insights into where an attack originated from, what resources were compromised, the potential data lost, along with the timeline for the incident.

Common security analytics use cases include:

- Identification of compromised accounts
- User behavior analysis to detect potentially suspicious patterns
- Network traffic analysis to locate trends indicating potential attacks
- Detection of data exfiltration by attackers
- Detection of insider threats
- Investigation of incidents
- Threat hunting

You might not be able to detect some of the threats by using conventional protection tools, such as firewalls or antimalware solutions. Certain threats can go undetected for months. Combining data gathered by multiple tools and products <!--Marjan, I changed components to "tools and products"--> with the power of threat intelligence can help you to detect, analyze, and mitigate insider threats.

You can also use analytics to create custom alerts that use indicators of attack. These indicators can identify potential attacks in execution in real time. <!--Marjan, generally it si recommended to avoid execute/execution. Can we change this to "attacks that are in progress in real time"?-->
Analytics will help the Contoso SecOps team to improve the efficiency of their complex investigations and faster detect threats faster. <!--MArjan, I tweaked thislast sentence a bit. Please check if it is still accurate.-->

## Exploring the Analytics home page

You can create analytics rules from the **Analytics** home page, that you can select from the left-hand navigation bar. <!--Marjan, this sentence needs to be tweaked. What can be selected from the left-hand navigations bar? Analytics home page or the create rule option? Can we provide the name of the option ? Is it a bar or a pane, a section of the window with several options?  Also, we cannot use "left-hand" for inclusivity reasons. Can we change to ""from the navigation pane on the left". It would help if I saw a screenshot, I can then reword accordingly. Thanks-->

Image – Analytics home page

The **Analytics** home page has three main parts:

- The header bar contains information on the number of the rules that are currently in use.
- The list of rules and templates contains all the rule templates that Microsoft has preloaded from the Azure Sentinel GitHub repository.
- The detailed view pane contains additional information that explains each template and rule that you can use in detection.

## Filter the rule templates

Currently, Microsoft has preloaded over 150 template rules from the Azure Sentinel GitHub repository. To manage <!--Marjan, are they managin the templates using the filter or just searching? Manage implies they can also delte add or make other modifications. Just double-checking if that is the intention here.-->these templates and to access the appropriate rule, you need to apply filters. For example, you might want to see only template rules that detect a high severity level of threats or rules from specific data sources.

To use filters, select the blue buttons, <!--Marjan, mentioning the color is non-inclusive. Visually impaired learners will not be able to see the color or see the buttons. We need to provide a better description for the buttons. Do they have a name that appears when you hover over them? And where are they located? Is it the Analytics home page? Are they on the tool bar, the navigation pane?--> and then select the filters you want to use.

The **Analytics** home page provides the following filters: <!--Marjan, I changed the lead in but please review if it is the Analytics home page or some other page that displays these filters?-->

- **Severity –** Use to filter the rules by levels of severity. <!--MArjan, Does the UI have the hyphen also after the filter name or should it be just "Severity"? Same question for all these options.>
- **Rule Type –** Use to filter the rules by type. There are currently four types of rules: Scheduled, Fusion, Microsoft Security, and ML Behavior Analytics.

- **Tactics –** Use to filter the rules based on 14 specific techniques and methodologies in MITRE ATT's CK model. <!-- Marjan I edited the & to an apostrophe. Is that what you intended? Also, please provide the expansion for Mitre ATT CK-->

- **Data Sources –** Use to filter the rules by the data source connector that generates the alert.
