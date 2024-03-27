Threat analytics is a threat intelligence solution from expert Microsoft security researchers. It's designed to assist security teams to be as efficient as possible while facing emerging threats, such as:

- Active threat actors and their campaigns
- Popular and new attack techniques
- Critical vulnerabilities
- Common attack surfaces
- Prevalent malware

Watch this short video to learn more about how threat analytics can help you track the latest threats and stop them.

>[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RWwJfU?rel=0 ]

You can access threat analytics either from the upper left-hand side of Microsoft 365 security portal's navigation bar, or from a dedicated dashboard card that shows the top threats to your org, both in terms of impact, and in terms of exposure.

:::image type="content" source="../media/ta-dashboard-mtp.png" alt-text="Screenshot of the Threat analytics dashboard.":::

High impact threats have the greatest potential to cause harm, while high exposure threats are the ones that your assets are most vulnerable to. Getting visibility on active or ongoing campaigns and knowing what to do through threat analytics can help equip your security operations team with informed decisions.

With more sophisticated adversaries and new threats emerging frequently and prevalently, it's critical to be able to quickly:

- Identify and react to emerging threats
- Learn if you're currently under attack
- Assess the impact of the threat to your assets
- Review your resilience against or exposure to the threats
- Identify the mitigation, recovery, or prevention actions you can take to stop or contain the threats

Each report provides an analysis of a tracked threat and extensive guidance on how to defend against that threat. It also incorporates data from your network, indicating whether the threat is active and if you have applicable protections in place.

### View the threat analytics dashboard
The threat analytics dashboard highlights the reports that are most relevant to your organization. It summarizes the threats in the following sections:

- Latest threats—lists the most recently published or updated threat reports, along with the number of active and resolved alerts.
- High-impact threats—lists the threats that have the highest impact to your organization. This section lists threats with the highest number of active and resolved alerts first.
- Highest exposure—lists threats with the highest exposure levels first. the exposure level of a threat is calculated using two pieces of information: how severe the vulnerabilities associated with the threat are, and how many devices in your organization could be exploited by those vulnerabilities.


Selecting a threat from the dashboard views the report for that threat.

View a threat analytics report. Each threat analytics report provides information in several sections:

- Overview
- Analyst report
- Related incidents
- Impacted assets
- Prevented email attempts
- Exposure & mitigations


### Overview: Quickly understand the threat, assess its impact, and review defenses
The Overview section provides a preview of the detailed analyst report. It also provides charts that highlight the impact of the threat to your organization, and your exposure through misconfigured and unpatched devices.



### Assess impact on your organization
Each report includes charts designed to provide information about the organizational impact of a threat:

- Related incidents—provides an overview of the impact of the tracked threat to your organization with the number of active alerts and the number of active incidents they're associated with and severity of active incidents
- Alerts over time—shows the number of related Active and Resolved alerts over time. The number of resolved alerts indicates how quickly your organization responds to alerts associated with a threat. Ideally, the chart should be showing alerts resolved within a few days.
- Impacted assets—shows the number of distinct devices and email accounts (mailboxes) that currently have at least one active alert associated with the tracked threat. Alerts are triggered for mailboxes that received threat emails. Review both org- and user-level policies for overrides that cause the delivery of threat emails.
- Prevented email attempts—shows the number of emails from the past seven days that were either blocked before delivery or delivered to the junk mail folder.

### Review security resilience and posture
Each report includes charts that provide an overview of how resilient your organization is against a given threat:

- Secure configuration status—shows the number of devices with misconfigured security settings. Apply the recommended security settings to help mitigate the threat. Devices are considered Secure if they've applied all the tracked settings.
- Vulnerability patching status—shows the number of vulnerable devices. Apply security updates or patches to address vulnerabilities exploited by the threat.


### View reports per threat tags
You can filter the threat report list and view the most relevant reports according to a specific threat tag (category) or a report type.

- Threat tags—assist you in viewing the most relevant reports according to a specific threat category. For example, all reports related to ransomware.
- Report types—assist you in viewing the most relevant reports according to a specific report type. For example, all reports that cover tools and techniques.
- Filters—assist you in efficiently reviewing the threat report list and filtering the view based on a specific threat tag or report type. For example, review all threat reports related to ransomware category, or threat reports that cover vulnerabilities.


### How does it work?
The Microsoft Threat Intelligence team has added threat tags to each threat report:

Four threat tags are now available:

- Ransomware
- Phishing
- Vulnerability
- Activity group

Threat tags are presented at the top of the threat analytics page. There are counters for the number of available reports under each tag.


### Analyst report: Get expert insight from Microsoft security researchers
In the Analyst report section, read through the detailed expert write-up. Most reports provide detailed descriptions of attack chains, including tactics and techniques mapped to the MITRE ATT&CK framework, exhaustive lists of recommendations, and powerful threat hunting guidance.


### Related incidents: View and manage related incidents
The Related incidents tab provides the list of all incidents related to the tracked threat. You can assign incidents or manage alerts linked to each incident.

### Impacted assets: Get list of impacted devices and mailboxes
An asset is considered impacted if it's affected by an active, unresolved alert. The Impacted assets tab lists the following types of impacted assets:

- Impacted devices—endpoints that have unresolved Microsoft Defender for Endpoint alerts. These alerts typically fire on sightings of known threat indicators and activities.

- Impacted mailboxes—mailboxes that have received email messages that have triggered Microsoft Defender for Office 365 alerts. While most messages that trigger alerts are typically blocked, user- or org-level policies can override filters.


### Prevented email attempts: View blocked or junked threat emails
Microsoft Defender for Office 365 typically blocks emails with known threat indicators, including malicious links or attachments. In some cases, proactive filtering mechanisms that check for suspicious content will instead send threat emails to the junk mail folder. In either case, the chances of the threat launching malware code on the device is reduced.

The Prevented email attempts tab lists all the emails that have either been blocked before delivery or sent to the junk mail folder by Microsoft Defender for Office 365.

### Exposure and mitigations: Review list of mitigations and the status of your devices
In the Exposure & mitigations section, review the list of specific actionable recommendations that can help you increase your organizational resilience against the threat. The list of tracked mitigations includes:

- Security updates—deployment of supported software security updates for vulnerabilities found on onboarded devices
- Supported security configurations
    - Cloud-delivered protection
    - Potentially unwanted application (PUA) protection
    - Real-time protection

Mitigation information in this section incorporates data from threat and vulnerability management, which also provides detailed drill-down information from various links in the report.

### Set up email notifications for report updates
You can set up email notifications that will send you updates on threat analytics reports.

To set up email notifications for threat analytics reports, perform the following steps:

1. Select Settings in the Microsoft Defender XDR sidebar. Select Microsoft Defender XDR from the list of settings.

2. Choose Email notifications > Threat analytics, and select the button, + Create a notification rule. A flyout will appear.

3. Follow the steps listed in the flyout. First, give your new rule a name. The description field is optional, but a name is required. You can toggle the rule on or off using the checkbox under the description field.

    > [!NOTE]
    > The name and description fields for a new notification rule only accept English letters and numbers. They don't accept spaces, dashes, underscores, or any other punctuation.


4. Choose which kind of reports you want to be notified about. You can choose between being updated about all newly published or updated reports, or only those reports that have a certain tag or type.

5. Add at least one recipient to receive the notification emails. You can also use this screen to check how the notifications will be received, by sending a test email.
<!-- missing Screenshot of the recipients screen. There are three recipients listed, and a test email has been sent, as indicated by a green checkmark -->

6. Review your new rule. If there's anything you would like to change, select the Edit button at the end of each subsection. Once your review is complete, select the Create rule button.

Your new rule has been successfully created. Select the Done button to complete the process and close the flyout. Your new rule will now appear in the list of Threat analytics email notifications.

